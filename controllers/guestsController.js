// Import required functions/variables from custom modules
const { limit } = require("../config/defaults");
const { getData, getDataById } = require("../models/generalModel");
const {
  postGuestAddress,
  deleteGuestNullReservation,
} = require("../models/guestModel");

// Define a middleware function to get specified number of guests
const getGuests = async (req, res, next) => {
  try {
    res.data = await getData("guest", "guest_id", "desc", limit);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define a middleware function to get guests and addresses
const getGuestsPlusAddress = async (req, res, next) => {
  try {
    res.data = await getData("view_guests_address", "guest_id", "desc", limit);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define a middleware function to get specified guest using id
const getGuestById = async (req, res, next) => {
  const { id } = req.params;

  try {
    res.data = await getDataById("guest", "guest_id", id);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define a middleware function to add new guest to the database
const addGuest = async (req, res, next) => {
  const { body } = req;

  try {
    await postGuestAddress(body);
  } catch (err) {
    console.log(err);
  }

  next();
};

// Define a middleware function to delete a guest from the database
const deleteGuest = async (req, res, next) => {
  const { body } = req;
  const keyArr = [];
  const valueArr = [];

  for (key in body) {
    if (key.includes("guest_") && body[key].trim() != "") {
      keyArr.push(key);
      valueArr.push(body[key]);
    }
  }

  if (valueArr.length) await deleteGuestNullReservation(keyArr, valueArr);

  next();
};

// Export functions/variables to use in other modules
module.exports = {
  getGuests,
  getGuestsPlusAddress,
  getGuestById,
  addGuest,
  deleteGuest,
};
