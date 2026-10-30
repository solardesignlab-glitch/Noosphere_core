import express from "express";
import cors from "cors";
import multer from "multer";
import OpenAI from "openai";
import dotenv from "dotenv";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

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
5. Если просишь изменить интерфейс, указывай, какие элементы и почему.
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
app.get("/api/health", (req, res) => {
  res.json({
    status: "ok",
    service: "atmosfera-backend"
  });
});

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

     
app.get("/api/media", (req, res) => {
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

app.post("/api/media", mediaUpload.single("image"), (req, res) => {
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

app.delete("/api/media/:fileName", (req, res) => {
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

app.post("/api/ai/chat", express.json(), async (req, res) => {
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
        model: "qwen2.5:7b",
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


app.get("/api/models", async (req, res) => {
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

app.post("/api/agent/propose-code", express.json(), async (req, res) => {
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

app.listen(process.env.PORT || 4000, () => {
  console.log(
    `AI backend запущен: http://localhost:${process.env.PORT || 4000}`
  );
});