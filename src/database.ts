import { Pool } from "https://deno.land/x/postgres@v0.4.5/mod.ts";

const pool = new Pool({
  hostname: Deno.env.get("PG_HOST") ?? "localhost",
  port: Number(Deno.env.get("PG_PORT")) || 5432,
  user: Deno.env.get("PG_USER") ?? "user",
  password: Deno.env.get("PG_PASSWORD") ?? "password",
  database: Deno.env.get("PG_DATABASE") ?? "realworld",
}, 10);

export default pool;
