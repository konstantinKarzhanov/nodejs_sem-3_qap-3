// Import required functions/variables from custom modules
const { limit } = require("../config/defaults");
const { readData, readDataById } = require("../models/generalModel");
const {
  createGuestAddress,
  updateGuestAddress,
  deleteGuestNullReservation,
} = require("../models/guestModel");

// Define a middleware function to get guests and addresses
const getGuests = async (req, res, next) => {
  try {
    res.data = await readData("view_guest_address", "guest_id", "desc", limit);
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
    res.data = await readDataById("view_guest_address", "guest_id", id);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define a middleware function to add new guest to the database
const postGuest = async (req, res, next) => {
  const { body } = req;

  try {
    await createGuestAddress(body);
  } catch (err) {
    console.log(err);
  }

  next();
};

// Define a middleware function to update a guest in the database
const updateGuest = async (req, res, next) => {
  const { body } = req;

  try {
    await updateGuestAddress(body);
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
    if (key.includes("guest_") && key != "guest_id" && body[key].trim() != "") {
      keyArr.push(key);
      valueArr.push(body[key]);
    }
  }

  if (valueArr.length) {
    try {
      await deleteGuestNullReservation(keyArr, valueArr);
    } catch (err) {
      console.log(err);
    }
  }

  next();
};

// Export functions/variables to use in other modules
module.exports = {
  getGuests,
  getGuestById,
  postGuest,
  updateGuest,
  deleteGuest,
};
