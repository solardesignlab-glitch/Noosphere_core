import mysql from "mysql2/promise";
import express from "express";
import cors from "cors";
import multer from "multer";
import OpenAI from "openai";
import dotenv from "dotenv";
import fs from "fs";
import crypto from "crypto";
import path from "path";
import { fileURLToPath } from "url";


import {
  seedOwner,
  signToken,
  requireAuth,
  requireRole,
  registerUser,
  authenticateUser
} from "./auth.js";


import healthRouter from "./src/routes/health.js";
import { errorHandler } from "./src/middleware/errors.js";
import { tenantContext } from "./src/shared/middleware/tenantContext.js";
import pool from "./src/shared/db/pool.js";


dotenv.config();


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
  "image/gif"
];


const MAX_IMAGE_SIZE = 20 * 1024 * 1024;


const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: MAX_IMAGE_SIZE
  },
  fileFilter: (req, file, cb) => {
    if (ALLOWED_IMAGE_TYPES.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error("Поддерживаются PNG, JPEG, WEBP и неанимированный GIF"));
    }
  }
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
    }
  }),
  limits: {
    fileSize: MAX_IMAGE_SIZE
  },
  fileFilter: (req, file, cb) => {
    if (ALLOWED_IMAGE_TYPES.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error("Поддерживаются PNG, JPEG, WEBP и неанимированный GIF"));
    }
  }
});


const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
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
      ...(options.headers || {})
    }
  });


  const text = await response.text();


  if (!response.ok) {
    console.error("ESPOCRM_ERROR:", response.status, text);


    throw Object.assign(
      new Error(`EspoCRM API error: ${response.status}`),
      { status: response.status }
    );
  }


  try {
    return JSON.parse(text);
  } catch (error) {
    throw Object.assign(
      new Error("EspoCRM вернул некорректный JSON"),
      { status: 502 }
    );
  }
}


const DESIGN_SYSTEM_PROMPT = `
Ты — AI-ассистент платформы «Атмосфера».


Твоя текущая роль — дизайн-ревьюер интерфейсов и веб-страниц.


Контекст продукта:
«Атмосфера» — управляемая среда бизнеса: CRM, записи, клиенты,
аналитика и AI-помощник для компаний в сфере услуг.
Дизайн строится вокруг идей В. И. Вернадского:
целостность, связи, слоистость, разумное управление и развитие.


Основная визуальная система:
- фон: #F6F7FB;
- поверхности: #FFFFFF;
- границы: #E6E8EF;
- основной текст: #1F2430;
- вторичный текст: #6B7280;
- основной акцент: #2563EB;
- мягкий акцент: #EFF4FF;
- успех: #16A34A;
- предупреждение: #D97706;
- ошибка: #DC2626;
- AI-акцент: #7C3AED;
- радиусы: 10–24 px;
- мягкие тени;
- чистая сетка, много воздуха.


Правила:
1. Отвечай на русском языке.
2. Анализируй изображение как UI/UX-ревьюер.
3. Оценивай иерархию, читаемость, контраст, семантику статусов,
   плотность информации, визуальный ритм и соответствие системе «Атмосфера».
4. Давай конкретные рекомендации, а не общие слова.
5. Если просят изменить интерфейс, указывай, какие элементы и почему.
6. Если данных на скриншоте недостаточно, прямо скажи об этом.
7. Не выдумывай метрики, названия разделов или данные.
8. Не давай инвестиционных рекомендаций.
9. Предлагай изменения в формате: наблюдение → проблема → рекомендация → ожидаемый эффект.


Формат ответа:
## Краткий вывод
1–2 предложения.


## Что работает хорошо
2–4 пункта.


## Что улучшить
3–6 пунктов.


## Рекомендации
Конкретные изменения по блокам интерфейса.


## Следующий шаг
Одно практическое действие.
`;


const CODE_SYSTEM_PROMPT = `
Ты — senior frontend-разработчик и архитектор проекта «Атмосфера».


Твоя задача — предлагать изменения кода React-приложения.


Стек:
- React;
- Vite;
- JavaScript;
- CSS с BEM-подобными классами;
- EspoCRM REST API.


Дизайн-система:
- фон: #F6F7FB;
- поверхности: #FFFFFF;
- границы: #E6E8EF;
- текст: #1F2430;
- вторичный текст: #6B7280;
- основной акцент: #2563EB;
- мягкий акцент: #EFF4FF;
- радиусы: 10–24 px;
- мягкие тени.


Правила:
1. Отвечай только на русском языке.
2. Сначала дай краткий план изменений.
3. Затем верни unified diff.
4. Не выдумывай файлы, которых нет в контексте.
5. Не изменяй .env, node_modules, dist и .git.
6. Не выполняй деструктивные действия.
7. Если данных недостаточно, попроси прислать нужный файл.
8. Сохраняй существующий стиль кода и классы.
9. Не предлагай изменения данных без явной необходимости.


Формат ответа строго такой:
### ПЛАН
- пункт 1
- пункт 2


### DIFF
\`\`\`diff
полный unified diff
\`\`\`


### ПОЯСНЕНИЕ
Краткое объяснение изменений.
`;


app.use(
  cors({
    origin: "http://localhost:5173"
  })
);


app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/uploads", express.static(uploadsPath));
app.use("/api/v1", healthRouter);


app.get("/api/health", (req, res) => {
  res.json({
    status: "ok",
    service: "atmosfera-backend"
  });
});


app.post("/api/auth/register", requireAuth, requireRole("owner"), async (req, res) => {
  try {
    const { email, password, role } = req.body || {};


    const user = await registerUser({ email, password, role });


    res.status(201).json({ user });
  } catch (error) {
    res.status(error.status || 500).json({
      detail: error.message || "Не удалось создать пользователя"
    });
  }
});


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
        organizationId: user.organizationId
      }
    });
  } catch (error) {
    res.status(error.status || 500).json({
      detail: error.message || "Не удалось выполнить вход"
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


      const nowLocal = new Date(
        now.getTime() - now.getTimezoneOffset() * 60000
      )
        .toISOString()
        .slice(0, 19)
        .replace("T", " ");


      const where = JSON.stringify([
        {
          type: "after",
          attribute: "startAt",
          value: nowLocal
        }
      ]);


      const query = new URLSearchParams({
        maxSize: String(limit),
        orderBy: "startAt",
        order: "asc",
        where,
        select: "id,name,status,startAt,endAt,specialistName"
      });


      const data = await espocrmRequest(`/Session?${query}`);


      res.json(data);
    } catch (error) {
      console.error(error);


      res.status(error.status || 500).json({
        error: error.message || "Не удалось получить записи"
      });
    }
  }
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
        error: error.message || "Не удалось получить запись"
      });
    }
  }
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
          error: "Нужен статус"
        });
      }


      const data = await espocrmRequest(`/Session/${req.params.id}`, {
        method: "PUT",
        body: JSON.stringify({ status })
      });


      res.json(data);
    } catch (error) {
      console.error(error);


      res.status(error.status || 500).json({
        error: error.message || "Не удалось обновить запись"
      });
    }
  }
);


app.post(
  "/api/agent/analyze-design",
  upload.single("image"),
  async (req, res) => {
    try {
      console.log("ANALYZE_DESIGN: запрос получен");
      console.log("ANALYZE_DESIGN: req.file =", req.file);
      console.log("ANALYZE_DESIGN: req.body =", req.body);


      const image = req.file;
      const { question } = req.body || {};


      if (!image) {
        return res.status(400).json({
          error: "Изображение не передано"
        });
      }


      const base64Image = image.buffer.toString("base64");
      const imageUrl = `data:${image.mimetype};base64,${base64Image}`;


      const userQuestion =
        question ||
        "Проанализируй этот интерфейс и предложи улучшения дизайна.";


      const analysisPrompt = `
Проанализируй изображение интерфейса.


Верни ТОЛЬКО валидный JSON без markdown, без пояснений и без текста до или после JSON.


Формат ответа:
{
  "summary": "краткое описание интерфейса",
  "strengths": ["сильные стороны"],
  "problems": [
    {
      "area": "область интерфейса",
      "problem": "описание проблемы",
      "severity": "low | medium | high",
      "recommendation": "конкретная рекомендация"
    }
  ],
  "next_steps": ["приоритетные следующие шаги"]
}


Правила:
- severity может быть только low, medium или high.
- Не выдумывай функции, которых нет на изображении.
- Если изображение не похоже на интерфейс, укажи это в summary.
- Отвечай на русском языке.


Вопрос пользователя:
${userQuestion}
`.trim();


      const response = await client.responses.create({
        model: process.env.VISION_MODEL || "moondream",
        input: [
          {
            role: "system",
            content: DESIGN_SYSTEM_PROMPT
          },
          {
            role: "user",
            content: [
              {
                type: "input_text",
                text: analysisPrompt
              },
              {
                type: "input_image",
                image_url: imageUrl
              }
            ]
          }
        ]
      });


      const rawAnswer = response.output_text || "";
      let analysis;


      try {
        analysis = JSON.parse(rawAnswer);
      } catch (parseError) {
        const jsonMatch = rawAnswer.match(/\{[\s\S]*\}/);


        if (!jsonMatch) {
          return res.status(502).json({
            error: "Модель вернула ответ не в формате JSON",
            raw_answer: rawAnswer
          });
        }


        try {
          analysis = JSON.parse(jsonMatch[0]);
        } catch (secondParseError) {
          return res.status(502).json({
            error: "Не удалось разобрать JSON-ответ модели",
            raw_answer: rawAnswer
          });
        }
      }


      res.json({
        answer: rawAnswer,
        analysis
      });
    } catch (error) {
      console.error("ANALYZE_DESIGN_ERROR:");
      console.error(error);
      console.error("ERROR_MESSAGE:", error?.message);
      console.error("ERROR_STACK:", error?.stack);


      res.status(500).json({
        error: "Не удалось проанализировать изображение"
      });
    }
  }
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
        url: `http://localhost:4000/uploads/${name}`
      }));


    res.json({
      files
    });
  } catch (error) {
    console.error(error);


    res.status(500).json({
      error: "Не удалось получить медиафайлы"
    });
  }
});


app.post("/api/media", requireAuth, tenantContext, mediaUpload.single("image"), (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        error: "Изображение не передано"
      });
    }


    res.json({
      id: req.file.filename,
      name: req.file.originalname,
      url: `http://localhost:4000/uploads/${req.file.filename}`
    });
  } catch (error) {
    console.error(error);


    res.status(500).json({
      error: "Не удалось загрузить изображение"
    });
  }
});


app.delete("/api/media/:fileName", requireAuth, tenantContext, (req, res) => {
  try {
    const fileName = path.basename(req.params.fileName);
    const filePath = path.join(uploadsPath, fileName);


    if (!fs.existsSync(filePath)) {
      return res.status(404).json({
        error: "Файл не найден"
      });
    }


    fs.unlinkSync(filePath);


    res.json({
      success: true
    });
  } catch (error) {
    console.error(error);


    res.status(500).json({
      error: "Не удалось удалить файл"
    });
  }
});


app.post("/api/ai/chat", requireAuth, tenantContext, express.json(), async (req, res) => {
  try {
    const { message, history = [] } = req.body;


    if (!message) {
      return res.status(400).json({ detail: "Сообщение не передано" });
    }


    const ollamaResponse = await fetch("http://localhost:11434/api/chat", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        model: process.env.LLM_MODEL || "qwen2.5:7b",
        messages: [
          {
            role: "system",
            content:
              "Ты AI-помощник CRM салона «Атмосфера». Отвечай кратко, понятно и на русском языке."
          },
          ...history.map((item) => ({
            role: item.role,
            content: item.content
          })),
          {
            role: "user",
            content: message
          }
        ],
        stream: false
      })
    });


    const data = await ollamaResponse.json();


    if (!ollamaResponse.ok) {
      return res.status(ollamaResponse.status).json({
        detail: data.error || "Ollama не ответила"
      });
    }


    return res.json({
      reply: data?.message?.content || "Модель вернула пустой ответ."
    });
  } catch (error) {
    console.error("AI chat error:", error);
    return res.status(500).json({
      detail: "Не удалось получить ответ от Ollama"
    });
  }
});


app.get("/api/models", requireAuth, async (req, res) => {
  try {
    const response = await client.models.list();
    const models = [];


    for await (const model of response) {
      models.push({
        id: model.id,
        ownedBy: model.owned_by,
        created: model.created
      });
    }


    res.json({
      models
    });
  } catch (error) {
    console.error(error);


    res.status(500).json({
      error: "Не удалось получить список моделей"
    });
  }
});


app.post("/api/agent/propose-code", requireAuth, tenantContext, requireRole(["owner", "admin"]), express.json(), async (req, res) => {
  try {
    const { task, filePath, fileContent } = req.body;


    if (!task || !filePath || !fileContent) {
      return res.status(400).json({
        error: "Нужны поля task, filePath и fileContent"
      });
    }


    const response = await client.responses.create({
      model: process.env.LLM_MODEL || "qwen2.5:7b",
      input: [
        {
          role: "system",
          content: CODE_SYSTEM_PROMPT
        },
        {
          role: "user",
          content: [
            {
              type: "input_text",
              text: `Задача:\n${task}\n\nФайл:\n${filePath}\n\nТекущий код:\n\`\`\`\n${fileContent}\n\`\`\``
            }
          ]
        }
      ]
    });


    const answer = response.output_text || "";


    const planMatch = answer.match(/### ПЛАН([\s\S]*?)(### DIFF|$)/);
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
      diff
    });
  } catch (error) {
    console.error(error);


    res.status(500).json({
      error: "Не удалось предложить изменения кода"
    });
  }
});


const dbPool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10
});


app.get("/api/parts", requireAuth, tenantContext, async (req, res) => {
  try {
    const [rows] = await dbPool.query(
      `SELECT id, organization_id, sku, name, brand, price, stock_qty, is_active, created_at, updated_at
       FROM parts
       WHERE organization_id = ?
       ORDER BY id DESC
       LIMIT 100`,
      [req.organizationId]
    );

    res.json({
      items: rows
    });
  } catch (error) {
    console.error("PARTS_ERROR:", error);

    res.status(500).json({
      error: "Не удалось получить запчасти"
    });
  }
});

app.post("/api/parts", requireAuth, tenantContext, async (req, res) => {
  try {
    const { sku, name, brand, price, stockQty, isActive } = req.body || {};

    const organizationId = req.organizationId;



    if (!sku || typeof sku !== "string" || !sku.trim()) {
      return res.status(400).json({
        error: "Нужен sku"
      });
    }


    if (!name || typeof name !== "string" || !name.trim()) {
      return res.status(400).json({
        error: "Нужно название запчасти"
      });
    }


    const normalizedPrice = Number(price ?? 0);


    if (Number.isNaN(normalizedPrice) || normalizedPrice < 0) {
      return res.status(400).json({
        error: "Цена должна быть неотрицательным числом"
      });
    }


    const normalizedStockQty = Number(stockQty ?? 0);


    if (!Number.isInteger(normalizedStockQty) || normalizedStockQty < 0) {
      return res.status(400).json({
        error: "stockQty должен быть неотрицательным целым числом"
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
        isActive === false ? 0 : 1
      ]
    );


    const [rows] = await dbPool.query(
      `SELECT id, organization_id, sku, name, brand, price, stock_qty, is_active, created_at, updated_at
       FROM parts
       WHERE id = ?`,
      [result.insertId]
    );


    res.status(201).json({
      item: rows[0]
    });
  } catch (error) {
    console.error("CREATE_PART_ERROR:", error);


    if (error?.code === "ER_DUP_ENTRY") {
      return res.status(409).json({
        error: "Запчасть с таким SKU уже существует в этой организации"
      });
    }


    res.status(500).json({
      error: "Не удалось создать запчасть"
    });
  }
});

// ==================== CLIENTS ====================

app.get("/api/clients", requireAuth, tenantContext, async (req, res) => {
  try {
    const search = String(req.query.search || "").trim();

    let sql = `
      SELECT id, organization_id, person_id, source, name, phone, email,
             notes, is_active, created_at, updated_at
      FROM clients
      WHERE organization_id = ?
    `;
    const params = [req.organizationId];

    if (search) {
      sql += ` AND (name LIKE ? OR phone LIKE ? OR email LIKE ?)`;
      const like = `%${search}%`;
      params.push(like, like, like);
    }

    sql += ` ORDER BY name ASC LIMIT 200`;

    const [rows] = await dbPool.query(sql, params);
    res.json({ clients: rows });
  } catch (error) {
    console.error("GET_CLIENTS_ERROR:", error);
    res.status(500).json({ error: "Не удалось получить клиентов" });
  }
});

app.post("/api/clients", requireAuth, tenantContext, async (req, res) => {
  try {
    const { name, phone, email, notes, source, isActive = true } = req.body || {};

    if (!name || !String(name).trim()) {
      return res.status(400).json({ error: "Укажите имя клиента" });
    }

    const id = crypto.randomUUID();

    await dbPool.query(
      `INSERT INTO clients
        (id, organization_id, person_id, source, name, phone, email, notes, is_active)
       VALUES (?, ?, NULL, ?, ?, ?, ?, ?, ?)`,
      [
        id,
        req.organizationId,
        source || null,
        String(name).trim(),
        phone || null,
        email || null,
        notes || null,
        isActive ? 1 : 0
      ]
    );

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, person_id, source, name, phone, email,
              notes, is_active, created_at, updated_at
       FROM clients
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    res.status(201).json({ client: rows[0] });
  } catch (error) {
    console.error("CREATE_CLIENT_ERROR:", error);
    res.status(500).json({ error: "Не удалось создать клиента" });
  }
});

app.get("/api/clients/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, person_id, source, name, phone, email,
              notes, is_active, created_at, updated_at
       FROM clients
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (!rows.length) {
      return res.status(404).json({ error: "Клиент не найден" });
    }

    res.json({ client: rows[0] });
  } catch (error) {
    console.error("GET_CLIENT_ERROR:", error);
    res.status(500).json({ error: "Не удалось получить клиента" });
  }
});

app.put("/api/clients/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;
    const { name, phone, email, notes, source, isActive } = req.body || {};

    const [existing] = await dbPool.query(
      `SELECT id FROM clients WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (!existing.length) {
      return res.status(404).json({ error: "Клиент не найден" });
    }

    if (!name || !String(name).trim()) {
      return res.status(400).json({ error: "Укажите имя клиента" });
    }

    await dbPool.query(
      `UPDATE clients
       SET name = ?,
           phone = ?,
           email = ?,
           notes = ?,
           source = ?,
           is_active = ?
       WHERE id = ? AND organization_id = ?`,
      [
        String(name).trim(),
        phone || null,
        email || null,
        notes || null,
        source || null,
        isActive === false ? 0 : 1,
        id,
        req.organizationId
      ]
    );

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, person_id, source, name, phone, email,
              notes, is_active, created_at, updated_at
       FROM clients
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    res.json({ client: rows[0] });
  } catch (error) {
    console.error("UPDATE_CLIENT_ERROR:", error);
    res.status(500).json({ error: "Не удалось обновить клиента" });
  }
});

app.delete("/api/clients/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;

    const [result] = await dbPool.query(
      `DELETE FROM clients WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (!result.affectedRows) {
      return res.status(404).json({ error: "Клиент не найден" });
    }

    res.json({ ok: true });
  } catch (error) {
    console.error("DELETE_CLIENT_ERROR:", error);
    res.status(500).json({ error: "Не удалось удалить клиента" });
  }
});

// ==================== END CLIENTS ====================

app.put("/api/parts/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;
    const { sku, name, brand, price, stockQty, isActive } = req.body || {};

    const organizationId = req.organizationId;


    const [existing] = await dbPool.query(
      `SELECT id FROM parts WHERE id = ? AND organization_id = ?`,
      [id, organizationId]
    );


    if (existing.length === 0) {
      return res.status(404).json({
        error: "Запчасть не найдена"
      });
    }


    if (!sku || typeof sku !== "string" || !sku.trim()) {
      return res.status(400).json({
        error: "Нужен sku"
      });
    }


    if (!name || typeof name !== "string" || !name.trim()) {
      return res.status(400).json({
        error: "Нужно название запчасти"
      });
    }


    const normalizedPrice = Number(price ?? 0);


    if (Number.isNaN(normalizedPrice) || normalizedPrice < 0) {
      return res.status(400).json({
        error: "Цена должна быть неотрицательным числом"
      });
    }


    const normalizedStockQty = Number(stockQty ?? 0);


    if (!Number.isInteger(normalizedStockQty) || normalizedStockQty < 0) {
      return res.status(400).json({
        error: "stockQty должен быть неотрицательным целым числом"
      });
    }


    await dbPool.query(
      `UPDATE parts
       SET sku = ?,
           name = ?,
           brand = ?,
           price = ?,
           stock_qty = ?,
           is_active = ?
       WHERE id = ? AND organization_id = ?`,
      [
        sku.trim(),
        name.trim(),
        brand?.trim() || null,
        normalizedPrice,
        normalizedStockQty,
        isActive === false ? 0 : 1,
        id,
        organizationId
      ]
    );


    const [rows] = await dbPool.query(
      `SELECT id, organization_id, sku, name, brand, price, stock_qty, is_active, created_at, updated_at
       FROM parts
       WHERE id = ? AND organization_id = ?`,
      [id, organizationId]
    );


    res.json({
      item: rows[0]
    });
  } catch (error) {
    console.error("UPDATE_PART_ERROR:", error);


    if (error?.code === "ER_DUP_ENTRY") {
      return res.status(409).json({
        error: "Запчасть с таким SKU уже существует в этой организации"
      });
    }


    res.status(500).json({
      error: "Не удалось обновить запчасть"
    });
  }
});


app.delete("/api/parts/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;


   const [result] = await dbPool.query(
  `DELETE FROM parts WHERE id = ? AND organization_id = ?`,
  [id, req.organizationId]
);


    if (result.affectedRows === 0) {
      return res.status(404).json({
        error: "Запчасть не найдена"
      });
    }


    res.json({
      success: true
    });
  } catch (error) {
    console.error("DELETE_PART_ERROR:", error);


    res.status(500).json({
      error: "Не удалось удалить запчасть"
    });
  }
});

// ==================== SERVICES ====================

app.get("/api/services", requireAuth, tenantContext, async (req, res) => {
  try {
    const search = String(req.query.search || "").trim();

    let sql = `
      SELECT id, organization_id, name, description, price,
             duration_minutes, is_active, created_at, updated_at
      FROM services
      WHERE organization_id = ?
    `;
    const params = [req.organizationId];

    if (search) {
      sql += ` AND name LIKE ?`;
      params.push(`%${search}%`);
    }

    sql += ` ORDER BY name ASC LIMIT 200`;

    const [rows] = await dbPool.query(sql, params);
    res.json({ services: rows });
  } catch (error) {
    console.error("GET_SERVICES_ERROR:", error);
    res.status(500).json({ error: "Не удалось получить услуги" });
  }
});

app.post("/api/services", requireAuth, tenantContext, async (req, res) => {
  try {
    const {
      name,
      description,
      price = 0,
      durationMinutes = 60,
      isActive = true
    } = req.body || {};

    if (!name || !String(name).trim()) {
      return res.status(400).json({ error: "Укажите название услуги" });
    }

    const normalizedPrice = Number(price);
    const normalizedDuration = Number(durationMinutes);

    if (!Number.isFinite(normalizedPrice) || normalizedPrice < 0) {
      return res.status(400).json({ error: "Некорректная цена" });
    }

    if (!Number.isInteger(normalizedDuration) || normalizedDuration <= 0) {
      return res.status(400).json({ error: "Длительность должна быть больше 0 минут" });
    }

    const id = crypto.randomUUID();

    await dbPool.query(
      `INSERT INTO services
        (id, organization_id, name, description, price, duration_minutes, is_active)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        id,
        req.organizationId,
        String(name).trim(),
        description || null,
        normalizedPrice,
        normalizedDuration,
        isActive ? 1 : 0
      ]
    );

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, name, description, price,
              duration_minutes, is_active, created_at, updated_at
       FROM services
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    res.status(201).json({ service: rows[0] });
  } catch (error) {
    console.error("CREATE_SERVICE_ERROR:", error);
    res.status(500).json({ error: "Не удалось создать услугу" });
  }
});

app.get("/api/services/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, name, description, price,
              duration_minutes, is_active, created_at, updated_at
       FROM services
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (!rows.length) {
      return res.status(404).json({ error: "Услуга не найдена" });
    }

    res.json({ service: rows[0] });
  } catch (error) {
    console.error("GET_SERVICE_ERROR:", error);
    res.status(500).json({ error: "Не удалось получить услугу" });
  }
});

app.put("/api/services/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      description,
      price = 0,
      durationMinutes = 60,
      isActive
    } = req.body || {};

    const [existing] = await dbPool.query(
      `SELECT id FROM services WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (!existing.length) {
      return res.status(404).json({ error: "Услуга не найдена" });
    }

    if (!name || !String(name).trim()) {
      return res.status(400).json({ error: "Укажите название услуги" });
    }

    const normalizedPrice = Number(price);
    const normalizedDuration = Number(durationMinutes);

    if (!Number.isFinite(normalizedPrice) || normalizedPrice < 0) {
      return res.status(400).json({ error: "Некорректная цена" });
    }

    if (!Number.isInteger(normalizedDuration) || normalizedDuration <= 0) {
      return res.status(400).json({ error: "Длительность должна быть больше 0 минут" });
    }

    await dbPool.query(
      `UPDATE services
       SET name = ?,
           description = ?,
           price = ?,
           duration_minutes = ?,
           is_active = ?
       WHERE id = ? AND organization_id = ?`,
      [
        String(name).trim(),
        description || null,
        normalizedPrice,
        normalizedDuration,
        isActive === false ? 0 : 1,
        id,
        req.organizationId
      ]
    );

    const [rows] = await dbPool.query(
      `SELECT id, organization_id, name, description, price,
              duration_minutes, is_active, created_at, updated_at
       FROM services
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    res.json({ service: rows[0] });
  } catch (error) {
    console.error("UPDATE_SERVICE_ERROR:", error);
    res.status(500).json({ error: "Не удалось обновить услугу" });
  }
});

app.delete("/api/services/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;

    const [result] = await dbPool.query(
      `DELETE FROM services WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (!result.affectedRows) {
      return res.status(404).json({ error: "Услуга не найдена" });
    }

    res.json({ ok: true });
  } catch (error) {
    console.error("DELETE_SERVICE_ERROR:", error);
    res.status(500).json({ error: "Не удалось удалить услугу" });
  }
});

// ==================== END SERVICES ====================

// ==================== MASTERS ====================

app.get("/api/masters", requireAuth, tenantContext, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT id, name, phone, email, specialty, is_active, created_at, updated_at
       FROM masters
       WHERE organization_id = ?
       ORDER BY created_at DESC`,
      [req.organizationId]
    );

    res.json({ masters: rows });
  } catch (error) {
    console.error("GET_MASTERS_ERROR:", error);
    res.status(500).json({ message: "Не удалось получить мастеров" });
  }
});

app.post("/api/masters", requireAuth, tenantContext, async (req, res) => {
  try {
    const { name, phone, email, specialty, is_active } = req.body;

    if (!name || String(name).trim() === "") {
      return res.status(400).json({ message: "Укажите имя мастера" });
    }

    const id = crypto.randomUUID();

    await pool.query(
      `INSERT INTO masters
        (id, organization_id, name, phone, email, specialty, is_active)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        id,
        req.organizationId,
        String(name).trim(),
        phone || null,
        email || null,
        specialty || null,
        is_active === false ? 0 : 1,
      ]
    );

    const [rows] = await pool.query(
      `SELECT id, name, phone, email, specialty, is_active, created_at, updated_at
       FROM masters
       WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    res.status(201).json({ master: rows[0] });
  } catch (error) {
    console.error("CREATE_MASTER_ERROR:", error);
    res.status(500).json({ message: "Не удалось создать мастера" });
  }
});

app.get("/api/masters/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT id, name, phone, email, specialty, is_active, created_at, updated_at
       FROM masters
       WHERE id = ? AND organization_id = ?`,
      [req.params.id, req.organizationId]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: "Мастер не найден" });
    }

    res.json({ master: rows[0] });
  } catch (error) {
    console.error("GET_MASTER_ERROR:", error);
    res.status(500).json({ message: "Не удалось получить мастера" });
  }
});

app.put("/api/masters/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { name, phone, email, specialty, is_active } = req.body;

    const [existing] = await pool.query(
      `SELECT id FROM masters WHERE id = ? AND organization_id = ?`,
      [req.params.id, req.organizationId]
    );

    if (existing.length === 0) {
      return res.status(404).json({ message: "Мастер не найден" });
    }

    await pool.query(
      `UPDATE masters
       SET name = ?, phone = ?, email = ?, specialty = ?, is_active = ?
       WHERE id = ? AND organization_id = ?`,
      [
        name ?? existing[0].name,
        phone ?? null,
        email ?? null,
        specialty ?? null,
        is_active === false ? 0 : 1,
        req.params.id,
        req.organizationId,
      ]
    );

    const [rows] = await pool.query(
      `SELECT id, name, phone, email, specialty, is_active, created_at, updated_at
       FROM masters
       WHERE id = ? AND organization_id = ?`,
      [req.params.id, req.organizationId]
    );

    res.json({ master: rows[0] });
  } catch (error) {
    console.error("UPDATE_MASTER_ERROR:", error);
    res.status(500).json({ message: "Не удалось обновить мастера" });
  }
});

app.delete("/api/masters/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const [result] = await pool.query(
      `DELETE FROM masters WHERE id = ? AND organization_id = ?`,
      [req.params.id, req.organizationId]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Мастер не найден" });
    }

    res.json({ message: "Мастер удалён" });
  } catch (error) {
    console.error("DELETE_MASTER_ERROR:", error);
    res.status(500).json({ message: "Не удалось удалить мастера" });
  }
});

// ==================== APPOINTMENTS ====================

app.get("/api/appointments", requireAuth, tenantContext, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT
         a.id,
         a.client_id,
         a.master_id,
         a.service_id,
         a.starts_at,
         a.ends_at,
         a.status,
         a.notes,
         a.created_at,
         a.updated_at,
         c.name AS client_name,
         m.name AS master_name,
         s.name AS service_name
       FROM appointments a
       LEFT JOIN clients c ON c.id = a.client_id
       LEFT JOIN masters m ON m.id = a.master_id
       LEFT JOIN services s ON s.id = a.service_id
       WHERE a.organization_id = ?
       ORDER BY a.starts_at DESC`,
      [req.organizationId]
    );

    res.json({ appointments: rows });
  } catch (error) {
    console.error("GET_APPOINTMENTS_ERROR:", error);
    res.status(500).json({ message: "Не удалось получить записи" });
  }
});

app.post("/api/appointments", requireAuth, tenantContext, async (req, res) => {
  try {
    const { client_id, master_id, service_id, starts_at, ends_at, notes } = req.body || {};

    if (!client_id || !master_id || !service_id || !starts_at || !ends_at) {
      return res.status(400).json({
        message: "Укажите клиента, мастера, услугу, время начала и окончания",
      });
    }

    const start = new Date(starts_at);
    const end = new Date(ends_at);

    if (Number.isNaN(start.getTime()) || Number.isNaN(end.getTime())) {
      return res.status(400).json({ message: "Некорректное время записи" });
    }

    if (end <= start) {
      return res.status(400).json({
        message: "Время окончания должно быть позже времени начала",
      });
    }

    const [conflicts] = await pool.query(
      `SELECT id
       FROM appointments
       WHERE organization_id = ?
         AND master_id = ?
         AND status = 'scheduled'
         AND starts_at < ?
         AND ends_at > ?`,
      [req.organizationId, master_id, end, start]
    );

    if (conflicts.length > 0) {
      return res.status(409).json({
        message: "У мастера уже есть запись в это время",
      });
    }

    const id = crypto.randomUUID();

    await pool.query(
      `INSERT INTO appointments
        (id, organization_id, client_id, master_id, service_id, starts_at, ends_at, status, notes)
       VALUES (?, ?, ?, ?, ?, ?, ?, 'scheduled', ?)`,
      [id, req.organizationId, client_id, master_id, service_id, start, end, notes || null]
    );

    const [rows] = await pool.query(
      `SELECT
         a.*,
         c.name AS client_name,
         m.name AS master_name,
         s.name AS service_name
       FROM appointments a
       LEFT JOIN clients c ON c.id = a.client_id
       LEFT JOIN masters m ON m.id = a.master_id
       LEFT JOIN services s ON s.id = a.service_id
       WHERE a.id = ? AND a.organization_id = ?`,
      [id, req.organizationId]
    );

    res.status(201).json({ appointment: rows[0] });
  } catch (error) {
    console.error("CREATE_APPOINTMENT_ERROR:", error);
    res.status(500).json({ message: "Не удалось создать запись" });
  }
});

app.put("/api/appointments/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;
    const { client_id, master_id, service_id, starts_at, ends_at, status, notes } = req.body || {};

    const [existing] = await pool.query(
      `SELECT id FROM appointments WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (existing.length === 0) {
      return res.status(404).json({ message: "Запись не найдена" });
    }

    const start = new Date(starts_at);
    const end = new Date(ends_at);

    if (Number.isNaN(start.getTime()) || Number.isNaN(end.getTime())) {
      return res.status(400).json({ message: "Некорректное время записи" });
    }

    if (end <= start) {
      return res.status(400).json({
        message: "Время окончания должно быть позже времени начала",
      });
    }

    const [conflicts] = await pool.query(
      `SELECT id
       FROM appointments
       WHERE organization_id = ?
         AND master_id = ?
         AND status = 'scheduled'
         AND id <> ?
         AND starts_at < ?
         AND ends_at > ?`,
      [req.organizationId, master_id, id, end, start]
    );

    if (conflicts.length > 0) {
      return res.status(409).json({
        message: "У мастера уже есть запись в это время",
      });
    }

    await pool.query(
      `UPDATE appointments
       SET client_id = ?, master_id = ?, service_id = ?,
           starts_at = ?, ends_at = ?, status = ?, notes = ?
       WHERE id = ? AND organization_id = ?`,
      [
        client_id,
        master_id,
        service_id,
        start,
        end,
        status || "scheduled",
        notes || null,
        id,
        req.organizationId,
      ]
    );

    const [rows] = await pool.query(
      `SELECT
         a.*,
         c.name AS client_name,
         m.name AS master_name,
         s.name AS service_name
       FROM appointments a
       LEFT JOIN clients c ON c.id = a.client_id
       LEFT JOIN masters m ON m.id = a.master_id
       LEFT JOIN services s ON s.id = a.service_id
       WHERE a.id = ? AND a.organization_id = ?`,
      [id, req.organizationId]
    );

    res.json({ appointment: rows[0] });
  } catch (error) {
    console.error("UPDATE_APPOINTMENT_ERROR:", error);
    res.status(500).json({ message: "Не удалось обновить запись" });
  }
});

app.delete("/api/appointments/:id", requireAuth, tenantContext, async (req, res) => {
  try {
    const { id } = req.params;

    const [result] = await pool.query(
      `DELETE FROM appointments WHERE id = ? AND organization_id = ?`,
      [id, req.organizationId]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Запись не найдена" });
    }

    res.json({ message: "Запись удалена" });
  } catch (error) {
    console.error("DELETE_APPOINTMENT_ERROR:", error);
    res.status(500).json({ message: "Не удалось удалить запись" });
  }
});

// ==================== END MASTERS ====================


await seedOwner();


app.listen(process.env.PORT || 4000, () => {
  console.log(
    `AI backend запущен: http://localhost:${process.env.PORT || 4000}`
  );
});









