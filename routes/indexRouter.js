// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const { navbarMainArr } = require("../config/defaults");

// Set router
const indexRouter = express.Router();

// Set route handlers
indexRouter.get("^/$|^/home$", (req, res) => {
  res.render("index", {
    title: "Home",
    h1Title: "Home Page",
    navbar: navbarMainArr,
  });
});

// Export the router to use in other modules
module.exports = indexRouter;
