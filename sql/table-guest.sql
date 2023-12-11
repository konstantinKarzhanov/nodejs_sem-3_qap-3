-- ---------------------------
-- queries for "guest" table
-- ---------------------------
SELECT * FROM guest;
DELETE FROM guest;
DELETE FROM guest WHERE guest_id > 50;
SELECT setval('guest_id_seq', 50);

-- fill table with mock data
INSERT INTO
	guest (address_id, guest_fname, guest_lname, guest_dob, guest_email, guest_phone)
VALUES
	(1, 'Georgianna', 'Hatrey', '1996-09-11', 'ghatrey0@rambler.ru', '6578443594'),
	(2, 'Aymer', 'Nequest', '1981-12-01', 'anequest1@springer.com', '6719870904'),
	(3, 'Cosmo', 'Hearse', '1979-08-24', 'chearse2@google.it', '8097712472'),
	(4, 'Trude', 'Few', '1977-11-22', 'tfew3@bizjournals.com', '3809294468'),
	(5, 'Rani', 'Syvret', '1951-06-09', 'rsyvret4@zdnet.com', '1942475726'),
	(6, 'Alley', 'Pearde', '1996-12-12', 'apearde5@shutterfly.com', '7477926266'),
	(7, 'Phaidra', 'Maystone', '1966-12-01', 'pmaystone6@angelfire.com', '4215494023'),
	(8, 'Reyna', 'Aylesbury', '1988-12-17', 'raylesbury7@networkadvertising.org', '2128557086'),
	(9, 'Andros', 'MacGray', '1953-09-06', 'amacgray8@addtoany.com', '3982267063'),
	(10, 'Delano', 'O'' Hogan', '1967-06-24', 'dohogan9@china.com.cn', '9806184596'),
	(11, 'Jayme', 'Jordeson', '1984-10-10', 'jjordesona@state.gov', '3109950762'),
	(12, 'Evie', 'Wagon', '1988-04-11', 'ewagonb@cnet.com', '8832160331'),
	(13, 'Cirillo', 'Loynton', '1957-08-05', 'cloyntonc@is.gd', '9077660686'),
	(14, 'Dela', 'Thulborn', '1971-03-13', 'dthulbornd@netscape.com', '8648341973'),
	(15, 'Sonny', 'Ragate', '1957-12-27', 'sragatee@bravesites.com', '3835680068'),
	(16, 'Ewart', 'Kiwitz', '1953-08-31', 'ekiwitzf@unblog.fr', '3962335596'),
	(17, 'Grissel', 'Axcell', '1967-05-25', 'gaxcellg@histats.com', '9836597698'),
	(18, 'Karole', 'Palk', '1962-07-24', 'kpalkh@multiply.com', '8536813013'),
	(19, 'Wernher', 'Chinn', '1988-08-28', 'wchinni@multiply.com', '9932537332'),
	(20, 'Salomo', 'MacCard', '1957-10-20', 'smaccardj@jiathis.com', '4766580094'),
	(21, 'Avigdor', 'Hengoed', '1971-07-03', 'ahengoedk@intel.com', '4527789374'),
	(22, 'Rozalin', 'Backhurst', '1999-02-01', 'rbackhurstl@eepurl.com', '5924559653'),
	(23, 'Grant', 'Withrington', '2000-04-06', 'gwithringtonm@kickstarter.com', '9726961829'),
	(24, 'Brittan', 'Provost', '1964-09-27', 'bprovostn@livejournal.com', '8434665677'),
	(25, 'Halley', 'Rollins', '1959-06-21', 'hrollinso@sphinn.com', '5362826765'),
	(26, 'Zoe', 'Scammell', '1967-08-01', 'zscammellp@tiny.cc', '7658116280'),
	(27, 'Sergeant', 'McConway', '1991-05-25', 'smcconwayq@squarespace.com', '1733980190'),
	(28, 'Freddie', 'Dimock', '1969-04-08', 'fdimockr@jigsy.com', '7487410894'),
	(29, 'Zilvia', 'Rulton', '1983-07-08', 'zrultons@cafepress.com', '7812524641'),
	(30, 'Robbie', 'Papps', '1966-11-26', 'rpappst@cornell.edu', '5371184289'),
	(31, 'Roberto', 'De Zuani', '1983-03-03', 'rdezuaniu@canalblog.com', '7707957709'),
	(32, 'Saleem', 'Arckoll', '1959-04-03', 'sarckollv@dailymotion.com', '1887266223'),
	(33, 'Allie', 'Scanderet', '1972-10-17', 'ascanderetw@eepurl.com', '2955296258'),
	(34, 'Frederik', 'Pfaffel', '1979-01-09', 'fpfaffelx@mozilla.org', '8891095451'),
	(35, 'Marlo', 'Duguid', '1978-03-02', 'mduguidy@pagesperso-orange.fr', '4302733833'),
	(36, 'Atlanta', 'Plaxton', '2006-10-02', 'aplaxtonz@forbes.com', '5232829968'),
	(37, 'Saundra', 'Tarborn', '1969-11-04', 'starborn10@aol.com', '7916455492'),
	(38, 'Vidovik', 'McFarland', '1957-04-27', 'vmcfarland11@skyrock.com', '7605819259'),
	(39, 'Wylma', 'Aers', '1977-06-18', 'waers12@nba.com', '4198069244'),
	(40, 'Prinz', 'Tabbernor', '1989-12-16', 'ptabbernor13@wikia.com', '7773769305'),
	(41, 'Fielding', 'Shalliker', '1963-04-17', 'fshalliker14@naver.com', '3257246984'),
	(42, 'Hulda', 'Biggs', '1951-01-03', 'hbiggs15@prnewswire.com', '4158287132'),
	(43, 'Coletta', 'Walthall', '1958-02-07', 'cwalthall16@devhub.com', '1879120792'),
	(44, 'Humbert', 'St. Aubyn', '1989-05-31', 'hstaubyn17@freewebs.com', '8214143443'),
	(45, 'Tracy', 'Bouchard', '1958-07-09', 'tbouchard18@shop-pro.jp', '1516273481'),
	(46, 'Maudie', 'Schleicher', '1985-05-13', 'mschleicher19@w3.org', '5849828050'),
	(47, 'Trever', 'Sewill', '1975-09-16', 'tsewill1a@gizmodo.com', '5329831679'),
	(48, 'Hazel', 'Fontell', '1971-07-22', 'hfontell1b@kickstarter.com', '1714452663'),
	(49, 'Myriam', 'Pickerin', '1962-07-26', 'mpickerin1c@csmonitor.com', '4262678705'),
	(50, 'Vladamir', 'Parley', '1992-06-04', 'vparley1d@indiatimes.com', '6315001558');
