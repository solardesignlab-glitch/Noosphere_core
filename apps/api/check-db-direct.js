import mysql from 'mysql2/promise';
import 'dotenv/config';

const config = {
  host: process.env.DB_HOST || '127.0.0.1',
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER || 'ucp_user',
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'ucp',
};

try {
  const connection = await mysql.createConnection(config);
  const [rows] = await connection.query('SELECT 1 AS ok');
  console.log('✅ Database connection OK:', rows);
  await connection.end();
} catch (error) {
  console.error('❌ Database connection failed:', error.message);
  process.exitCode = 1;
}