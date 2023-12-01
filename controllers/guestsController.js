// Import required functions/variables from custom modules
const { limit } = require("../config/defaults");
const { getData, getDataByID } = require("../models/generalModel");
const { createGuestAddress } = require("../models/guestModel");

// Define a function to get specified number of guests
const getGuests = async (req, res, next) => {
  try {
    res.data = await getData("guest", "guest_id", "desc", limit);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define a function to get specified guest using id
const getGuestUsingId = async (req, res, next) => {
  const { id } = req.params;

  try {
    res.data = await getDataByID("guest", "guest_id", id);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define a function to add new guest to the database
const addGuest = async (req, res, next) => {
  const { body } = req;

  try {
    await createGuestAddress(body);
  } catch (err) {
    console.log(err);
  }

  next();
};

// Export functions/variables to use in other modules
module.exports = {
  getGuests,
  getGuestUsingId,
  addGuest,
};
