require("dotenv").config();
process.env.JWT_SECRET =
  process.env.JWT_SECRET || "test_jwt_secret_do_not_use_in_prod";

const request = require("supertest");
const mongoose = require("mongoose");
const app = require("../src/app");
const User = require("../src/models/User");
const Task = require("../src/models/Task");

const BASE_USER = {
  name: "Task Tester",
  email: "tasktest@example.com",
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
// POST /api/tasks
// ──────────────────────────────────────────────────────────────
describe("POST /api/tasks", () => {
  it("creates a task for the authenticated user", async () => {
    const res = await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Buy groceries", description: "Milk, eggs, bread" })
      .expect(201);

    expect(res.body.title).toBe("Buy groceries");
    expect(res.body.completed).toBe(false);
    expect(res.body.owner).toBeDefined();
  });

  it("returns 401 without authentication", async () => {
    await request(app)
      .post("/api/tasks")
      .send({ title: "Unauthorised task" })
      .expect(401);
  });

  it("returns 400 when title is missing", async () => {
    await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ description: "No title here" })
      .expect(400);
  });
});

// ──────────────────────────────────────────────────────────────
// GET /api/tasks
// ──────────────────────────────────────────────────────────────
describe("GET /api/tasks", () => {
  beforeEach(async () => {
    await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Task A", completed: false });
    await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Task B", completed: true });
    await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Task C", completed: true });
  });

  it("returns all tasks for the authenticated user", async () => {
    const res = await request(app)
      .get("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(res.body.tasks.length).toBe(3);
    expect(res.body.total).toBe(3);
  });

  it("filters tasks by completed=true", async () => {
    const res = await request(app)
      .get("/api/tasks?completed=true")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(res.body.tasks.length).toBe(2);
    res.body.tasks.forEach((t) => expect(t.completed).toBe(true));
  });

  it("filters tasks by completed=false", async () => {
    const res = await request(app)
      .get("/api/tasks?completed=false")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(res.body.tasks.length).toBe(1);
    expect(res.body.tasks[0].completed).toBe(false);
  });

  it("supports pagination via limit and skip", async () => {
    const res = await request(app)
      .get("/api/tasks?limit=2&skip=0")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(res.body.tasks.length).toBe(2);
    expect(res.body.total).toBe(3);
  });

  it("returns 401 without authentication", async () => {
    await request(app).get("/api/tasks").expect(401);
  });
});

// ──────────────────────────────────────────────────────────────
// GET /api/tasks/:id
// ──────────────────────────────────────────────────────────────
describe("GET /api/tasks/:id", () => {
  it("returns a single task by id", async () => {
    const created = await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Single fetch" });

    const res = await request(app)
      .get(`/api/tasks/${created.body._id}`)
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(res.body.title).toBe("Single fetch");
  });

  it("returns 404 for a non-existent task id", async () => {
    const fakeId = new mongoose.Types.ObjectId();
    await request(app)
      .get(`/api/tasks/${fakeId}`)
      .set("Authorization", `Bearer ${token}`)
      .expect(404);
  });

  it("returns 404 when accessing another user's task", async () => {
    const created = await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Private task" });

    const other = await request(app)
      .post("/api/auth/register")
      .send({
        name: "Other",
        email: "other@example.com",
        password: "OtherPass123!",
      });

    await request(app)
      .get(`/api/tasks/${created.body._id}`)
      .set("Authorization", `Bearer ${other.body.token}`)
      .expect(404);
  });
});

// ──────────────────────────────────────────────────────────────
// PATCH /api/tasks/:id
// ──────────────────────────────────────────────────────────────
describe("PATCH /api/tasks/:id", () => {
  let taskId;

  beforeEach(async () => {
    const res = await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Update Me" });
    taskId = res.body._id;
  });

  it("updates allowed fields", async () => {
    const res = await request(app)
      .patch(`/api/tasks/${taskId}`)
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Updated Title", completed: true })
      .expect(200);

    expect(res.body.title).toBe("Updated Title");
    expect(res.body.completed).toBe(true);
  });

  it("rejects disallowed fields with 400", async () => {
    await request(app)
      .patch(`/api/tasks/${taskId}`)
      .set("Authorization", `Bearer ${token}`)
      .send({ owner: new mongoose.Types.ObjectId().toString() })
      .expect(400);
  });

  it("returns 404 for a task that does not belong to the user", async () => {
    const other = await request(app)
      .post("/api/auth/register")
      .send({
        name: "Other",
        email: "other2@example.com",
        password: "OtherPass123!",
      });

    await request(app)
      .patch(`/api/tasks/${taskId}`)
      .set("Authorization", `Bearer ${other.body.token}`)
      .send({ completed: true })
      .expect(404);
  });
});

// ──────────────────────────────────────────────────────────────
// DELETE /api/tasks/:id
// ──────────────────────────────────────────────────────────────
describe("DELETE /api/tasks/:id", () => {
  let taskId;

  beforeEach(async () => {
    const res = await request(app)
      .post("/api/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Delete Me" });
    taskId = res.body._id;
  });

  it("deletes the task successfully", async () => {
    await request(app)
      .delete(`/api/tasks/${taskId}`)
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    // Confirm it's gone
    await request(app)
      .get(`/api/tasks/${taskId}`)
      .set("Authorization", `Bearer ${token}`)
      .expect(404);
  });

  it("returns 404 when deleting another user's task", async () => {
    const other = await request(app)
      .post("/api/auth/register")
      .send({
        name: "Other",
        email: "other3@example.com",
        password: "OtherPass123!",
      });

    await request(app)
      .delete(`/api/tasks/${taskId}`)
      .set("Authorization", `Bearer ${other.body.token}`)
      .expect(404);
  });
});
