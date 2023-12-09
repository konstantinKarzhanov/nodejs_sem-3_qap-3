// Import required functions/variables from custom modules
const pool = require("../config/pgPool");
const {
  buildUpdateGuestWithInsertAddressQuery,
  buildUpdateGuestQuery,
  buildUpdateAddressQuery,
} = require("./guestModelUtils");

// Define a function to create a new record in the "guest" and "address" tables
const createGuestAddress = async ({
  guest_fname,
  guest_lname,
  guest_dob,
  guest_email,
  guest_phone,
  address_street,
  address_city,
  address_province,
  address_postal_code,
}) => {
  // Set a variable that contains part of the main query
  const insertAddressQuery =
    "INSERT INTO address (address_street, address_city, address_province, address_postal_code) VALUES ($1, $2, $3, $4)";

  // Set variables that contains parts of the COALESCE function
  const selectAddressIdCTEQuery = "SELECT address_id FROM cte_address";
  const selectAddressIdQuery =
    "SELECT address_id FROM address WHERE address_street = $1 AND address_city = $2 AND address_province = $3 AND address_postal_code = $4";

  // Set variable that contains COALESCE function
  const coalesceAddressIdQuery = `COALESCE((${selectAddressIdCTEQuery}), (${selectAddressIdQuery}))`;

  // Set variables that are parts of the final query
  const insertIntoGuestQuery = `INSERT INTO guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone) VALUES (${coalesceAddressIdQuery}, $5, $6, $7, $8, $9)`;
  const upsertGuestQuery =
    "UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW()";

  // Set variables that are the main blocks of the final query
  const cte = `WITH cte_address AS (${insertAddressQuery} ON CONFLICT ON CONSTRAINT uq_address DO NOTHING RETURNING address_id)`;
  const upsert = `${insertIntoGuestQuery} ON CONFLICT ON CONSTRAINT uq_guest DO ${upsertGuestQuery}`;

  // Set the query variable
  const query = `${cte} ${upsert};`;

  try {
    await pool.query(query, [
      address_street,
      address_city,
      address_province,
      address_postal_code,
      guest_fname,
      guest_lname,
      guest_dob,
      guest_email,
      guest_phone,
    ]);
  } catch (err) {
    console.log(err.message);
    throw err;
  }
};

// Define a function to update a record in the "guest" table and update/create in the "address" table
const updateGuestAddress = async (
  keyGuestArr,
  valueGuestArr,
  keyAddressArr,
  valueAddressArr,
  countKeyAddress
) => {
  // Acquire a client from the pool
  const client = await pool.connect();

  try {
    // Begin transaction
    await client.query("BEGIN;");

    if (keyAddressArr.length == countKeyAddress) {
      const updateGuestAddressQuery = buildUpdateGuestWithInsertAddressQuery(
        keyGuestArr,
        keyAddressArr
      );
      await client.query(updateGuestAddressQuery, [
        ...valueGuestArr,
        ...valueAddressArr,
      ]);
    } else {
      if (keyGuestArr.length > 1) {
        const updateGuestQuery = buildUpdateGuestQuery(keyGuestArr);
        await client.query(updateGuestQuery, [...valueGuestArr]);
      }

      if (keyAddressArr.length) {
        const updateAddressQuery = buildUpdateAddressQuery(keyAddressArr);
        await client.query(updateAddressQuery, [
          valueGuestArr[0],
          ...valueAddressArr,
        ]);
      }
    }

    // Commit transaction
    await client.query("COMMIT;");
  } catch (err) {
    // Rollback transaction
    await client.query("ROLLBACK;");
    console.log(err.message);
    throw err;
  } finally {
    // Return a client back to the pool
    client.release();
  }
};

// Define a function to delete a guest from the database and set the corresponding guest_id to NULL in the 'reservation' table
const deleteGuestNullReservation = async (keyArr, valueArr) => {
  const conditionArr = keyArr.map((item, index) => `${item} = $${index + 1}`);
  if (!conditionArr.length) return;

  const selectGuestIdQuery = `SELECT guest_id FROM guest WHERE ${conditionArr.join(
    " AND "
  )}`;
  const updateReservationQuery = `UPDATE reservation SET guest_id = NULL, last_update = NOW() WHERE guest_id IN (${selectGuestIdQuery});`;
  const deleteGuestQuery = `DELETE FROM guest WHERE guest_id IN (${selectGuestIdQuery});`;

  // Acquire a client from the pool
  const client = await pool.connect();

  try {
    // Begin transaction
    await client.query("BEGIN;");
    await client.query(updateReservationQuery, [...valueArr]);
    await client.query(deleteGuestQuery, [...valueArr]);

    // Commit transaction
    await client.query("COMMIT;");
  } catch (err) {
    // Rollback transaction
    await client.query("ROLLBACK;");
    console.log(err.message);
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
