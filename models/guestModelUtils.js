// Define a function to build query param array with data like '$1'
const buildParamArr = (arr, startNum = 0) => {
  return arr.map((_, index) => "$" + (++index + startNum));
};

// Define a function to build set clause array with data for SET and WHERE statements
const buildSetClauseArr = (arr, startNum = 0) => {
  return arr.map((item, index) => `${item} = $${++index + startNum}`);
};

// Define a function to build complex update query
const buildUpdateGuestWithInsertAddressQuery = (guestArr, addressArr) => {
  // Set a variable that contains part of the Common Table Expression
  const insertAddressQuery = `INSERT INTO address (${addressArr}) VALUES (${buildParamArr(
    addressArr,
    guestArr.length
  )})`;

  // Set variables that contains parts of the COALESCE function
  const selectAddressIdCTEQuery = "SELECT address_id FROM cte_address";
  const selectAddressIdQuery = `SELECT address_id FROM address WHERE ${buildSetClauseArr(
    addressArr,
    guestArr.length
  ).join(" AND ")}`;

  // Set variable that contains COALESCE function
  const coalesceAddressIdQuery = `COALESCE((${selectAddressIdCTEQuery}), (${selectAddressIdQuery}))`;

  // Set variable that contains Common Table Expression
  const cte = `WITH cte_address AS (${insertAddressQuery} ON CONFLICT ON CONSTRAINT uq_address DO NOTHING RETURNING address_id)`;

  // Set variable that contains parts of SET clause for UPDATE statement
  const setClause = `address_id = ${coalesceAddressIdQuery}, last_update = NOW()${
    guestArr.length > 1 ? ", " + buildSetClauseArr(guestArr.slice(1), 1) : ""
  }`;

  // return query
  return `${cte} UPDATE guest SET ${setClause} WHERE guest_id = $1;`;
};

// Define a function to build UPDATE query
const buildUpdateGuestQuery = (arr) => {
  const setClause = `${buildSetClauseArr(arr, 1)}, last_update = NOW()`;

  // return query
  return `UPDATE guest SET ${setClause} WHERE guest_id = $1;`;
};

// Define a function to build UPDATE query
const buildUpdateAddressQuery = (arr) => {
  const selectAddressIdGuestQuery = `SELECT address_id FROM guest WHERE guest_id = $1`;
  const setClause = `${buildSetClauseArr(arr, 1)}, last_update = NOW()`;

  // return query
  return `UPDATE address SET ${setClause} WHERE address_id = (${selectAddressIdGuestQuery});`;
};

// Define a function to build UPDATE query
const buildUpdateReservationQuery = (keyArr, valueArr) => {
  let query = {};
  let text =
    "UPDATE reservation SET guest_id = NULL, last_update = NOW() WHERE guest_id ";

  if (keyArr.includes("guest_id")) {
    query = { text: (text += "= $1;"), values: [valueArr[0]] };
  } else {
    const selectGuestIdQuery = `SELECT guest_id FROM guest WHERE ${buildSetClauseArr(
      keyArr
    ).join(" AND ")}`;

    query = {
      text: (text += `IN (${selectGuestIdQuery});`),
      values: [...valueArr],
    };
  }

  return query;
};

// Define a function to build DELETE query
const buildDeleteGuestQuery = (keyArr, valueArr) => {
  let query = {};
  let text = "DELETE FROM guest WHERE guest_id ";

  if (keyArr.includes("guest_id")) {
    query = { text: (text += "= $1;"), values: [valueArr[0]] };
  } else {
    const selectGuestIdQuery = `SELECT guest_id FROM guest WHERE ${buildSetClauseArr(
      keyArr
    ).join(" AND ")}`;

    query = {
      text: (text += `IN (${selectGuestIdQuery});`),
      values: [...valueArr],
    };
  }

  return query;
};

// Export functions/variables to use in other modules
module.exports = {
  buildUpdateGuestWithInsertAddressQuery,
  buildUpdateGuestQuery,
  buildUpdateAddressQuery,
  buildUpdateReservationQuery,
  buildDeleteGuestQuery,
};
