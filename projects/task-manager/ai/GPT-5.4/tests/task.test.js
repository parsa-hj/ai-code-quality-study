const request = require("supertest");

const app = require("../src/app");

require("./setup");

const registerAndLogin = async () => {
  const response = await request(app).post("/api/v1/auth/register").send({
    name: "Linus Torvalds",
    email: "linus@example.com",
    password: "strongpass123",
  });

  return response.body.data.token;
};

describe("Task API", () => {
  test("creates a task for the authenticated user", async () => {
    const token = await registerAndLogin();

    const response = await request(app)
      .post("/api/v1/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({
        title: "Ship REST API",
        description: "Finish the modular task manager",
        priority: "high",
      })
      .expect(201);

    expect(response.body.success).toBe(true);
    expect(response.body.data.title).toBe("Ship REST API");
  });

  test("lists only the authenticated user tasks", async () => {
    const token = await registerAndLogin();

    await request(app)
      .post("/api/v1/tasks")
      .set("Authorization", `Bearer ${token}`)
      .send({ title: "Task One" });

    const response = await request(app)
      .get("/api/v1/tasks")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.count).toBe(1);
  });
});
