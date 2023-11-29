// Import external packages
const express = require("express");

// Import required functions/variables from custom modules
const { navbarGuestsArr } = require("../config/defaults");
const {
  getAllGuests,
  getGuestUsingId,
  addGuest,
} = require("../controllers/guestsController");

// Set router
const guestsRouter = express.Router();

// Set route handlers
guestsRouter
  .route("/")
  .get(getAllGuests, (req, res) => {
    const dataObj = {
      title: "Guests",
      h1Title: "Guests Page",
      navbar: navbarGuestsArr,
      data: res.data,
    };

    res.render("guests", dataObj);
  })
  .post(addGuest, (req, res) => {
    res.redirect("/guests");
  });

guestsRouter.get("/:id", getGuestUsingId, (req, res) => {
  const dataObj = {
    title: "Guests",
    h1Title: "Guests Page",
    navbar: navbarGuestsArr,
    data: res.data,
  };

  res.render("guests", dataObj);
});

// Export the router to use in other modules
module.exports = guestsRouter;