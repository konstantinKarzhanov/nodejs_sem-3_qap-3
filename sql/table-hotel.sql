-- ---------------------------
-- queries for "hotel" table
-- ---------------------------
SELECT * FROM hotel;
DELETE FROM hotel;

-- fill table with mock data
INSERT INTO 
	hotel (address_id, hotel_name, hotel_website, hotel_email, hotel_phone)
VALUES 
	(51, 'Mock Data Hotel', 'mockdatahotel.fake', 'book@mockdatahotel.fake', '9111222333');