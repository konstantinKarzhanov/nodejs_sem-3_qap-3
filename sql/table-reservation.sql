-- Table: public.reservation

-- DROP TABLE IF EXISTS public.reservation;

CREATE TABLE IF NOT EXISTS public.reservation
(
    reservation_id integer NOT NULL DEFAULT nextval('reservation_id_seq'::regclass),
    hotel_id integer NOT NULL DEFAULT 1,
    guest_id integer,
    reservation_date date NOT NULL DEFAULT CURRENT_DATE,
    subtotal_cost real NOT NULL,
    discount real NOT NULL,
    tax_amount real NOT NULL,
    total_cost real NOT NULL,
    payment_method character varying(20) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT reservation_pkey PRIMARY KEY (reservation_id),
    CONSTRAINT reservation_guest_id_fkey FOREIGN KEY (guest_id)
        REFERENCES public.guest (guest_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT reservation_hotel_id_fkey FOREIGN KEY (hotel_id)
        REFERENCES public.hotel (hotel_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.reservation
    OWNER to postgres;
		
-- --------------------------------
-- queries for "reservation" table
-- --------------------------------
SELECT * FROM reservation;
DELETE FROM reservation;

-- fill table with mock data
INSERT INTO 
	reservation (hotel_id, guest_id, reservation_date, subtotal_cost, discount, tax_amount, total_cost, payment_method)
VALUES
	(1, 1, '2023-05-28', 400, 40, 54, 414, 'Credit Card'),
	(1, 2, '2023-06-30', 1000, 100, 135, 1035, 'Cash'),
	(1, 3, '2023-08-02', 1500, 150, 202.5, 1552.5, 'Credit Card'),
	(1, 4, '2023-08-29', 160, 16, 21.6, 165.6, 'Cash'),
	(1, 5, '2023-10-03', 1500, 150, 202.5, 1552.5, 'Credit Card'),
	(1, 6, '2023-10-01', 750, 75, 101.25, 776.25, 'Cash'),
	(1, 7, '2023-11-05', 1260, 126, 170.1, 1304.1, 'Credit Card'),
	(1, 8, '2023-11-07', 1120, 112, 151.2, 1159.2, 'Cash'),
	(1, 9, '2023-11-04', 280, 28, 37.8, 289.8, 'Credit Card'),
	(1, 10, '2023-11-09', 1320, 132, 178.2, 1366.2, 'Cash');