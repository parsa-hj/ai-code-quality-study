require("dotenv").config();

const app = require("./app");
const connectDatabase = require("./config/database");

const port = process.env.PORT || 3000;

const startServer = async () => {
  await connectDatabase();

  app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
  });
};

startServer().catch((error) => {
  console.error("Failed to start server:", error.message);
  process.exit(1);
});
