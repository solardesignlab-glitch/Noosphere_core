import crypto from "crypto";
import mysql from "mysql2/promise";
import express from "express";
import cors from "cors";
import multer from "multer";
import OpenAI from "openai";
import dotenv from "dotenv";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

import {
  seedOwner,
  signToken,
  requireAuth,
  requireRole,
  registerUser,
  authenticateUser,
} from "./auth.js";

import healthRouter from "./src/routes/health.js";
import { errorHandler } from "./src/middleware/errors.js";
import { tenantContext } from "./src/shared/middleware/tenantContext.js";
import registerServiceRoutes from "./src/routes/services.js";

dotenv.config({ override: true });


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

const uploadsPath = path.join(__dirname, "uploads");

if (!fs.existsSync(uploadsPath)) {
  fs.mkdirSync(uploadsPath, { recursive: true });
}

const ALLOWED_IMAGE_TYPES = [
  "image/png",
  "image/jpeg",
  "image/webp",
  "image/gif",
];

const MAX_IMAGE_SIZE = 20 * 1024 * 1024;

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: MAX_IMAGE_SIZE,
  },
  fileFilter: (req, file, cb) => {
    if (ALLOWED_IMAGE_TYPES.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error("�������������� PNG, JPEG, WEBP � ��������������� GIF"));
    }
  },
});

const mediaUpload = multer({
  storage: multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, uploadsPath);
    },
    filename: (req, file, cb) => {
      const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
      const extension = path.extname(file.originalname);

      cb(null, `${uniqueSuffix}${extension}`);
    },
  }),
  limits: {
    fileSize: MAX_IMAGE_SIZE,
  },
  fileFilter: (req, file, cb) => {
    if (ALLOWED_IMAGE_TYPES.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error("�������������� PNG, JPEG, WEBP � ��������������� GIF"));
    }
  },
});

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const ESPO_URL = process.env.ESPOCRM_URL;
const ESPO_KEY = process.env.ESPOCRM_API_KEY;

async function espocrmRequest(path, options = {}) {
  const requestUrl = `${ESPO_URL}/api/v1${path}`;

  console.log("ESPOCRM_REQUEST_URL:", requestUrl);

  const response = await fetch(requestUrl, {
    ...options,
    headers: {
      "X-Api-Key": ESPO_KEY,
      "Content-Type": "application/json",
      ...(options.headers || {}),
    },
  });

  const text = await response.text();

  if (!response.ok) {
    console.error("ESPOCRM_ERROR:", response.status, text);

    throw Object.assign(new Error(`EspoCRM API error: ${response.status}`), {
      status: response.status,
    });
  }

  try {
    return JSON.parse(text);
  } catch (error) {
    throw Object.assign(new Error("EspoCRM ������ ������������ JSON"), {
      status: 502,
    });
  }
}

const DESIGN_SYSTEM_PROMPT = `
�� � AI-��������� ��������� ����������.


���� ������� ���� � ������-������� ����������� � ���-�������.


�������� ��������:
���������� � ����������� ����� �������: CRM, ������, �������,
��������� � AI-�������� ��� �������� � ����� �����.
������ �������� ������ ���� �. �. �����������:
�����������, �����, ����������, �������� ���������� � ��������.


�������� ���������� �������:
- ���: #F6F7FB;
- �����������: #FFFFFF;
- �������: #E6E8EF;
- �������� �����: #1F2430;
- ��������� �����: #6B7280;
- �������� ������: #2563EB;
- ������ ������: #EFF4FF;
- �����: #16A34A;
- ��������������: #D97706;
- ������: #DC2626;
- AI-������: #7C3AED;
- �������: 10�24 px;
- ������ ����;
- ������ �����, ����� �������.


�������:
1. ������� �� ������� �����.
2. ���������� ����������� ��� UI/UX-�������.
3. �������� ��������, ����������, ��������, ��������� ��������,
   ��������� ����������, ���������� ���� � ������������ ������� ����������.
4. ����� ���������� ������������, � �� ����� �����.
5. ���� ������ �������� ���������, ��������, ����� �������� � ������.
6. ���� ������ �� ��������� ������������, ����� ����� �� ����.
7. �� ��������� �������, �������� �������� ��� ������.
8. �� ����� �������������� ������������.
9. ��������� ��������� � �������: ���������� > �������� > ������������ > ��������� ������.


������ ������:
## ������� �����
1�2 �����������.


## ��� �������� ������
2�4 ������.


## ��� ��������
3�6 �������.


## ������������
���������� ��������� �� ������ ����������.


## ��������� ���
���� ������������ ��������.
`;

const CODE_SYSTEM_PROMPT = `
�� � senior frontend-����������� � ���������� ������� ����������.


���� ������ � ���������� ��������� ���� React-����������.


����:
- React;
- Vite;
- JavaScript;
- CSS � BEM-��������� ��������;
- EspoCRM REST API.


������-�������:
- ���: #F6F7FB;
- �����������: #FFFFFF;
- �������: #E6E8EF;
- �����: #1F2430;
- ��������� �����: #6B7280;
- �������� ������: #2563EB;
- ������ ������: #EFF4FF;
- �������: 10�24 px;
- ������ ����.


�������:
1. ������� ������ �� ������� �����.
2. ������� ��� ������� ���� ���������.
3. ����� ����� unified diff.
4. �� ��������� �����, ������� ��� � ���������.
5. �� ������� .env, node_modules, dist � .git.
6. �� �������� ������������� ��������.
7. ���� ������ ������������, ������� �������� ������ ����.
8. �������� ������������ ����� ���� � ������.
9. �� ��������� ��������� ������ ��� ����� �������������.


������ ������ ������ �����:
### ����
- ����� 1
- ����� 2


### DIFF
\`\`\`diff
������ unified diff
\`\`\`


### ���������
������� ���������� ���������.
`;

app.use(
  cors({
    origin: "http://localhost:5173",
  }),
);

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/uploads", express.static(uploadsPath));
app.use("/api/v1", healthRouter);

app.get("/api/health", (req, res) => {
  res.json({
    status: "ok",
    service: "atmosfera-backend",
  });
});

app.post(
  "/api/auth/register",
  requireAuth,
  requireRole("owner"),
  async (req, res) => {
    try {
      const { email, password, role } = req.body || {};

      const user = await registerUser({ email, password, role });

      res.status(201).json({ user });
    } catch (error) {
      res.status(error.status || 500).json({
        detail: error.message || "�� ������� ������� ������������",
      });
    }
  },
);

app.post("/api/auth/login", async (req, res) => {
  try {
    const { email, password } = req.body || {};

    const user = await authenticateUser({ email, password });
    const token = await signToken(user);

    res.json({
      token,
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
        organizationId: user.organizationId,
      },
    });
  } catch (error) {
    res.status(error.status || 500).json({
      detail: error.message || "�� ������� ��������� ����",
    });
  }
});

app.get("/api/auth/me", requireAuth, (req, res) => {
  res.json({ user: req.user });
});

app.get(
  "/api/records/sessions",
  requireAuth,
  tenantContext,
  async (req, res) => {
    try {
      const limit = Number(req.query.limit || 10);
      const now = new Date();

      const nowLocal = new Date(now.getTime() - now.getTimezoneOffset() * 60000)
        .toISOString()
        .slice(0, 19)
        .replace("T", " ");

      const where = JSON.stringify([
        {
          type: "after",
          attribute: "startAt",
          value: nowLocal,
        },
      ]);

      const query = new URLSearchParams({
        maxSize: String(limit),
        orderBy: "startAt",
        order: "asc",
        where,
        select: "id,name,status,startAt,endAt,specialistName",
      });

      const data = await espocrmRequest(`/Session?${query}`);

      res.json(data);
    } catch (error) {
      console.error(error);

      res.status(error.status || 500).json({
        error: error.message || "�� ������� �������� ������",
      });
    }
  },
);

app.get(
  "/api/records/sessions/:id",
  requireAuth,
  tenantContext,
  async (req, res) => {
    try {
      const data = await espocrmRequest(`/Session/${req.params.id}`);

      res.json(data);
    } catch (error) {
      console.error(error);

      res.status(error.status || 500).json({
        error: error.message || "�� ������� �������� ������",
      });
    }
  },
);

app.put(
  "/api/records/sessions/:id",
  requireAuth,
  tenantContext,
  express.json(),
  async (req, res) => {
    try {
      const { status } = req.body || {};

      if (!status) {
        return res.status(400).json({
          error: "����� ������",
        });
      }

      const data = await espocrmRequest(`/Session/${req.params.id}`, {
        method: "PUT",
        body: JSON.stringify({ status }),
      });

      res.json(data);
    } catch (error) {
      console.error(error);

      res.status(error.status || 500).json({
        error: error.message || "�� ������� �������� ������",
      });
    }
  },
);

app.post(
  "/api/agent/analyze-design",
  upload.single("image"),
  async (req, res) => {
    try {
      console.log("ANALYZE_DESIGN: ������ �������");
      console.log("ANALYZE_DESIGN: req.file =", req.file);
      console.log("ANALYZE_DESIGN: req.body =", req.body);

      const image = req.file;
      const { question } = req.body || {};

      if (!image) {
        return res.status(400).json({
          error: "����������� �� ��������",
        });
      }

      const base64Image = image.buffer.toString("base64");
      const imageUrl = `data:${image.mimetype};base64,${base64Image}`;

      const userQuestion =
        question ||
        "������������� ���� ��������� � �������� ��������� �������.";

      const analysisPrompt = `
������������� ����������� ����������.


����� ������ �������� JSON ��� markdown, ��� ��������� � ��� ������ �� ��� ����� JSON.


������ ������:
{
  "summary": "������� �������� ����������",
  "strengths": ["������� �������"],
  "problems": [
    {
      "area": "������� ����������",
      "problem": "�������� ��������",
      "severity": "low | medium | high",
      "recommendation": "���������� ������������"
    }
  ],
  "next_steps": ["������������ ��������� ����"]
}


�������:
- severity ����� ���� ������ low, medium ��� high.
- �� ��������� �������, ������� ��� �� �����������.
- ���� ����������� �� ������ �� ���������, ����� ��� � summary.
- ������� �� ������� �����.


������ ������������:
${userQuestion}
`.trim();

      const response = await client.responses.create({
        model: process.env.VISION_MODEL || "moondream",
        input: [
          {
            role: "system",
            content: DESIGN_SYSTEM_PROMPT,
          },
          {
            role: "user",
            content: [
              {
                type: "input_text",
                text: analysisPrompt,
              },
              {
                type: "input_image",
                image_url: imageUrl,
              },
            ],
          },
        ],
      });

      const rawAnswer = response.output_text || "";
      let analysis;

      try {
        analysis = JSON.parse(rawAnswer);
      } catch (parseError) {
        const jsonMatch = rawAnswer.match(/\{[\s\S]*\}/);

        if (!jsonMatch) {
          return res.status(502).json({
            error: "������ ������� ����� �� � ������� JSON",
            raw_answer: rawAnswer,
          });
        }

        try {
          analysis = JSON.parse(jsonMatch[0]);
        } catch (secondParseError) {
          return res.status(502).json({
            error: "�� ������� ��������� JSON-����� ������",
            raw_answer: rawAnswer,
          });
        }
      }

      res.json({
        answer: rawAnswer,
        analysis,
      });
    } catch (error) {
      console.error("ANALYZE_DESIGN_ERROR:");
      console.error(error);
      console.error("ERROR_MESSAGE:", error?.message);
      console.error("ERROR_STACK:", error?.stack);

      res.status(500).json({
        error: "�� ������� ���������������� �����������",
      });
    }
  },
);

app.get("/api/media", requireAuth, tenantContext, (req, res) => {
  try {
    const files = fs
      .readdirSync(uploadsPath)
      .filter((name) => {
        return /\.(png|jpe?g|webp|gif)$/i.test(name);
      })
      .map((name) => ({
        id: name,
        name,
        url: `http://localhost:4000/uploads/${name}`,
      }));

    res.json({
      files,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: "�� ������� �������� ����������",
    });
  }
});

app.post(
  "/api/media",
  requireAuth,
  tenantContext,
  mediaUpload.single("image"),
  (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({
          error: "����������� �� ��������",
        });
      }

      res.json({
        id: req.file.filename,
        name: req.file.originalname,
        url: `http://localhost:4000/uploads/${req.file.filename}`,
      });
    } catch (error) {
      console.error(error);

      res.status(500).json({
        error: "�� ������� ��������� �����������",
      });
    }
  },
);

app.delete("/api/media/:fileName", requireAuth, tenantContext, (req, res) => {
  try {
    const fileName = path.basename(req.params.fileName);
    const filePath = path.join(uploadsPath, fileName);

    if (!fs.existsSync(filePath)) {
      return res.status(404).json({
        error: "���� �� ������",
      });
    }

    fs.unlinkSync(filePath);

    res.json({
      success: true,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: "�� ������� ������� ����",
    });
  }
});

app.post(
  "/api/ai/chat",
  requireAuth,
  tenantContext,
  express.json(),
  async (req, res) => {
    try {
      const { message, history = [] } = req.body;

      if (!message) {
        return res.status(400).json({ detail: "��������� �� ��������" });
      }

      const ollamaResponse = await fetch("http://localhost:11434/api/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          model: process.env.LLM_MODEL || "qwen2.5:7b",
          messages: [
            {
              role: "system",
              content:
                "�� AI-�������� CRM ������ ����������. ������� ������, ������� � �� ������� �����.",
            },
            ...history.map((item) => ({
              role: item.role,
              content: item.content,
            })),
            {
              role: "user",
              content: message,
            },
          ],
          stream: false,
        }),
      });

      const data = await ollamaResponse.json();

      if (!ollamaResponse.ok) {
        return res.status(ollamaResponse.status).json({
          detail: data.error || "Ollama �� ��������",
        });
      }

      return res.json({
        reply: data?.message?.content || "������ ������� ������ �����.",
      });
    } catch (error) {
      console.error("AI chat error:", error);
      return res.status(500).json({
        detail: "�� ������� �������� ����� �� Ollama",
      });
    }
  },
);

app.get("/api/models", requireAuth, async (req, res) => {
  try {
    const response = await client.models.list();
    const models = [];

    for await (const model of response) {
      models.push({
        id: model.id,
        ownedBy: model.owned_by,
        created: model.created,
      });
    }

    res.json({
      models,
    });
  } catch (error) {
    console.error(error);

    res.status(500).json({
      error: "�� ������� �������� ������ �������",
    });
  }
});

app.post(
  "/api/agent/propose-code",
  requireAuth,
  tenantContext,
  requireRole(["owner", "admin"]),
  express.json(),
  async (req, res) => {
    try {
      const { task, filePath, fileContent } = req.body;

      if (!task || !filePath || !fileContent) {
        return res.status(400).json({
          error: "����� ���� task, filePath � fileContent",
        });
      }

      const response = await client.responses.create({
        model: process.env.LLM_MODEL || "qwen2.5:7b",
        input: [
          {
            role: "system",
            content: CODE_SYSTEM_PROMPT,
          },
          {
            role: "user",
            content: [
              {
                type: "input_text",
                text: `������:\n${task}\n\n����:\n${filePath}\n\n������� ���:\n\`\`\`\n${fileContent}\n\`\`\``,
              },
            ],
          },
        ],
      });

      const answer = response.output_text || "";

      const planMatch = answer.match(/### ����([\s\S]*?)(### DIFF|$)/);
      const diffMatch = answer.match(/```diff([\s\S]*?)```/);

      const plan = planMatch
        ? planMatch[1]
            .split("\n")
            .map((line) => line.replace(/^[-*\s]+/, "").trim())
            .filter(Boolean)
        : [];

      const diff = diffMatch ? diffMatch[1].trim() : "";

      res.json({
        answer,
        plan,
        diff,
      });
    } catch (error) {
      console.error(error);

      res.status(500).json({
        error: "�� ������� ���������� ��������� ����",
      });
    }
  },
);

const dbPool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
});

app.get("/api/parts", requireAuth, tenantContext, async (req, res) => {
  try {
    const [rows] = await dbPool.query(
      `SELECT id, organization_id, sku, name, brand, price, stock_qty, is_active, created_at, updated_at
       FROM parts
       ORDER BY id DESC
       LIMIT 100`,
    );

    res.json({
      items: rows,
    });
  } catch (error) {
    console.error("PARTS_ERROR:", error);

    res.status(500).json({
      error: "�� ������� �������� ��������",
    });
  }
});

app.post("/api/parts", requireAuth, tenantContext, async (req, res) => {
  try {
    const { organizationId, sku, name, brand, price, stockQty, isActive } =
      req.body || {};

    if (!organizationId) {
      return res.status(400).json({
        error: "����� organizationId",
      });
    }

    if (!sku || typeof sku !== "string" || !sku.trim()) {
      return res.status(400).json({
        error: "����� sku",
      });
    }

    if (!name || typeof name !== "string" || !name.trim()) {
      return res.status(400).json({
        error: "����� �������� ��������",
      });
    }

    const normalizedPrice = Number(price ?? 0);

    if (Number.isNaN(normalizedPrice) || normalizedPrice < 0) {
      return res.status(400).json({
        error: "���� ������ ���� ��������������� ������",
      });
    }

    const normalizedStockQty = Number(stockQty ?? 0);

    if (!Number.isInteger(normalizedStockQty) || normalizedStockQty < 0) {
      return res.status(400).json({
        error: "stockQty ������ ���� ��������������� ����� ������",
      });
    }

    const [result] = await dbPool.query(
      `INSERT INTO parts
        (organization_id, sku, name, brand, price, stock_qty, is_active)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        organizationId,
        sku.trim(),
        name.trim(),
        brand?.trim() || null,
        normalizedPrice,
        normalizedStockQty,
        isActive === false ? 0 : 1,
      ],
    );

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, sku, name, brand, price, stock_qty, is_active, created_at, updated_at
       FROM parts
       WHERE id = ?`,
      [result.insertId],
    );

    res.status(201).json({
      item: rows[0],
    });
  } catch (error) {
    console.error("CREATE_PART_ERROR:", error);

    if (error?.code === "ER_DUP_ENTRY") {
      return res.status(409).json({
        error: "�������� � ����� SKU ��� ���������� � ���� �����������",
      });
    }

    res.status(500).json({
      error: "�� ������� ������� ��������",
    });
  }
});

app.put("/api/parts/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;
    const { organizationId, sku, name, brand, price, stockQty, isActive } =
      req.body || {};

    const [existing] = await dbPool.query(`SELECT id FROM parts WHERE id = ?`, [
      id,
    ]);

    if (existing.length === 0) {
      return res.status(404).json({
        error: "�������� �� �������",
      });
    }

    if (organizationId === undefined) {
      return res.status(400).json({
        error: "����� organizationId",
      });
    }

    if (!sku || typeof sku !== "string" || !sku.trim()) {
      return res.status(400).json({
        error: "����� sku",
      });
    }

    if (!name || typeof name !== "string" || !name.trim()) {
      return res.status(400).json({
        error: "����� �������� ��������",
      });
    }

    const normalizedPrice = Number(price ?? 0);

    if (Number.isNaN(normalizedPrice) || normalizedPrice < 0) {
      return res.status(400).json({
        error: "���� ������ ���� ��������������� ������",
      });
    }

    const normalizedStockQty = Number(stockQty ?? 0);

    if (!Number.isInteger(normalizedStockQty) || normalizedStockQty < 0) {
      return res.status(400).json({
        error: "stockQty ������ ���� ��������������� ����� ������",
      });
    }

    await dbPool.query(
      `UPDATE parts
       SET organization_id = ?,
           sku = ?,
           name = ?,
           brand = ?,
           price = ?,
           stock_qty = ?,
           is_active = ?
       WHERE id = ?`,
      [
        organizationId,
        sku.trim(),
        name.trim(),
        brand?.trim() || null,
        normalizedPrice,
        normalizedStockQty,
        isActive === false ? 0 : 1,
        id,
      ],
    );

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, sku, name, brand, price, stock_qty, is_active, created_at, updated_at
       FROM parts
       WHERE id = ?`,
      [id],
    );

    res.json({
      item: rows[0],
    });
  } catch (error) {
    console.error("UPDATE_PART_ERROR:", error);

    if (error?.code === "ER_DUP_ENTRY") {
      return res.status(409).json({
        error: "�������� � ����� SKU ��� ���������� � ���� �����������",
      });
    }

    res.status(500).json({
      error: "�� ������� �������� ��������",
    });
  }
});

app.delete("/api/parts/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;

    const [result] = await dbPool.query(`DELETE FROM parts WHERE id = ?`, [id]);

    if (result.affectedRows === 0) {
      return res.status(404).json({
        error: "�������� �� �������",
      });
    }

    res.json({
      success: true,
    });
  } catch (error) {
    console.error("DELETE_PART_ERROR:", error);

    res.status(500).json({
      error: "�� ������� ������� ��������",
    });
  }
});

// ==================== CLIENTS ====================

app.get("/api/clients", requireAuth, tenantContext, async (req, res) => {
  try {
    const organizationId = req.organizationId;

    if (!organizationId) {
      return res.status(400).json({
        error: "Организация не определена из токена",
      });
    }

    const search =
      typeof req.query.search === "string" ? req.query.search.trim() : "";

    let sql = `SELECT id, organization_id, name, phone, email, source, notes, created_at, updated_at
               FROM clients
               WHERE organization_id = ?`;
    const params = [organizationId];

    if (search) {
      sql += ` AND (name LIKE ? OR phone LIKE ? OR email LIKE ?)`;
      const like = `%${search}%`;
      params.push(like, like, like);
    }

    sql += ` ORDER BY created_at DESC LIMIT 200`;

    const [rows] = await dbPool.query(sql, params);

    res.json({
      items: rows,
    });
  } catch (error) {
    console.error("CLIENTS_LIST_ERROR:", error);

    res.status(500).json({
      error: "Не удалось получить список клиентов",
    });
  }
});

app.post("/api/clients", requireAuth, tenantContext, async (req, res) => {
  try {
    const organizationId = req.organizationId;

    if (!organizationId) {
      return res.status(400).json({
        error: "Организация не определена из токена",
      });
    }

    const { name, phone, email, source, notes } = req.body || {};

    if (!name || typeof name !== "string" || !name.trim()) {
      return res.status(400).json({
        error: "Укажите имя клиента",
      });
    }

    const id = crypto.randomUUID();

    await dbPool.query(
      `INSERT INTO clients (id, organization_id, name, phone, email, source, notes)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        id,
        organizationId,
        name.trim(),
        phone || null,
        email || null,
        source || null,
        notes || null,
      ],
    );

    res.status(201).json({
      item: {
        id,
        organization_id: organizationId,
        name: name.trim(),
        phone: phone || null,
        email: email || null,
        source: source || null,
        notes: notes || null,
      },
    });
  } catch (error) {
    console.error("CLIENTS_CREATE_ERROR:", error);

    res.status(500).json({
      error: "Не удалось создать клиента",
    });
  }
});

app.put("/api/clients/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const organizationId = req.organizationId;
    const { id } = req.params;
    const { name, phone, email, source, notes } = req.body || {};

    const [existing] = await dbPool.query(
      `SELECT id FROM clients WHERE id = ? AND organization_id = ?`,
      [id, organizationId],
    );

    if (existing.length === 0) {
      return res.status(404).json({
        error: "Клиент не найден",
      });
    }

    if (name !== undefined && (!name || !String(name).trim())) {
      return res.status(400).json({
        error: "Укажите имя клиента",
      });
    }

    await dbPool.query(
      `UPDATE clients
       SET name = COALESCE(?, name),
           phone = COALESCE(?, phone),
           email = COALESCE(?, email),
           source = COALESCE(?, source),
           notes = COALESCE(?, notes),
           updated_at = NOW()
       WHERE id = ? AND organization_id = ?`,
      [
        name !== undefined ? String(name).trim() : null,
        phone || null,
        email || null,
        source || null,
        notes || null,
        id,
        organizationId,
      ],
    );

    res.json({
      success: true,
    });
  } catch (error) {
    console.error("CLIENTS_UPDATE_ERROR:", error);

    res.status(500).json({
      error: "Не удалось обновить клиента",
    });
  }
});

app.delete("/api/clients/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const organizationId = req.organizationId;
    const { id } = req.params;

    const [result] = await dbPool.query(
      `DELETE FROM clients WHERE id = ? AND organization_id = ?`,
      [id, organizationId],
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({
        error: "Клиент не найден",
      });
    }

    res.json({
      success: true,
    });
  } catch (error) {
    console.error("CLIENTS_DELETE_ERROR:", error);

    res.status(500).json({
      error: "Не удалось удалить клиента",
    });
  }
});

registerServiceRoutes(app, dbPool);

await seedOwner();

app.listen(process.env.PORT || 4000, () => {
  console.log(
    `AI backend �������: http://localhost:${process.env.PORT || 4000}`,
  );
});
