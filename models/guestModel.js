// Import required functions/variables from custom modules
const pool = require("../config/pgPool");

// Define a function to create a new record in the "guest" and "address" tables
const createGuestAddress = async ({
  guest_fname,
  guest_lname,
  guest_dob,
  guest_email,
  guest_phone,
  street,
  city,
  province,
  postal_code,
}) => {
  // Set a variable that is part of the final query
  const insertIntoAddressQuery =
    "INSERT INTO address (street, city, province, postal_code) VALUES ($1, $2, $3, $4)";

  // Set the parts of the COALESCE function
  const selectAddressIdFromCTEQuery = "SELECT address_id FROM cte_address";
  const selectAddressIdFromAddressQuery =
    "SELECT address_id FROM address WHERE street = $1 AND city = $2 AND province = $3 AND postal_code = $4)";
  const coalesceAddressIdQuery = `COALESCE((${selectAddressIdFromCTEQuery}), (${selectAddressIdFromAddressQuery})`;

  // Set variables that are parts of the final query
  const insertIntoGuestQuery = `INSERT INTO guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone) VALUES (${coalesceAddressIdQuery}, $5, $6, $7, $8, $9)`;
  const updateGuestQuery =
    "UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW()";

  // Set variables that are the main blocks of the final query
  const cte = `WITH cte_address AS (${insertIntoAddressQuery} ON CONFLICT ON CONSTRAINT uq_address DO NOTHING RETURNING address_id)`;
  const upsert = `${insertIntoGuestQuery} ON CONFLICT ON CONSTRAINT uq_guest DO ${updateGuestQuery}`;

  // Set the query variable
  const query = `${cte} ${upsert};`;

  try {
    await pool.query(query, [
      street,
      city,
      province,
      postal_code,
      guest_fname,
      guest_lname,
      guest_dob,
      guest_email,
      guest_phone,
    ]);
  } catch (err) {
    console.log(err);
    throw err;
  }
};

// Define a function to update a record in the "guest" table and update/create in the "address" table
const updateGuestAddress = async ({
  guest_id,
  guest_fname,
  guest_lname,
  guest_dob,
  guest_email,
  guest_phone,
  street,
  city,
  province,
  postal_code,
}) => {
  // Set a variable that is part of the final query
  const insertIntoAddressQuery =
    "INSERT INTO address (street, city, province, postal_code) VALUES ($1, $2, $3, $4)";

  // Set the parts of the COALESCE function
  const selectAddressIdFromCTEQuery = "SELECT address_id FROM cte_address";
  const selectAddressIdFromAddressQuery =
    "SELECT address_id FROM address WHERE street = $1 AND city = $2 AND province = $3 AND postal_code = $4)";
  const coalesceAddressIdQuery = `COALESCE((${selectAddressIdFromCTEQuery}), (${selectAddressIdFromAddressQuery})`;

  // Set variables that are the main blocks of the final query
  const cte = `WITH cte_address AS (${insertIntoAddressQuery} ON CONFLICT ON CONSTRAINT uq_address DO NOTHING RETURNING address_id)`;
  const setClause = `SET address_id = ${coalesceAddressIdQuery}, guest_fname = $5, guest_lname = $6, guest_dob = $7, guest_email = $8, guest_phone = $9`;

  // Set the query variable
  const query = `${cte} UPDATE guest ${setClause} WHERE guest_id = $10;`;

  try {
    await pool.query(query, [
      street,
      city,
      province,
      postal_code,
      guest_fname,
      guest_lname,
      guest_dob,
      guest_email,
      guest_phone,
      guest_id,
    ]);
  } catch (err) {
    console.log(err);
    throw err;
  }
};

// Define a function to delete a guest from the database and set the corresponding guest_id to NULL in the 'reservation' table
const deleteGuestNullReservation = async (keyArr, valueArr) => {
  const conditionArr = keyArr.map((item, index) => `${item} = $${index + 1}`);
  if (!conditionArr.length) return;

  const selectGuestIdQuery = `SELECT guest_id FROM guest WHERE ${conditionArr.join(
    " AND "
  )}`;
  const updateReservationQuery = `UPDATE reservation SET guest_id = NULL WHERE guest_id IN (${selectGuestIdQuery});`;
  const deleteGuestQuery = `DELETE FROM guest WHERE guest_id IN (${selectGuestIdQuery});`;

  // Acquire a client from the pool
  const client = await pool.connect();

  try {
    await client.query("BEGIN;");
    await client.query(updateReservationQuery, [...valueArr]);
    await client.query(deleteGuestQuery, [...valueArr]);
    await client.query("COMMIT;");
  } catch (err) {
    await client.query("ROLLBACK;");
    console.log(err);
    throw err;
  } finally {
    // Return a client back to the pool
    client.release();
  }
};

module.exports = {
  createGuestAddress,
  updateGuestAddress,
  deleteGuestNullReservation,
};
