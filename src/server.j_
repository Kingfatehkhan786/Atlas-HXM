const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'payroll-service' });
});

app.get('/api/v1/payroll-runs', (req, res) => {
  res.json({ runs: [] });
});

app.post('/api/v1/payroll-runs', (req, res) => {
  res.status(202).json({ id: 'run_placeholder', status: 'queued' });
});

module.exports = app;

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Payroll service listening on port ${PORT}`);
  });
}
