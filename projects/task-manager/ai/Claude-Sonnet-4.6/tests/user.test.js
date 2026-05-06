require("dotenv").config();
process.env.JWT_SECRET =
  process.env.JWT_SECRET || "test_jwt_secret_do_not_use_in_prod";

const request = require("supertest");
const mongoose = require("mongoose");
const app = require("../src/app");
const User = require("../src/models/User");
const Task = require("../src/models/Task");

const BASE_USER = {
  name: "Profile Tester",
  email: "profile@example.com",
  password: "SecurePass123!",
};

let token;

beforeAll(async () => {
  const uri =
    process.env.MONGODB_TEST_URI ||
    "mongodb://localhost:27017/task-manager-test";
  await mongoose.connect(uri);
});

beforeEach(async () => {
  await User.deleteMany({});
  await Task.deleteMany({});
  const res = await request(app).post("/api/auth/register").send(BASE_USER);
  token = res.body.token;
});

afterAll(async () => {
  await User.deleteMany({});
  await Task.deleteMany({});
  await mongoose.connection.close();
});

// ──────────────────────────────────────────────────────────────
// GET /api/users/me
// ──────────────────────────────────────────────────────────────
describe("GET /api/users/me", () => {
  it("returns the authenticated user profile", async () => {
    const res = await request(app)
      .get("/api/users/me")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(res.body.email).toBe(BASE_USER.email);
    expect(res.body.password).toBeUndefined();
  });

  it("returns 401 without token", async () => {
    await request(app).get("/api/users/me").expect(401);
  });
});

// ──────────────────────────────────────────────────────────────
// PATCH /api/users/me
// ──────────────────────────────────────────────────────────────
describe("PATCH /api/users/me", () => {
  it("updates allowed fields", async () => {
    const res = await request(app)
      .patch("/api/users/me")
      .set("Authorization", `Bearer ${token}`)
      .send({ name: "New Name" })
      .expect(200);

    expect(res.body.name).toBe("New Name");
  });

  it("rejects disallowed fields", async () => {
    await request(app)
      .patch("/api/users/me")
      .set("Authorization", `Bearer ${token}`)
      .send({ role: "admin" })
      .expect(400);
  });
});

// ──────────────────────────────────────────────────────────────
// DELETE /api/users/me
// ──────────────────────────────────────────────────────────────
describe("DELETE /api/users/me", () => {
  it("deletes the account and cascades tasks", async () => {
    // Create a task owned by this user
    await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Orphan task" });

    await request(app)
      .delete("/api/users/me")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    // User should no longer exist
    const count = await User.countDocuments({ email: BASE_USER.email });
    expect(count).toBe(0);

    // Associated tasks should be removed
    const taskCount = await Task.countDocuments({});
    expect(taskCount).toBe(0);
  });
});
