/*
 * This SQL code snippet performs an upsert operation to insert guest information into the "guest" table, 
 * ensuring uniqueness based on the "uq_guest" constraint.
 * The Common Table Expression (CTE) is used to insert a new address, handling potential conflicts and retrieving the "address_id"
 * The "COALESCE" function helps retrieve the "address_id" from the "CTE" if a new address is successfully inserted 
 * or from the "address" table if the address existed in the database.
 * The "ON CONFLICT" clause prevents conflicts on the unique constraints, updating the existing entry in case of a conflict.
 */

-- Use a Common Table Expression (CTE) to insert new address and retrieve the "address_id", considering possible conflicts
WITH cte_address AS (
	INSERT INTO 
		address (street, city, province, postal_code)
	VALUES 
		('140 Maple Street', 'Toronto', 'ON', 'M5A1A1')
	ON CONFLICT ON CONSTRAINT uq_address DO NOTHING
	RETURNING address_id
)

-- Insert guest details, considering possible conflicts
INSERT INTO 
	guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone)
VALUES
	-- Use COALESCE to prioritize the new "address_id" from the CTE or existing one if CTE returns NULL
	(COALESCE((SELECT address_id FROM cte_address), (SELECT address_id FROM address WHERE street = '140 Maple Street' AND city = 'Toronto' AND province = 'ON' AND postal_code = 'M5A1A1')), 'Georgianna', 'Hatrey', '1996-09-11', 'ghatrey0@rambler.ru', '6578443594')
-- Handle conflicts on the guest table based on the unique constraint "uq_guest"
ON CONFLICT ON CONSTRAINT uq_guest DO
UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW();