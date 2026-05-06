const request = require("supertest");

const app = require("../src/app");

require("./setup");

const createAuthenticatedUser = async () => {
  const response = await request(app).post("/api/v1/auth/register").send({
    name: "Margaret Hamilton",
    email: "margaret@example.com",
    password: "strongpass123",
  });

  return response.body.data.token;
};

describe("User API", () => {
  test("returns the current authenticated profile", async () => {
    const token = await createAuthenticatedUser();

    const response = await request(app)
      .get("/api/v1/users/me")
      .set("Authorization", `Bearer ${token}`)
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.data.name).toBe("Margaret Hamilton");
  });

  test("updates the current authenticated profile", async () => {
    const token = await createAuthenticatedUser();

    const response = await request(app)
      .patch("/api/v1/users/me")
      .set("Authorization", `Bearer ${token}`)
      .send({ name: "Margaret H." })
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.data.name).toBe("Margaret H.");
  });
});
