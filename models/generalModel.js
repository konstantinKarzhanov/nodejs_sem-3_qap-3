// Import required functions/variables from custom modules
const pool = require("../config/pgPool");

// Define a function to get data from specified table
const readData = async (table, orderByColumn, orderByOrder, limit) => {
  const query = `SELECT * FROM ${table} ORDER BY ${orderByColumn} ${orderByOrder} LIMIT ${limit};`;

  try {
    const result = await pool.query(query);

    return result.rows;
  } catch (err) {
    console.log(err.message);
    throw err;
  }
};

// Define a function to get data from specified table using id
const readDataById = async (table, idColumn, id) => {
  const query = `SELECT * FROM ${table} WHERE ${idColumn} = $1;`;

  try {
    const result = await pool.query(query, [id]);

    return result.rows;
  } catch (err) {
    console.log(err.message);
    throw err;
  }
};

// Export functions/variables to use in other modules
module.exports = {
  readData,
  readDataById,
};
