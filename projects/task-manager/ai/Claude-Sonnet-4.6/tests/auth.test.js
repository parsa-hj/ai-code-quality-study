require("dotenv").config();
process.env.JWT_SECRET =
  process.env.JWT_SECRET || "test_jwt_secret_do_not_use_in_prod";

const request = require("supertest");
const mongoose = require("mongoose");
const app = require("../src/app");
const User = require("../src/models/User");

const BASE_USER = {
  name: "Test User",
  email: "testuser@example.com",
  password: "SecurePass123!",
};

beforeAll(async () => {
  const uri =
    process.env.MONGODB_TEST_URI ||
    "mongodb://localhost:27017/task-manager-test";
  await mongoose.connect(uri);
});

beforeEach(async () => {
  await User.deleteMany({});
});

afterAll(async () => {
  await User.deleteMany({});
  await mongoose.connection.close();
});

// ──────────────────────────────────────────────────────────────
// POST /api/auth/register
// ──────────────────────────────────────────────────────────────
describe("POST /api/auth/register", () => {
  it("registers a new user and returns user + token", async () => {
    const res = await request(app)
      .post("/api/auth/register")
      .send(BASE_USER)
      .expect(201);

    expect(res.body.user).toBeDefined();
    expect(res.body.token).toBeDefined();
    expect(res.body.user.email).toBe(BASE_USER.email);
    expect(res.body.user.password).toBeUndefined(); // stripped by toJSON
    expect(res.body.user.tokens).toBeUndefined(); // stripped by toJSON
  });

  it("rejects an invalid email", async () => {
    await request(app)
      .post("/api/auth/register")
      .send({ ...BASE_USER, email: "not-an-email" })
      .expect(400);
  });

  it("rejects a password shorter than 8 chars", async () => {
    await request(app)
      .post("/api/auth/register")
      .send({ ...BASE_USER, password: "short" })
      .expect(400);
  });

  it('rejects a password containing the word "password"', async () => {
    await request(app)
      .post("/api/auth/register")
      .send({ ...BASE_USER, password: "password123" })
      .expect(400);
  });

  it("rejects duplicate email with 409", async () => {
    await request(app).post("/api/auth/register").send(BASE_USER);
    await request(app).post("/api/auth/register").send(BASE_USER).expect(409);
  });

  it("rejects missing required fields", async () => {
    await request(app)
      .post("/api/auth/register")
      .send({ email: BASE_USER.email })
      .expect(400);
  });
});

// ──────────────────────────────────────────────────────────────
// POST /api/auth/login
// ──────────────────────────────────────────────────────────────
describe("POST /api/auth/login", () => {
  beforeEach(async () => {
    await request(app).post("/api/auth/register").send(BASE_USER);
  });

  it("logs in with valid credentials", async () => {
    const res = await request(app)
      .post("/api/auth/login")
      .send({ email: BASE_USER.email, password: BASE_USER.password })
      .expect(200);

    expect(res.body.token).toBeDefined();
    expect(res.body.user.email).toBe(BASE_USER.email);
  });

  it("rejects wrong password with 400", async () => {
    await request(app)
      .post("/api/auth/login")
      .send({ email: BASE_USER.email, password: "WrongPass123!" })
      .expect(400);
  });

  it("rejects unknown email with 400", async () => {
    await request(app)
      .post("/api/auth/login")
      .send({ email: "nobody@example.com", password: BASE_USER.password })
      .expect(400);
  });
});

// ──────────────────────────────────────────────────────────────
// POST /api/auth/logout
// ──────────────────────────────────────────────────────────────
describe("POST /api/auth/logout", () => {
  let token;

  beforeEach(async () => {
    const res = await request(app).post("/api/auth/register").send(BASE_USER);
    token = res.body.token;
  });

  it("logs out the current session", async () => {
    await request(app)
      .post("/api/auth/logout")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    // Token should no longer be valid
    await request(app)
      .post("/api/auth/logout")
      .set("Authorization", `Bearer ${token}`)
      .expect(401);
  });

  it("returns 401 without token", async () => {
    await request(app).post("/api/auth/logout").expect(401);
  });
});

// ──────────────────────────────────────────────────────────────
// POST /api/auth/logout-all
// ──────────────────────────────────────────────────────────────
describe("POST /api/auth/logout-all", () => {
  it("invalidates all sessions", async () => {
    const reg = await request(app).post("/api/auth/register").send(BASE_USER);
    const token1 = reg.body.token;

    const login = await request(app)
      .post("/api/auth/login")
      .send({ email: BASE_USER.email, password: BASE_USER.password });
    const token2 = login.body.token;

    // Logout all using token1
    await request(app)
      .post("/api/auth/logout-all")
      .set("Authorization", `Bearer ${token1}`)
      .expect(200);

    // Both tokens should be invalid now
    await request(app)
      .get("/api/users/me")
      .set("Authorization", `Bearer ${token1}`)
      .expect(401);
    await request(app)
      .get("/api/users/me")
      .set("Authorization", `Bearer ${token2}`)
      .expect(401);
  });
});
