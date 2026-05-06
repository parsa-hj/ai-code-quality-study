const express = require("express");
const app = express();
const mongoose = require("mongoose");

// Connect to MongoDB
mongoose.connect("mongodb://localhost/task-manager", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Define the Task model
const taskSchema = new mongoose.Schema({
  title: String,
  description: String,
  status: String,
});
const Task = mongoose.model("Task", taskSchema);

// Define the REST API endpoints
app.get("/tasks", async (req, res) => {
  const tasks = await Task.find();
  res.json(tasks);
});

app.post("/tasks", async (req, res) => {
  const task = new Task(req.body);
  await task.save();
  res.json(task);
});

app.put("/tasks/:id", async (req, res) => {
  const task = await Task.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
  });
  res.json(task);
});

app.delete("/tasks/:id", async (req, res) => {
  await Task.findByIdAndDelete(req.params.id);
  res.json({ message: "Task deleted" });
});

app.listen(3000, () => {
  console.log("Server listening on port 3000");
});
