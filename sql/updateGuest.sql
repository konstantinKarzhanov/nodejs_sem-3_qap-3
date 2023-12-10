/*
 * This SQL query updates guest information in the "guest" table and adds a new address to the address table if a new address was provided. 
 * The Common Table Expression (CTE) is used to insert a new address, handling potential conflicts and retrieving the "address_id"
 * The "COALESCE" function helps retrieve the "address_id" from the "CTE" if a new address is successfully inserted 
 * or from the "address" table if the address existed in the database.
 */

-- Use a Common Table Expression (CTE) to insert new address 
-- and retrieve the "address_id", considering possible conflicts
WITH cte_address AS (
	INSERT INTO 
		address (address_street, address_city, address_province, address_postal_code) 
	VALUES
    ('120 Elm Street','Oshawa','ON','L1H7K9') 
	ON CONFLICT ON CONSTRAINT uq_address DO NOTHING 
	RETURNING address_id
)
-- Update guest information
UPDATE guest 
SET 
	-- Use COALESCE to prioritize the new "address_id" from the CTE 
  -- or existing one if CTE returns NULL
	address_id = COALESCE(
		(SELECT address_id FROM cte_address), 
		(SELECT address_id FROM address WHERE address_street = '120 Elm Street' AND address_city = 'Oshawa' AND address_province = 'ON' AND address_postal_code = 'L1H7K9')
	),
	guest_fname = 'test',
	guest_lname = 'test',
	guest_dob = '2023-12-06',
  guest_email = 'test@test.com',
  guest_phone = '123456789'
WHERE 
	guest_id = 50;