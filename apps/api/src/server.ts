import { createServer } from 'node:http';

const port = Number(process.env.PORT ?? 4000);

const send = (res: import('node:http').ServerResponse, status: number, body: unknown) => {
  res.writeHead(status, { 'content-type': 'application/json; charset=utf-8' });
  res.end(JSON.stringify(body));
};

const server = createServer(async (req, res) => {
  const url = new URL(req.url ?? '/', `http://${req.headers.host ?? 'localhost'}`);

  if (req.method === 'GET' && url.pathname === '/health') {
    return send(res, 200, {
      service: 'rebuilttrust-api',
      status: 'ok',
      version: '0.1.0',
    });
  }

  if (req.method === 'GET' && url.pathname === '/api/v1') {
    return send(res, 200, {
      name: 'RebuiltTrustVehicle API',
      resources: [
        'dealers',
        'vehicles',
        'listings',
        'buyers',
        'buyer-profiles',
        'matches',
        'inquiries',
        'warranty-cases',
        'finance-applications',
        'transactions',
      ],
    });
  }

  return send(res, 404, {
    error: 'not_found',
    message: 'Route not found',
  });
});

server.listen(port, () => {
  console.log(`RebuiltTrustVehicle API listening on :${port}`);
});
