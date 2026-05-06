const express = require("express");
const router = express.Router();
const {
  createTask,
  getTasks,
  getTask,
  updateTask,
  deleteTask,
} = require("../controllers/taskController");
const authenticate = require("../middleware/auth");

// All task routes require authentication
router.use(authenticate);

// POST /api/tasks
router.post("/", createTask);

// GET /api/tasks  (supports ?completed=true|false, ?sortBy=field:asc|desc, ?limit=n, ?skip=n)
router.get("/", getTasks);

// GET /api/tasks/:id
router.get("/:id", getTask);

// PATCH /api/tasks/:id
router.patch("/:id", updateTask);

// DELETE /api/tasks/:id
router.delete("/:id", deleteTask);

module.exports = router;
