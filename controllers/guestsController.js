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
    console.log(err.message);
  }

  next();
};

// Define a middleware function to update a guest in the database
const updateGuest = async (req, res, next) => {
  let { body } = req;
  const { id } = req.params;

  const keyGuestArr = [];
  const valueGuestArr = [];
  const keyAddressArr = [];
  const valueAddressArr = [];
  let countKeyAddress = 0;

  if (id) {
    body = { guest_id: id, ...body };
  }

  for (const key in body) {
    if (key.includes("guest_") && body[key].trim() != "") {
      keyGuestArr.push(key);
      valueGuestArr.push(body[key]);
    } else if (key.includes("address_")) {
      countKeyAddress++;

      if (body[key].trim() != "") {
        keyAddressArr.push(key);
        valueAddressArr.push(body[key]);
      }
    }
  }

  if (valueGuestArr.length || valueAddressArr.length) {
    try {
      await updateGuestAddress(
        keyGuestArr,
        valueGuestArr,
        keyAddressArr,
        valueAddressArr,
        countKeyAddress
      );
    } catch (err) {
      console.log(err.message);
    }
  }

  next();
};

// Define a middleware function to delete a guest from the database
const deleteGuest = async (req, res, next) => {
  const { body } = req;
  const keyArr = [];
  const valueArr = [];

  for (const key in body) {
    if (key.includes("guest_") && key != "guest_id" && body[key].trim() != "") {
      keyArr.push(key);
      valueArr.push(body[key]);
    }
  }

  if (valueArr.length) {
    try {
      await deleteGuestNullReservation(keyArr, valueArr);
    } catch (err) {
      console.log(err.message);
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
