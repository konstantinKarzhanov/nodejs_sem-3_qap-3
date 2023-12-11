-- ---------------------------
-- queries for "room" table
-- ---------------------------
SELECT * FROM room;
DELETE FROM room;

-- fill table with mock data
INSERT INTO 
	room (hotel_id, room_type, room_capacity, room_description, room_cost_night, room_status)
VALUES
	(1, 'Standard', 2, 'Cozy room with a view of the city skyline.', 100, 'Available'),
	(1, 'Deluxe', 4, 'Spacious suite with a private balcony.', 200, 'Available'),
	(1, 'Suite', 3, 'Luxurious suite with a jacuzzi and city panorama.', 300, 'Available'),
	(1, 'Standard', 2, 'Simple and comfortable room for a relaxing stay.', 80, 'Available'),
	(1, 'Family', 6, 'Family-friendly suite with connecting rooms.', 250, 'Available'),
	(1, 'Executive', 2, 'Executive suite with modern amenities.', 150, 'Available'),
	(1, 'Deluxe', 3, 'Elegant room with a king-size bed and garden view.', 180, 'Available'),
	(1, 'Suite', 4, 'Chic suite with a separate living area.', 280, 'Available'),
	(1, 'Standard', 2, 'Budget-friendly standard room for solo travelers.', 70, 'Available'),
	(1, 'Family', 5, 'Spacious family suite with a play area for kids.', 220, 'Available');