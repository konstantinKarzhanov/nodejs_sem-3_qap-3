// Import required functions/variables from custom modules
const pool = require("../config/pgPool");

// Define a function to get data from specified table
const getData = async (table, orderByColumn, orderByOrder, limit) => {
  try {
    const query = {
      text: `SELECT * FROM ${table} ORDER BY ${orderByColumn} ${orderByOrder} LIMIT ${limit}`,
      rowMode: "array",
    };
    const result = await pool.query(query);

    return result.rows;
  } catch (err) {
    console.log(err.message);
    throw err;
  }
};

// Define a function to get data from specified table using id
const getDataByID = async (table, idColumn, id) => {
  try {
    const query = `SELECT * FROM ${table} WHERE ${idColumn} = $1`;
    const result = await pool.query(query, [id]);

    return result.rows;
  } catch (err) {
    console.log(err.message);
    throw err;
  }
};

// Define a function to add new data to the database
const addData = async (table, keyArr, valueArr) => {
  try {
    const query = `INSERT INTO ${table}(${keyArr}) VALUES (${valueArr.map(
      (_, index) => "$" + (index + 1)
    )})`;

    await pool.query(query, [...valueArr]);
  } catch (err) {
    console.log(err.message);
    throw err;
  }
};

// Export functions/variables to use in other modules
module.exports = {
  getData,
  getDataByID,
  addData,
};
