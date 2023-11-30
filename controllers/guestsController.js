// Import required functions/variables from custom modules
const { limit } = require("../config/defaults");
const { getAllData, getDataByID, addData } = require("../models/generalModel");

// Define function to get specified number of guests
const getAllGuests = async (req, res, next) => {
  try {
    res.data = await getAllData("guest", "guest_id", "desc", limit);
  } catch (err) {
    res.data = [];
    console.log(err.message);
  }

  next();
};

// Define function to get specified guest using id
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

// Define function to add new guest to the database
const addGuest = async (req, res, next) => {
  const { body } = req;
  const keyArr = [];
  const valueArr = [];

  try {
    for (const key in body) {
      keyArr.push(key);
      valueArr.push(body[key]);
    }

    await addData("guest", keyArr, valueArr);
  } catch (err) {
    console.log(err);
  }

  next();
};

// Export functions/variables to use in other modules
module.exports = {
  getAllGuests,
  getGuestUsingId,
  addGuest,
};
