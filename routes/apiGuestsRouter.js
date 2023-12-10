// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const {
  getGuests,
  getGuestById,
  postGuest,
  updateGuest,
  deleteGuest,
} = require("../controllers/guestsController");

// Set router
const apiGuestsRouter = express.Router();

// Set route handlers
apiGuestsRouter
  .route("/")
  .get(getGuests, (req, res) => {
    const { data, statusCode } = res;

    res.json(
      statusCode == 200
        ? data
        : statusCode == 404
        ? { message: "Not Found", status: statusCode }
        : { message: "Service Unavailable", status: statusCode }
    );
  })
  .post(postGuest, (req, res) => {
    const { statusCode } = res;
    const message = statusCode == 201 ? "Created" : "Service Unavailable";

    res.json({ message, status: statusCode });
  })
  .delete(deleteGuest, (req, res) => {
    const { statusCode } = res;
    const message = statusCode == 200 ? "OK" : "Service Unavailable";

    res.json({ message, status: statusCode });
  });

// Set route handlers for named routes (parameters)
apiGuestsRouter
  .route("/:id")
  .get(getGuestById, (req, res) => {
    const { data, statusCode } = res;

    res.json(
      statusCode == 200
        ? data
        : statusCode == 404
        ? { message: "Not Found", status: statusCode }
        : { message: "Service Unavailable", status: statusCode }
    );
  })
  .put(updateGuest, (req, res) => {
    const { statusCode } = res;
    const message = statusCode == 200 ? "OK" : "Service Unavailable";

    res.json({ message, status: statusCode });
  })
  .patch(updateGuest, (req, res) => {
    const { statusCode } = res;
    const message = statusCode == 200 ? "OK" : "Service Unavailable";

    res.json({ message, status: statusCode });
  })
  .delete(deleteGuest, (req, res) => {
    const { statusCode } = res;
    const message = statusCode == 200 ? "OK" : "Service Unavailable";

    res.json({ message, status: statusCode });
  });

// Export the router to use in other modules
module.exports = apiGuestsRouter;
