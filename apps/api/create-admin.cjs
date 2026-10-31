const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');
const crypto = require('crypto');

(async () => {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'ucp_user',
    password: 'QXJREEcYtQ8R9Jw8',
    database: 'ucp'
  });

  const id = crypto.randomUUID();
  const hash = bcrypt.hashSync('admin123', 10);

  await conn.execute(
    'INSERT INTO users (id, organization_id, email, password_hash, role, status) VALUES (?, ?, ?, ?, ?, ?)',
    [id, '11111111-1111-1111-1111-111111111111', 'admin@ucp.local', hash, 'owner', 'active']
  );

  console.log('Created user: admin@ucp.local / admin123');
  console.log('User ID:', id);
  await conn.end();
})();
