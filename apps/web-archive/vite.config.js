import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { resolve } from "path";

// Мини-мок: перехватывает ТОЛЬКО известные эндпоинты,
// остальное пропускает дальше (в прокси или на 404 самого Vite)
function apiMock() {
  return {
    name: "api-mock",
    configureServer(server) {
      server.middlewares.use("/api", (req, res, next) => {
        const send = (code, data) => {
          res.statusCode = code;
          res.setHeader("Content-Type", "application/json");
          res.end(JSON.stringify(data));
        };

        if (req.url === "/health") {
          send(200, {
            status: "ok",
            version: "1.0-mock",
            source: "local-mock",
          });
          return;
        }

        if (req.url === "/login" && req.method === "POST") {
          let body = "";
          req.on("data", (chunk) => (body += chunk));
          req.on("end", () => {
            try {
              const { email, password } = JSON.parse(body);
              if (!email || !password) {
                send(400, { error: "Нужны email и пароль" });
                return;
              }
              send(200, {
                token: "mock-token-123",
                user: { email, name: "Тестовый пользователь", role: "admin" },
              });
            } catch {
              send(400, { error: "Неверный JSON" });
            }
          });
          return;
        }

        // Всё остальное — не наше, пропускаем дальше (в proxy)
        next();
      });
    },
  };
}

export default defineConfig({
  plugins: [
    react({
      include: /\.(js|jsx|ts|tsx)$/,
      babel: {
        babelHelpers: "bundled",
      },
    }),
    apiMock(),
  ],
  resolve: {
    alias: {
      "@": resolve(import.meta.dirname, "./src"),
    },
  },
  server: {
    port: 5173,
    host: true,
    strictPort: true,
    proxy: {
      "/api/v1": {
        target: "http://localhost:8081",
        changeOrigin: true,
      },
      "/api": {
        target: "http://localhost:8090",
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: "dist",
    assetsDir: "assets",
    rollupOptions: {
      output: {
        entryFileNames: "js/[name].[hash].js",
        chunkFileNames: "js/[name].[hash].js",
        assetFileNames: "assets/[name].[hash].[ext]",
      },
    },
  },
  optimizeDeps: {
    include: ["react", "react-dom"],
  },
});
