-- Table: public.hotel

-- DROP TABLE IF EXISTS public.hotel;

CREATE TABLE IF NOT EXISTS public.hotel
(
    hotel_id integer NOT NULL DEFAULT nextval('hotel_id_seq'::regclass),
    address_id integer NOT NULL,
    hotel_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    hotel_website character varying(50) COLLATE pg_catalog."default" NOT NULL,
    hotel_email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    hotel_phone character varying(10) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT hotel_pkey PRIMARY KEY (hotel_id),
    CONSTRAINT hotel_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES public.address (address_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hotel
    OWNER to postgres;
		
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