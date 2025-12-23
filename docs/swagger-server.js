const express = require('express');
const swaggerUi = require('swagger-ui-express');
const axios = require('axios');

const app = express();
const port = 3000;

const openApiUrls = [
  'http://console/console/docs/?format=openapi',
  'http://auth/auth/docs/?format=openapi',
  'http://dashboard/dashboard/docs/?format=openapi',
  'http://device/device/docs/?format=openapi',
];

async function getCombinedOpenApi() {
  const openApiDocs = await Promise.all(openApiUrls.map(async (url) => {
    try {
      const res = await axios.get(url);
      return res.data;
    } catch (error) {
      console.error(`Failed to fetch ${url}: ${error.message}`);
      return { paths: {}, definitions: {} }; // Return empty paths and definitions if the request fails
    }
  }));
  return {
    swagger: '2.0',
    info: {
      title: 'SpaceDF API',
      version: '1.0.0',
    },
    basePath: '/api',
    paths: Object.assign({}, ...openApiDocs.map(doc => doc.paths)),
    definitions: Object.assign({}, ...openApiDocs.map(doc => doc.definitions || {})),
    securityDefinitions: {
      "Access Token": {
        type: 'apiKey',
        name: 'Authorization',
        in: 'header',
      },
      "API Key": {
        type: 'apiKey',
        name: 'X-API-Key',
        in: 'header',
      },
      "Space slug name": {
        type: 'apiKey',
        name: 'X-Space',
        in: 'header',
      },
      "Organization slug name": {
        type: 'apiKey',
        name: 'X-Organization',
        in: 'header',
      },
    },
    security: [
      {
        "Access Token": [],
        "API Key": [],
        "Space slug name": [],
        "Organization slug name": [],
      },
    ],
  };
}

app.get('/openapi.json', async (req, res) => {
  try {
    const combinedOpenApi = await getCombinedOpenApi();
    res.json(combinedOpenApi);
  }
  catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

app.use('/docs', swaggerUi.serve, swaggerUi.setup(null, {
  swaggerOptions: {
    url: '/openapi.json',
    requestInterceptor: (req) => {
      req.headers['Content-Type'] = 'application/json';
      return req;
    },
  },
}));

app.listen(port, () => {
  console.log(`Swagger UI available at http://localhost:${port}/docs`);
});