-- Table: public.address

-- DROP TABLE IF EXISTS public.address;

CREATE TABLE IF NOT EXISTS public.address
(
    address_id integer NOT NULL DEFAULT nextval('address_id_seq'::regclass),
    address_street character varying(50) COLLATE pg_catalog."default" NOT NULL,
    address_city character varying(20) COLLATE pg_catalog."default" NOT NULL,
    address_province character varying(2) COLLATE pg_catalog."default" NOT NULL,
    address_postal_code character varying(6) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT address_pkey PRIMARY KEY (address_id),
    CONSTRAINT uq_address UNIQUE (address_street, address_city, address_province),
    CONSTRAINT uq_postal_code UNIQUE (address_postal_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.address
    OWNER to postgres;

-- ---------------------------
-- queries for "address" table
-- ---------------------------
SELECT * FROM address;
DELETE FROM address;
DELETE FROM address WHERE address_id > 51;
SELECT setval('address_id_seq', 51);

-- fill table with mock data
INSERT INTO 
  address (address_street, address_city, address_province, address_postal_code) 
VALUES
  ('123 Maple Street', 'Toronto', 'ON', 'M5A1A1'),
  ('456 Oak Avenue', 'Vancouver', 'BC', 'V6B2J2'),
  ('789 Birch Road', 'Montreal', 'QC', 'H3A1E1'),
  ('101 Pine Lane', 'Calgary', 'AB', 'T2P2V5'),
  ('202 Elm Street', 'Ottawa', 'ON', 'K1P5M7'),
  ('303 Cedar Avenue', 'Edmonton', 'AB', 'T5J2Y2'),
  ('404 Spruce Drive', 'Quebec City', 'QC', 'G1V4M7'),
  ('505 Fir Lane', 'Winnipeg', 'MB', 'R3C3J7'),
  ('606 Willow Road', 'Halifax', 'NS', 'B3H1S6'),
  ('707 Birch Street', 'Saskatoon', 'SK', 'S7N3K4'),
  ('808 Pine Avenue', 'Victoria', 'BC', 'V8W1W2'),
  ('909 Maple Lane', 'Hamilton', 'ON', 'L8P1A1'),
  ('111 Oak Road', 'London', 'ON', 'N6A1H9'),
  ('222 Elm Avenue', 'Regina', 'SK', 'S4P3R2'),
  ('333 Cedar Lane', 'St. John''s', 'NL', 'A1A1A1'),
  ('444 Spruce Drive', 'Charlottetown', 'PE', 'C1A4P3'),
  ('555 Fir Street', 'Fredericton', 'NB', 'E3B5A3'),
  ('666 Willow Road', 'Yellowknife', 'NT', 'X1A2P5'),
  ('777 Birch Lane', 'Whitehorse', 'YT', 'Y1A5M9'),
  ('888 Pine Avenue', 'Iqaluit', 'NU', 'X0A0H0'),
  ('999 Oak Street', 'Burnaby', 'BC', 'V5C2A1'),
  ('111 Maple Lane', 'Mississauga', 'ON', 'L5B3M2'),
  ('222 Birch Road', 'Richmond', 'BC', 'V6Y1W1'),
  ('333 Elm Drive', 'Kitchener', 'ON', 'N2G2S8'),
  ('444 Cedar Avenue', 'Windsor', 'ON', 'N8W4W2'),
  ('555 Spruce Street', 'Surrey', 'BC', 'V3R0J3'),
  ('666 Fir Lane', 'Brampton', 'ON', 'L6T1G5'),
  ('777 Willow Road', 'Laval', 'QC', 'H7W2V4'),
  ('888 Birch Street', 'Markham', 'ON', 'L3R3L4'),
  ('999 Pine Avenue', 'Gatineau', 'QC', 'J8P1E7'),
  ('111 Oak Road', 'Niagara Falls', 'ON', 'L2E2M5'),
  ('222 Maple Lane', 'Saguenay', 'QC', 'G7B1E3'),
  ('333 Birch Road', 'Abbotsford', 'BC', 'V2S2A1'),
  ('444 Elm Street', 'Cambridge', 'ON', 'N3C3R2'),
  ('555 Cedar Drive', 'London', 'ON', 'N6G3W5'),
  ('666 Spruce Avenue', 'Coquitlam', 'BC', 'V3J1C6'),
  ('777 Fir Lane', 'Trois-Rivières', 'QC', 'G9A1L8'),
  ('888 Willow Street', 'St. Catharines', 'ON', 'L2R7R9'),
  ('999 Birch Road', 'Halifax', 'NS', 'B3K4L2'),
  ('111 Pine Street', 'Thunder Bay', 'ON', 'P7B2C6'),
  ('222 Elm Avenue', 'Winnipeg', 'MB', 'R2C3A3'),
  ('333 Willow Lane', 'Markham', 'ON', 'L3P2G3'),
  ('444 Cedar Road', 'Richmond Hill', 'ON', 'L4C3Y7'),
  ('555 Fir Street', 'Sudbury', 'ON', 'P3A1N5'),
  ('666 Maple Drive', 'Saskatoon', 'SK', 'S7H3W6'),
  ('777 Oak Lane', 'Kelowna', 'BC', 'V1Y5W3'),
  ('888 Birch Avenue', 'Barrie', 'ON', 'L4M5W3'),
  ('999 Pine Road', 'Sherbrooke', 'QC', 'J1H1E1'),
  ('111 Elm Street', 'Oshawa', 'ON', 'L1H7K4'),
  ('131 Main Street', 'Barrie', 'ON', 'L1D2W3'),
  ('115 Cavendish Square', 'St. John''s', 'NL', 'A1C3K2');