-- Table: public.room

-- DROP TABLE IF EXISTS public.room;

CREATE TABLE IF NOT EXISTS public.room
(
    room_id integer NOT NULL DEFAULT nextval('room_id_seq'::regclass),
    hotel_id integer NOT NULL,
    room_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    room_capacity integer NOT NULL,
    room_description character varying(300) COLLATE pg_catalog."default" NOT NULL,
    room_cost_night real NOT NULL,
    room_status character varying(10) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Available'::character varying,
    last_update timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT room_pkey PRIMARY KEY (room_id),
    CONSTRAINT room_hotel_id_fkey FOREIGN KEY (hotel_id)
        REFERENCES public.hotel (hotel_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.room
    OWNER to postgres;
		
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