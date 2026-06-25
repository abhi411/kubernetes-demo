const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = process.env.PORT || 3000;

console.log("env ", process.env)
// following environment variables are not resolving correctly in kubernetes
const pool = new Pool({
  host: process.env.DB_HOST,
  user:  process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT
});

app.get('/data', async (req, res) => {
  const result = await pool.query('SELECT * FROM demo_table');
  res.json(result.rows);
});

app.get('/', async (req, res) => {
  res.send("Test");
});

app.listen(port, () => console.log(`API running on ${port}`));
