const express = require('express');
const { Sequelize, DataTypes } = require('sequelize');
require('dotenv').config();

const app = express();
app.use(express.json());

const cors = require('cors');
app.use(cors());

const prometheus = require('express-prom-bundle');
const client = require('prom-client');

// const metricsMiddleware = prometheus({
//   includeMethod: true,
//   includePath: true,
//   promClient: { collectDefaultMetrics: {} }
// })

// app.use(metricsMiddleware);


// Enable collection of default metrics (CPU, memory, etc.)
const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics({ register: client.register });

// Koneksi ke PostgreSQL
const sequelize = new Sequelize(process.env.DATABASE_URL);

// Definisi Model
const Item = sequelize.define('Item', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  price: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
});

// Sync Database
sequelize.sync().then(() => console.log('Database connected'));

// API Routes
app.get('/items', async (req, res) => {
  const items = await Item.findAll();
  res.json(items);
});

app.post('/items', async (req, res) => {
  const { name, price } = req.body;
  const newItem = await Item.create({ name, price });
  res.json(newItem);
});

// Metrics endpoint
app.get('/metrics', async (req, res) => {
  res.setHeader('Content-Type', client.register.contentType);
  const metrics = await client.register.metrics();
  res.send(metrics);
});

// Menjalankan Server
app.listen(5000, () => {
  console.log('Backend running on http://localhost:5000');
});

