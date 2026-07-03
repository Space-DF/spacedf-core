const express = require("express");
const swaggerUi = require("swagger-ui-express");
const axios = require("axios");

const app = express();
const port = 3000;

const openApiUrls = [
  "http://console/console/docs/?format=openapi",
  "http://auth/auth/docs/?format=openapi",
  "http://dashboard/dashboard/docs/?format=openapi",
  "http://device/device/docs/?format=openapi",
  "http://telemetry:8080/swagger/doc.json",
];

async function getCombinedOpenApi() {
  const openApiDocs = await Promise.all(
    openApiUrls.map(async (url) => {
      try {
        const res = await axios.get(url);
        return res.data;
      } catch (error) {
        console.error(`Failed to fetch ${url}: ${error.message}`);
        return { paths: {}, definitions: {} }; // Return empty paths and definitions if the request fails
      }
    }),
  );
  return {
    swagger: "2.0",
    info: {
      title: "SpaceDF API",
      version: "1.0.0",
    },
    basePath: "/api",
    paths: Object.assign({}, ...openApiDocs.map((doc) => doc.paths)),
    definitions: Object.assign(
      {},
      ...openApiDocs.map((doc) => doc.definitions || {}),
    ),
    securityDefinitions: {
      "Access Token": {
        type: "apiKey",
        name: "Authorization",
        in: "header",
      },
      "API Key": {
        type: "apiKey",
        name: "X-API-Key",
        in: "header",
      },
      "Space slug name": {
        type: "apiKey",
        name: "X-Space",
        in: "header",
      },
      "Organization slug name": {
        type: "apiKey",
        name: "X-Organization",
        in: "header",
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

app.get("/openapi.json", async (req, res) => {
  try {
    const combinedOpenApi = await getCombinedOpenApi();
    res.json(combinedOpenApi);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
});

app.get(["/silk", "/silk/"], (_req, res) => {
  res.type("html").send(`
    <html>
      <head>
        <title>Silk Dashboards</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
          :root {
            --bg: #061521;
            --panel: rgba(10, 27, 40, 0.88);
            --panel-border: rgba(122, 207, 255, 0.18);
            --text: #e7f6ff;
            --muted: #8fb7cb;
            --accent: #37b7ff;
            --accent-strong: #0d8fe3;
            --glow: rgba(55, 183, 255, 0.18);
          }

          * {
            box-sizing: border-box;
          }

          body {
            margin: 0;
            min-height: 100vh;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            color: var(--text);
            background:
              radial-gradient(circle at top, rgba(55, 183, 255, 0.18), transparent 32%),
              linear-gradient(180deg, #0a1d2d 0%, var(--bg) 100%);
          }

          .shell {
            max-width: 1080px;
            margin: 0 auto;
            padding: 56px 24px 80px;
          }

          .hero {
            margin-bottom: 28px;
          }

          .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 12px;
            border: 1px solid var(--panel-border);
            border-radius: 999px;
            color: #9dd9ff;
            background: rgba(9, 26, 38, 0.7);
            font-size: 13px;
            letter-spacing: 0.08em;
            text-transform: uppercase;
          }

          h1 {
            margin: 18px 0 12px;
            font-size: clamp(32px, 6vw, 52px);
            line-height: 1.05;
          }

          .lead {
            max-width: 700px;
            margin: 0;
            color: var(--muted);
            font-size: 18px;
            line-height: 1.6;
          }

          .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            margin: 28px 0 36px;
          }

          .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 46px;
            padding: 0 18px;
            border-radius: 12px;
            color: white;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
          }

          .button-primary {
            background: linear-gradient(135deg, var(--accent) 0%, var(--accent-strong) 100%);
            box-shadow: 0 16px 34px var(--glow);
          }

          .button-secondary {
            border: 1px solid var(--panel-border);
            background: rgba(11, 31, 46, 0.74);
          }

          .button:hover {
            transform: translateY(-1px);
          }

          .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 18px;
          }

          .card {
            display: block;
            padding: 22px;
            border: 1px solid var(--panel-border);
            border-radius: 18px;
            text-decoration: none;
            color: inherit;
            background: linear-gradient(180deg, rgba(12, 31, 46, 0.94) 0%, rgba(8, 22, 34, 0.94) 100%);
            box-shadow: 0 18px 40px rgba(0, 0, 0, 0.22);
            transition: transform 0.18s ease, border-color 0.18s ease, box-shadow 0.18s ease;
          }

          .card:hover {
            transform: translateY(-3px);
            border-color: rgba(122, 207, 255, 0.42);
            box-shadow: 0 22px 46px rgba(3, 17, 27, 0.42);
          }

          .card-label {
            margin: 0 0 10px;
            color: #8ac8ef;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
          }

          .card-title {
            margin: 0 0 10px;
            font-size: 22px;
            font-weight: 700;
          }

          .card-copy {
            margin: 0;
            color: var(--muted);
            line-height: 1.55;
          }

          @media (max-width: 640px) {
            .shell {
              padding: 36px 16px 56px;
            }

            .lead {
              font-size: 16px;
            }
          }
        </style>
      </head>
      <body>
        <main class="shell">
          <section class="hero">
            <div class="eyebrow">Performance Monitoring</div>
            <h1>Silk Dashboards</h1>
            <p class="lead">
              Jump into per-service request profiling and SQL tracing with the same visual tone as the API docs entrypoint.
            </p>
            <div class="actions">
              <a class="button button-primary" href="/docs">Open API Docs</a>
              <a class="button button-secondary" href="/openapi.json">View OpenAPI JSON</a>
            </div>
          </section>

          <section class="grid">
            <a class="card" href="/silk/bootstrap">
              <p class="card-label">Profiler</p>
              <h2 class="card-title">Bootstrap Service</h2>
              <p class="card-copy">Inspect bootstrap request timing, queries, and middleware overhead.</p>
            </a>
            <a class="card" href="/silk/auth">
              <p class="card-label">Profiler</p>
              <h2 class="card-title">Auth Service</h2>
              <p class="card-copy">Review authentication flows, token endpoints, and database activity.</p>
            </a>
            <a class="card" href="/silk/device">
              <p class="card-label">Profiler</p>
              <h2 class="card-title">Device Service</h2>
              <p class="card-copy">Trace device operations and identify query-heavy or slow request paths.</p>
            </a>
            <a class="card" href="/silk/dashboard">
              <p class="card-label">Profiler</p>
              <h2 class="card-title">Dashboard Service</h2>
              <p class="card-copy">Profile dashboard rendering APIs and validate performance regressions.</p>
            </a>
          </section>
        </main>
      </body>
    </html>
  `);
});

app.use(
  "/docs",
  swaggerUi.serve,
  swaggerUi.setup(null, {
    swaggerOptions: {
      url: "/openapi.json",
      requestInterceptor: (req) => {
        req.headers["Content-Type"] = "application/json";
        return req;
      },
    },
  }),
);

app.listen(port, () => {
  console.log(`Swagger UI available at http://localhost:${port}/docs`);
});