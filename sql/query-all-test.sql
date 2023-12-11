SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;

-- *************************
-- query-readData:
-- *************************
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;

-- *************************
-- query-readDataById:
-- *************************
SELECT * FROM view_guest_address WHERE guest_id = 1;

-- *************************
-- query-createGuestAddress:
-- *************************
------------------------------------------------------
-- test-1: Add new guest, who shares the same address
------------------------------------------------------------------
SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------
WITH cte_address AS (
	INSERT INTO 
		address (address_street, address_city, address_province, address_postal_code)
	VALUES 
		('131 Main Street', 'Barrie', 'ON', 'L1D2W3')
	ON CONFLICT ON CONSTRAINT uq_address DO NOTHING
	RETURNING address_id
)

-- Insert guest details, considering possible conflicts
INSERT INTO 
	guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone)
VALUES
	-- Use COALESCE to prioritize the new "address_id" from the CTE or existing one if CTE returns NULL
	(COALESCE((SELECT address_id FROM cte_address), (SELECT address_id FROM address WHERE address_street = '131 Main Street' AND address_city = 'Barrie' AND address_province = 'ON' AND address_postal_code = 'L1D2W3')), 'test1', 'test', '2023-12-10', 'test@test.com', '6578443594')
-- Handle conflicts on the guest table based on the unique constraint "uq_guest"
ON CONFLICT ON CONSTRAINT uq_guest DO
UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW();

------------------------------------------------------
-- test-2: Add new guest, with new address
------------------------------------------------------------------
SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------

WITH cte_address AS (
	INSERT INTO 
		address (address_street, address_city, address_province, address_postal_code)
	VALUES 
		('666 SatanClause Street', 'North', 'TT', 'A1A2A3')
	ON CONFLICT ON CONSTRAINT uq_address DO NOTHING
	RETURNING address_id
)

-- Insert guest details, considering possible conflicts
INSERT INTO 
	guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone)
VALUES
	-- Use COALESCE to prioritize the new "address_id" from the CTE or existing one if CTE returns NULL
	(COALESCE((SELECT address_id FROM cte_address), (SELECT address_id FROM address WHERE address_street = '666 SatanClause Street' AND address_city = 'North' AND address_province = 'TT' AND address_postal_code = 'A1A2A3')), 'test2', 'test', '2023-12-10', 'test2@test.com', '6578443594')
-- Handle conflicts on the guest table based on the unique constraint "uq_guest"
ON CONFLICT ON CONSTRAINT uq_guest DO
UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW();

------------------------------------------------------
-- test-3: Update address for the unique guest
------------------------------------------------------------------
SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------
WITH cte_address AS (
	INSERT INTO 
		address (address_street, address_city, address_province, address_postal_code)
	VALUES 
		('4 Privet Drive', 'London', 'LL', 'B1B2B3')
	ON CONFLICT ON CONSTRAINT uq_address DO NOTHING
	RETURNING address_id
)

-- Insert guest details, considering possible conflicts
INSERT INTO 
	guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone)
VALUES
	-- Use COALESCE to prioritize the new "address_id" from the CTE or existing one if CTE returns NULL
	(COALESCE((SELECT address_id FROM cte_address), (SELECT address_id FROM address WHERE address_street = '4 Privet Drive' AND address_city = 'London' AND address_province = 'LL' AND address_postal_code = 'B1B2B3')), 'test2', 'test', '2023-12-10', 'test2@test.com', '6578443594')
-- Handle conflicts on the guest table based on the unique constraint "uq_guest"
ON CONFLICT ON CONSTRAINT uq_guest DO
UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW();

---------------------------------------------------------
-- test-4: Update info of the unique guest (email, phone)
------------------------------------------------------------------
SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------
WITH cte_address AS (
	INSERT INTO 
		address (address_street, address_city, address_province, address_postal_code)
	VALUES 
		('4 Privet Drive', 'London', 'LL', 'B1B2B3')
	ON CONFLICT ON CONSTRAINT uq_address DO NOTHING
	RETURNING address_id
)

-- Insert guest details, considering possible conflicts
INSERT INTO 
	guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone)
VALUES
	-- Use COALESCE to prioritize the new "address_id" from the CTE or existing one if CTE returns NULL
	(COALESCE((SELECT address_id FROM cte_address), (SELECT address_id FROM address WHERE address_street = '4 Privet Drive' AND address_city = 'London' AND address_province = 'LL' AND address_postal_code = 'B1B2B3')), 'test2', 'test', '2023-12-10', 'updatedtest2@test.com', '1111111111')
-- Handle conflicts on the guest table based on the unique constraint "uq_guest"
ON CONFLICT ON CONSTRAINT uq_guest DO
UPDATE SET address_id = EXCLUDED.address_id, guest_email = EXCLUDED.guest_email, guest_phone = EXCLUDED.guest_phone, last_update = NOW();

-- *************************
-- query-updateGuestAddress
-- *************************
---------------------------------------------------------
-- test-5: Update guest information use existed address
---------------------------------------------------------
-- buildUpdateGuestWithInsertAddressQuery()
---------------
-- first part
------------------------------------------------------------------
SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
SELECT * FROM address ORDER BY address_id DESC LIMIT 10;
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------
BEGIN;

WITH cte_address AS (
	INSERT INTO 
		address (address_street, address_city, address_province, address_postal_code) 
	VALUES
    ('4 Privet Drive', 'London', 'LL', 'B1B2B3') 
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
		(SELECT address_id FROM address WHERE address_street = '4 Privet Drive' AND address_city = 'London' AND address_province = 'LL' AND address_postal_code = 'B1B2B3')
	), 
	guest_fname = 'Harry',
	guest_lname = 'Potter',
	guest_dob = '2023-12-10',
  	guest_email = 'hp@test.com',
  	guest_phone = '9999999999',
	last_update = NOW()
	
WHERE 
	guest_id = 52;

COMMIT;
-- ROLLBACK;

-- ---------------
-- -- second part
-- ------------------------------------------------------------------
-- SELECT * FROM guest ORDER BY guest_id DESC LIMIT 10;
-- SELECT * FROM address ORDER BY address_id DESC LIMIT 10;
-- SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------
-- BEGIN;

-- -- buildUpdateGuestQuery():
-- -- This SQL query updates guest information in the "guest" table
-- -- (these queries must be wrapped in Transaction)

-- UPDATE guest 
-- SET		
-- 	guest_fname = 'updatedHarry',
-- 	guest_lname = 'updatedPotter',
-- 	guest_dob = '2023-12-07',
--   	guest_email = 'updatedhp@test.com',
--   	guest_phone = '6666666666',
-- 	last_update = NOW()

-- WHERE guest_id = 52;

-- -- buildUpdateAddressQuery():
-- -- This SQL query updates address information in the "address" table

-- UPDATE address 
-- SET 
-- 	address_street = '99 updatedPrivet Drive', 
-- 	last_update = NOW() 

-- WHERE address_id = (SELECT address_id FROM guest WHERE guest_id = 52);

-- COMMIT;
-- -- ROLLBACK;

-- *********************************
-- query-deleteGuestNullReservation
-- *********************************
--------------------------------------------------------------
-- test-6: Delete guest and NULL they're reservation if exist
------------------------------------------------------------------
SELECT * FROM guest ORDER BY guest_id ASC LIMIT 10;
SELECT * FROM address ORDER BY address_id ASC LIMIT 10;
SELECT * FROM reservation ORDER BY guest_id
SELECT * FROM view_reservation_details
SELECT * FROM view_guest_address ORDER BY guest_id DESC LIMIT 10;
-- ------------------------------------------------------------------
-- in case we know guest_id
BEGIN;
-- buildUpdateReservationQuery:
UPDATE reservation 
SET 
  guest_id = NULL, 
  last_update = NOW() 
WHERE guest_id = 1;

-- buildDeleteGuestQuery:
DELETE FROM guest 
WHERE guest_id = 1;

COMMIT;
-- ROLLBACK;

-- -- in case we do not know guest_id
-- BEGIN;

-- -- buildUpdateReservationQuery:
-- UPDATE reservation 
-- SET 
--   guest_id = NULL, 
--   last_update = NOW() 
-- WHERE guest_id IN (
--   SELECT guest_id 
--   FROM guest 
--   WHERE guest_lname = 'Nequest' AND guest_dob = '1981-12-01'
-- );

-- -- buildDeleteGuestQuery:
-- DELETE FROM guest 
-- WHERE guest_id IN (
--   SELECT guest_id 
--   FROM guest 
--   WHERE guest_lname = 'Nequest' AND guest_dob = '1981-12-01'
-- );

-- COMMIT;
-- -- ROLLBACK;