const request = require('supertest');
const app = require('./server');

describe('payroll-service', () => {
  it('GET /health returns 200', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('ok');
  });

  it('GET /api/v1/payroll-runs returns empty list', async () => {
    const res = await request(app).get('/api/v1/payroll-runs');
    expect(res.statusCode).toBe(200);
    expect(res.body.runs).toEqual([]);
  });

  it('POST /api/v1/payroll-runs returns 202', async () => {
    const res = await request(app).post('/api/v1/payroll-runs').send({});
    expect(res.statusCode).toBe(202);
    expect(res.body.status).toBe('queued');
  });
});
