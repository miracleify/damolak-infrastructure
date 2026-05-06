require("dotenv").config();
const express = require("express");
const bcrypt = require("bcrypt");
const db = require("./db");

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 5050;

// Root route (browser check)
app.get("/", (req, res) => {
  res.send("Auth API is running 🚀");
});

// Health check
app.get("/health", (req, res) => {
  res.status(200).json({ status: "OK" });
});

// Register
app.post("/register", async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: "Missing fields" });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    db.run(
      "INSERT INTO users (email, password) VALUES (?, ?)",
      [email, hashedPassword],
      function (err) {
        if (err) {
          return res.status(500).json({ error: "User already exists" });
        }
        res.status(201).json({ message: "User registered" });
      }
    );
  } catch (error) {
    res.status(500).json({ error: "Server error" });
  }
});

// Login
app.post("/login", (req, res) => {
  const { email, password } = req.body;

  db.get(
    "SELECT * FROM users WHERE email = ?",
    [email],
    async (err, user) => {
      if (err || !user) {
        return res.status(401).json({ error: "Invalid credentials" });
      }

      const match = await bcrypt.compare(password, user.password);

      if (!match) {
        return res.status(401).json({ error: "Invalid credentials" });
      }

      res.status(200).json({ message: "Login successful" });
    }
  );
});

// 🔥 IMPORTANT FIX: bind to 0.0.0.0
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});