import { testDatabaseConnection } from "./src/shared/db/pool.js";

try {
  const result = await testDatabaseConnection();

  console.log("DATABASE_OK:", result.now);
  process.exit(0);
} catch (error) {
  console.error("DATABASE_ERROR:", error.message);
  process.exit(1);
}