// Import required functions/variables from custom modules
const { limit } = require("../config/defaults");
const { getData, getDataByID, addData } = require("../models/generalModel");

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
  getGuests,
  getGuestUsingId,
  addGuest,
};
