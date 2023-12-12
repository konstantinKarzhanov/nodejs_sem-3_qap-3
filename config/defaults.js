// Define required variables
const limit = 20;

// Define navbar variables for different pages
const navbarMainMap = new Map([
  ["guests", "/guests"],
  ["api", "/api"],
]);

const navbarGuestsMap = new Map([
  ["home", "/home"],
  ["api", "/api"],
]);

const navbarApiMap = new Map([
  ["home", "/home"],
  ["guests", "/api/guests"],
]);

const navbarNotFoundMap = new Map([
  ["home", "/home"],
  ["guests", "/guests"],
  ["api", "/api"],
]);

// Export functions/variables to use in other modules
module.exports = {
  limit,
  navbarMainMap,
  navbarGuestsMap,
  navbarApiMap,
  navbarNotFoundMap,
};
