// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const { navbarApiMap } = require("../config/defaults");

// Import routes from custom modules
const apiGuestsRouter = require("./apiGuestsRouter");

// Set router
const apiIndexRouter = express.Router();

// Set routes
apiIndexRouter.use("/guests", apiGuestsRouter);

// Set route handlers
apiIndexRouter.get("/", (req, res) => {
  res.render("api", {
    title: "API",
    h1Title: "API Page",
    navbar: navbarApiMap,
  });
});

// Export the router to use in other modules
module.exports = apiIndexRouter;
