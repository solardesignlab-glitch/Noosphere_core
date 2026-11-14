import { useState } from "react";
import { login } from "../api/backend";

export default function LoginPage({ onLogin }) {
  const [email, setEmail] = useState("owner@atmosfera.local");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  async function handleSubmit(event) {
    event.preventDefault();
    setError("");
    setIsLoading(true);

    try {
      const user = await login(email, password);
      onLogin(user);
    } catch (err) {
      setError(err.message);
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="login">
      <form className="login__card" onSubmit={handleSubmit}>
        <div className="login__brand">
          <div className="login__logo">A</div>
          <div>
            <h1>Атмосфера</h1>
            <p>Войдите в рабочее пространство</p>
          </div>
        </div>

        <label className="login__field">
          <span>Email</span>
          <input
            type="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            required
          />
        </label>

        <label className="login__field">
          <span>Пароль</span>
          <input
            type="password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            required
          />
        </label>

        {error && <div className="login__error">{error}</div>}

        <button
          className="button button--primary login__submit"
          type="submit"
          disabled={isLoading}
        >
          {isLoading ? "Вход..." : "Войти"}
        </button>
      </form>
    </div>
  );
}