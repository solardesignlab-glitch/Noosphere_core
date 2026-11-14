import crypto from "crypto";

import { requireAuth, requireRole } from "../../auth.js";
import { tenantContext } from "../shared/middleware/tenantContext.js";

export default function registerServiceRoutes(app, dbPool) {
  app.get("/api/services", requireAuth, tenantContext, async (req, res) => {
    try {
      const [rows] = await dbPool.query(
        `SELECT id, organization_id, name, category, duration_minutes, price, is_active, description, created_at, updated_at
         FROM services
         WHERE organization_id = ?
         ORDER BY id DESC
         LIMIT 200`,
        [req.organizationId],
      );

      res.json({ items: rows });
    } catch (error) {
      console.error("SERVICES_ERROR:", error);
      res.status(500).json({ error: "Не удалось получить услуги" });
    }
  });

  app.post(
    "/api/services",
    requireAuth,
    requireRole("owner"),
    tenantContext,
    async (req, res) => {
      try {
        const organizationId = req.organizationId;
        const {
          name,
          category,
          durationMinutes,
          price,
          isActive,
          description,
        } = req.body || {};

        if (!organizationId) {
          return res.status(400).json({ error: "Нет контекста организации" });
        }

        if (!name || typeof name !== "string" || !name.trim()) {
          return res.status(400).json({ error: "Укажите название услуги" });
        }

        const duration = Number(durationMinutes ?? 60);
        if (!Number.isInteger(duration) || duration <= 0) {
          return res
            .status(400)
            .json({ error: "Длительность должна быть целым числом минут" });
        }

        const normalizedPrice = Number(price ?? 0);
        if (Number.isNaN(normalizedPrice) || normalizedPrice < 0) {
          return res.status(400).json({ error: "Некорректная цена" });
        }

        const id = crypto.randomUUID();
        await dbPool.query(
          `INSERT INTO services (id, organization_id, name, category, duration_minutes, price, is_active, description)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            id,
            organizationId,
            name.trim(),
            category ?? null,
            duration,
            normalizedPrice,
            isActive === false ? 0 : 1,
            description ?? null,
          ],
        );

        const [created] = await dbPool.query(
          `SELECT id, organization_id, name, category, duration_minutes, price, is_active, description, created_at, updated_at
           FROM services
           WHERE id = ?`,
          [id],
        );
        res.status(201).json({ item: created[0] });
      } catch (error) {
        console.error("CREATE_SERVICE_ERROR:", error);
        res.status(500).json({ error: "Не удалось создать услугу" });
      }
    },
  );

  app.put(
    "/api/services/:id",
    requireAuth,
    requireRole("owner"),
    tenantContext,
    async (req, res) => {
      try {
        const { id } = req.params;
        const organizationId = req.organizationId;
        const body = req.body || {};

        const [existing] = await dbPool.query(
          `SELECT id FROM services WHERE id = ? AND organization_id = ?`,
          [id, organizationId],
        );

        if (existing.length === 0) {
          return res.status(404).json({ error: "Услуга не найдена" });
        }

        const fields = [];

        if (body.name !== undefined) {
          if (
            !body.name ||
            typeof body.name !== "string" ||
            !body.name.trim()
          ) {
            return res.status(400).json({ error: "Укажите название услуги" });
          }
          fields.push(["name", body.name.trim()]);
        }

        if (body.category !== undefined) {
          fields.push([
            "category",
            body.category === null ? null : String(body.category),
          ]);
        }

        if (body.durationMinutes !== undefined) {
          const duration = Number(body.durationMinutes);
          if (!Number.isInteger(duration) || duration <= 0) {
            return res.status(400).json({
              error: "Длительность должна быть целым числом минут",
            });
          }
          fields.push(["duration_minutes", duration]);
        }

        if (body.price !== undefined) {
          const normalizedPrice = Number(body.price);
          if (Number.isNaN(normalizedPrice) || normalizedPrice < 0) {
            return res.status(400).json({ error: "Некорректная цена" });
          }
          fields.push(["price", normalizedPrice]);
        }

        if (body.isActive !== undefined) {
          fields.push(["is_active", body.isActive === false ? 0 : 1]);
        }

        if (body.description !== undefined) {
          fields.push([
            "description",
            body.description === null ? null : String(body.description),
          ]);
        }

        if (fields.length === 0) {
          return res.status(400).json({
            error: "Не передано ни одного поля для обновления",
          });
        }

        const setSql = fields.map(([column]) => `${column} = ?`).join(", ");
        const values = fields.map(([, value]) => value);

        await dbPool.query(
          `UPDATE services
           SET ${setSql}, updated_at = CURRENT_TIMESTAMP
           WHERE id = ? AND organization_id = ?`,
          [...values, id, organizationId],
        );

        const [updated] = await dbPool.query(
          `SELECT id, organization_id, name, category, duration_minutes, price, is_active, description, created_at, updated_at
           FROM services
           WHERE id = ?`,
          [id],
        );

        return res.json({ item: updated[0] });
      } catch (error) {
        console.error("SERVICE_UPDATE_ERROR:", error);

        return res.status(500).json({ error: "Не удалось обновить услугу" });
      }
    },
  );

  app.delete(
    "/api/services/:id",
    requireAuth,
    requireRole("owner"),
    tenantContext,
    async (req, res) => {
      try {
        const { id } = req.params;
        const organizationId = req.organizationId;

        const [result] = await dbPool.query(
          `DELETE FROM services WHERE id = ? AND organization_id = ?`,
          [id, organizationId],
        );

        if (result.affectedRows === 0) {
          return res.status(404).json({ error: "Услуга не найдена" });
        }

        res.json({ success: true });
      } catch (error) {
        console.error("DELETE_SERVICE_ERROR:", error);
        res.status(500).json({ error: "Не удалось удалить услугу" });
      }
    },
  );
}
