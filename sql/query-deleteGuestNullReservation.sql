----------------------------
-- in case we know guest_id
----------------------------
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

----------------------------------
-- in case we do not know guest_id
----------------------------------
BEGIN;

buildUpdateReservationQuery:
UPDATE reservation 
SET 
  guest_id = NULL, 
  last_update = NOW() 
WHERE guest_id IN (
  SELECT guest_id 
  FROM guest 
  WHERE guest_lname = 'test' AND guest_dob = '2023-12-06'
);

buildDeleteGuestQuery:
DELETE FROM guest 
WHERE guest_id IN (
  SELECT guest_id 
  FROM guest 
  WHERE guest_lname = 'test' AND guest_dob = '2023-12-06'
);

COMMIT;
-- ROLLBACK;