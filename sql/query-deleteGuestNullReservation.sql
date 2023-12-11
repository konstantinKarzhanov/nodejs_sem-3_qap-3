-- buildUpdateReservationQuery:

-- in case we know guest_id
UPDATE reservation 
SET 
  guest_id = NULL, 
  last_update = NOW() 
WHERE guest_id = 1;

-- in case we do not know guest_id
UPDATE reservation 
SET 
  guest_id = NULL, 
  last_update = NOW() 
WHERE guest_id IN (
  SELECT guest_id 
  FROM guest 
  WHERE guest_lname = 'test' AND guest_dob = '2023-12-06'
);

-- buildDeleteGuestQuery:
-- in case we know guest_id
DELETE FROM guest 
WHERE guest_id = 1;

-- in case we do not know guest_id
DELETE FROM guest 
WHERE guest_id IN (
  SELECT guest_id 
  FROM guest 
  WHERE guest_lname = 'test' AND guest_dob = '2023-12-06'
);