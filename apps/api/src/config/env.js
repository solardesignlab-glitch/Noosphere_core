export const env = {
  port: Number(process.env.PORT || 4000),
  jwtSecret: process.env.JWT_SECRET,
  jwtExpiresIn: process.env.JWT_EXPIRES_IN || '12h',
  db: {
    host: process.env.DB_HOST || 'localhost',
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  },
  espocrm: {
    baseUrl: process.env.ESPOCRM_URL || 'http://localhost:8081',
    apiKey: process.env.ESPOCRM_API_KEY
  }
};

if (!env.jwtSecret) {
  throw new Error('JWT_SECRET is required');
}

if (!env.db.user || !env.db.password || !env.db.database) {
  throw new Error('Database environment variables are required');
}
