-- Table: public.reservation_detail

-- DROP TABLE IF EXISTS public.reservation_detail;

CREATE TABLE IF NOT EXISTS public.reservation_detail
(
    reservation_id integer NOT NULL,
    room_id integer NOT NULL,
    check_in date NOT NULL,
    check_out date NOT NULL,
    night_count integer NOT NULL,
    detail_cost real NOT NULL,
    CONSTRAINT reservation_detail_pkey PRIMARY KEY (reservation_id, room_id),
    CONSTRAINT uq_composite_key UNIQUE (reservation_id, room_id),
    CONSTRAINT reservation_detail_reservation_id_fkey FOREIGN KEY (reservation_id)
        REFERENCES public.reservation (reservation_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT reservation_detail_room_id_fkey FOREIGN KEY (room_id)
        REFERENCES public.room (room_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.reservation_detail
    OWNER to postgres;
		
-- ---------------------------------------
-- queries for "reservation_detail" table
-- ---------------------------------------
SELECT * FROM reservation_detail;
DELETE FROM reservation_detail;

-- fill table with mock data
INSERT INTO 
	reservation_detail (reservation_id, room_id, check_in, check_out, night_count, detail_cost)
VALUES
	(1, 1, '2023-06-01', '2023-06-05', 4, 400),
	(2, 2, '2023-07-03', '2023-07-08', 5, 1000),
	(3, 3, '2023-08-05', '2023-08-10', 5, 1500),
	(4, 4, '2023-09-02', '2023-09-04', 2, 160),
	(5, 5, '2023-10-06', '2023-10-12', 6, 1500),
	(6, 6, '2023-10-04', '2023-10-09', 5, 750),
	(7, 7, '2023-11-08', '2023-11-15', 7, 1260),
	(8, 8, '2023-11-10', '2023-11-14', 4, 1120),
	(9, 9, '2023-11-07', '2023-11-11', 4, 280),
	(10, 10, '2023-11-12', '2023-11-18', 6, 1320);
