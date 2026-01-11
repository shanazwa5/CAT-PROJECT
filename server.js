// server.js
const express = require('express');
const cors = require('cors');
const oracledb = require('oracledb');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Oracle connection config
const dbConfig = {
  user: 'SYSTEM',           // ganti dengan user Oracle awak
  password: 'password_awak',// ganti dengan password awak
  connectString: 'localhost:1521/XE' // host:port/service_name
};

// ===========================
// GET endpoint: Top 5 highest-rated reviews
// ===========================
app.get('/api/reviews', async (req, res) => {
  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      `SELECT CUSTOMER_NAME, RATING, REVIEW_COMMENT
       FROM REVIEWS
       ORDER BY RATING DESC, CREATED_AT DESC
       FETCH FIRST 5 ROWS ONLY`
    );

    // Convert result.rows (array of arrays) → array of objects
    const reviews = result.rows.map(row => ({
      customer_name: row[0],
      rating: row[1],
      review_comment: row[2]
    }));

    res.json(reviews);

  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ error: 'Database error' });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) { console.error(err); }
    }
  }
});

// ===========================
// POST endpoint: Add new review
// ===========================
app.post('/api/reviews', async (req, res) => {
  const { customer_name, rating, review_comment } = req.body;

  if (!customer_name || !rating || !review_comment) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  let connection;

  try {
    connection = await oracledb.getConnection(dbConfig);

    await connection.execute(
      `INSERT INTO REVIEWS (CUSTOMER_NAME, RATING, REVIEW_COMMENT)
       VALUES (:customer_name, :rating, :review_comment)`,
      { customer_name, rating, review_comment },
      { autoCommit: true }
    );

    res.status(201).json({ message: 'Review added successfully' });

  } catch (err) {
    console.error('Database error:', err);
    res.status(500).json({ error: 'Database error' });
  } finally {
    if (connection) {
      try { await connection.close(); } catch (err) { console.error(err); }
    }
  }
});

// ===========================
// Start server
// ===========================
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});