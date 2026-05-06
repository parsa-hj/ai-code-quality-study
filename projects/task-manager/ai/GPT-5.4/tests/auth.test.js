const request = require("supertest");

const app = require("../src/app");

require("./setup");

describe("Auth API", () => {
  test("registers a new user", async () => {
    const response = await request(app)
      .post("/api/v1/auth/register")
      .send({
        name: "Ada Lovelace",
        email: "ada@example.com",
        password: "strongpass123",
      })
      .expect(201);

    expect(response.body.success).toBe(true);
    expect(response.body.data.user.email).toBe("ada@example.com");
    expect(response.body.data.token).toBeTruthy();
  });

  test("logs in an existing user", async () => {
    await request(app).post("/api/v1/auth/register").send({
      name: "Grace Hopper",
      email: "grace@example.com",
      password: "strongpass123",
    });

    const response = await request(app)
      .post("/api/v1/auth/login")
      .send({
        email: "grace@example.com",
        password: "strongpass123",
      })
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.data.token).toBeTruthy();
  });
});
