import { useEffect, useState } from "react";
import "./PartsPage.css";

import {
  getParts,
  createPart,
  updatePart,
  deletePart
} from "../api/parts";


const emptyForm = {
  organizationId: 1,
  sku: "",
  name: "",
  brand: "",
  price: "",
  stockQty: "",
  isActive: true
};


export default function PartsPage() {
  const [parts, setParts] = useState([]);
  const [form, setForm] = useState(emptyForm);
  const [editingId, setEditingId] = useState(null);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);


  async function loadParts() {
    try {
      setLoading(true);
      setError("");
      const items = await getParts();
      setParts(items);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }


  useEffect(() => {
    loadParts();
  }, []);


  function handleChange(event) {
    const { name, value, type, checked } = event.target;


    setForm((prev) => ({
      ...prev,
      [name]: type === "checkbox" ? checked : value
    }));
  }


  async function handleSubmit(event) {
    event.preventDefault();
    setError("");


    const payload = {
      organizationId: Number(form.organizationId),
      sku: form.sku,
      name: form.name,
      brand: form.brand,
      price: Number(form.price || 0),
      stockQty: Number(form.stockQty || 0),
      isActive: form.isActive
    };


    try {
      if (editingId) {
        await updatePart(editingId, payload);
      } else {
        await createPart(payload);
      }


      setForm(emptyForm);
      setEditingId(null);
      await loadParts();
    } catch (err) {
      setError(err.message);
    }
  }


  function handleEdit(part) {
    setEditingId(part.id);
    setForm({
      organizationId: part.organization_id,
      sku: part.sku,
      name: part.name,
      brand: part.brand || "",
      price: part.price,
      stockQty: part.stock_qty,
      isActive: Boolean(part.is_active)
    });
  }


  async function handleDelete(id) {
    if (!window.confirm("Удалить запчасть?")) {
      return;
    }


    try {
      await deletePart(id);
      await loadParts();
    } catch (err) {
      setError(err.message);
    }
  }


  return (
    <section className="page">
      <header className="page__header">
        <div>
          <h1>Запчасти</h1>
          <p>Каталог запчастей, цены и остатки</p>
        </div>
      </header>


      {error && (
        <div className="parts-page__error">
          {error}
        </div>
      )}


      <div className="parts-page__card">
        <form className="parts-page__form" onSubmit={handleSubmit}>
          <label>
            <span>SKU</span>
            <input
              name="sku"
              value={form.sku}
              onChange={handleChange}
              required
            />
          </label>


          <label>
            <span>Название</span>
            <input
              name="name"
              value={form.name}
              onChange={handleChange}
              required
            />
          </label>


          <label>
            <span>Бренд</span>
            <input
              name="brand"
              value={form.brand}
              onChange={handleChange}
            />
          </label>


          <label>
            <span>Цена</span>
            <input
              name="price"
              type="number"
              min="0"
              step="0.01"
              value={form.price}
              onChange={handleChange}
            />
          </label>


          <label>
            <span>Количество</span>
            <input
              name="stockQty"
              type="number"
              min="0"
              value={form.stockQty}
              onChange={handleChange}
            />
          </label>


          <label className="parts-page__checkbox">
            <input
              name="isActive"
              type="checkbox"
              checked={form.isActive}
              onChange={handleChange}
            />
            Активна
          </label>


          <button className="button button--primary" type="submit">
            {editingId ? "Сохранить" : "Добавить"}
          </button>
        </form>
      </div>


      <div className="parts-page__card">
        {loading ? (
          <div className="empty-state">
            <div className="empty-state__icon">⏳</div>
            <h2>Загрузка</h2>
            <p>Получаем список запчастей.</p>
          </div>
        ) : parts.length === 0 ? (
          <div className="empty-state">
            <div className="empty-state__icon">⚙️</div>
            <h2>Запчастей пока нет</h2>
            <p>Добавьте первую запчасть через форму выше.</p>
          </div>
        ) : (
          <table className="parts-page__table">
            <thead>
              <tr>
                <th>SKU</th>
                <th>Название</th>
                <th>Бренд</th>
                <th>Цена</th>
                <th>Остаток</th>
                <th>Статус</th>
                <th>Действия</th>
              </tr>
            </thead>


            <tbody>
              {parts.map((part) => (
                <tr key={part.id}>
                  <td>{part.sku}</td>
                  <td>{part.name}</td>
                  <td>{part.brand}</td>
                  <td>{part.price} ₽</td>
                  <td>{part.stock_qty}</td>
                  <td>
                    <span
                      className={
                        part.is_active
                          ? "parts-page__badge parts-page__badge--active"
                          : "parts-page__badge"
                      }
                    >
                      {part.is_active ? "Активна" : "Архив"}
                    </span>
                  </td>
                  <td>
                    <div className="parts-page__actions">
                      <button
                        className="button button--secondary"
                        type="button"
                        onClick={() => handleEdit(part)}
                      >
                        Изменить
                      </button>


                      <button
                        className="button button--danger"
                        type="button"
                        onClick={() => handleDelete(part.id)}
                      >
                        Удалить
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </section>
  );
}