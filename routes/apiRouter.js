// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const {
  getAllGuests,
  getGuestUsingId,
} = require("../controllers/guestsController");

// Set router
const apiRouter = express.Router();

// Set route handlers
apiRouter.get("/", (req, res) => {
  res.send("API Page");
});

apiRouter.get("/guests", getAllGuests, (req, res) => {
  res.send(res.data);
});

apiRouter.get("/guests/:id", getGuestUsingId, (req, res) => {
  res.send(res.data);
});

// Export the router to use in other modules
module.exports = apiRouter;