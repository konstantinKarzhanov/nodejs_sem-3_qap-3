// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const { navbarApiMap } = require("../config/defaults");
const {
  getGuests,
  getGuestById,
  postGuest,
  updateGuest,
  deleteGuest,
} = require("../controllers/guestsController");

// Set router
const apiRouter = express.Router();

// Set route handlers
apiRouter.get("/", (req, res) => {
  res.render("api", {
    title: "API",
    h1Title: "API Page",
    navbar: navbarApiMap,
  });
});

apiRouter
  .route("/guests")
  .get(getGuests, (req, res) => {
    res.json(res.data);
  })
  .post(postGuest, (req, res) => {
    res.redirect("api/guests");
  })
  .delete(deleteGuest, (req, res) => {
    res.redirect("api/guests");
  });
// .patch(updateGuest, (req, res) => {
//   res.redirect("api/guests");
// })
// .put(updateGuest, (req, res) => {
//   res.redirect("api/guests");
// })

apiRouter
  .route("/guests/:id")
  .get(getGuestById, (req, res) => {
    res.json(res.data);
  })
  .patch(updateGuest, (req, res) => {
    res.statusCode = 200;
    res.json({ message: "OK", status: 200 });
  });

// Export the router to use in other modules
module.exports = apiRouter;
