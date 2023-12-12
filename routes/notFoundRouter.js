// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const { navbarNotFoundMap } = require("../config/defaults");

// Set router
const notFoundRouter = express.Router();

// Set route handlers
notFoundRouter.get("*", (req, res) => {
  const dataObj = {
    title: "Not Found",
    h1Title: "404: Not Found",
    navbar: navbarNotFoundMap,
  };

  res.render("404", dataObj);
});

// Export the router to use in other modules
module.exports = notFoundRouter;
