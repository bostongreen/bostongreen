insert into users (id, screen_name, real_name, email, prefer_view_as_map) values 
	(1, 'Fred Flintstone', 'Fred Flintstone', 'Fred@Flintstone.com', true);
insert into users (id, screen_name, real_name, email, prefer_view_as_map) values 
	(2, 'Barney', 'Barney Rubble', 'Barney@Flintstone.com', false);


insert into parks (
	id, 
	name, 
	location, 
	photo_url, 
	description, 
	when_its_open_encoded, 
	address_street, 
	address_city, 
	address_state, 
	address_zipcode, 
	rating, 
	boston_connect_id) values (
	1, 
	'Rocky Road', 
	ST_GeomFromText('POLYGON((-71.093559 42.299151, -71.095619 42.292294, -71.102829 42.300929, -71.093559 42.299151))', 4326), 
	'http://google.com', 
	'A very rocky road', 
	'UMTWRFS[7-15]', 
	'1 Main St',
	'Townville',
	'MA',
	12345,
	3.4,
	'123XYZ');
	
insert into parks (
	id, 
	name, 
	location, 
	photo_url, 
	description, 
	when_its_open_encoded, 
	address_street, 
	address_city, 
	address_state, 
	address_zipcode,  
	rating, 
	boston_connect_id) values (
	2, 
	'Poseidon Point', 
	ST_GeomFromText('POLYGON((-71.171579 42.345604, -71.170249 42.342876, -71.177759 42.343384))', 4326), 
	'http://google.com', 
	'My dad owns pitchfork', 
	'MWF[9-17],S[12-17]', 
	'10 Mayflower Road',
	'Cityburg',
	'MA',
	54321,
	4.3,
	'456HJK');
	
insert into tag_types(id, description) values (1, 'park types');
insert into tag_types(id, description) values (2, 'park feature types');
insert into tag_types(id, description) values (3, 'park attributes');
insert into tag_types(id, description) values (4, 'kinds of sports');


insert into tags(id, name, tag_type, description) values (1, 'Field', 1, 'Green space');
insert into tags(id, name, tag_type, description) values (2, 'Playground', 1, 'Kids can climb on it');
insert into tags(id, name, tag_type, description) values (3, 'Kayak Launch', 2, 'Kayak launch available');
insert into tags(id, name, tag_type, description) values (4, 'Garden', 2, 'Public Garden');	
insert into tags(id, name, tag_type, description) values (5, 'Dog Park', 3, 'Dogs can play here');
insert into tags(id, name, tag_type, description) values (6, 'Kid Friendly', 3, 'Good place for kids');
insert into tags(id, name, tag_type, description) values (7, 'Frisbee', 4, 'People play frisbee here');
insert into tags(id, name, tag_type, description) values (8, 'Soccer', 4, 'People play soccer here');

insert into tags_parks(id, tag, park) values (1, 1, 1);
insert into tags_parks(id, tag, park) values (2, 2, 2);


insert into comments(id, park, user_id, text, occurrence, photo_url, rating) values (1, 1, 1, 'This park rocked', NOW(), NULL, 5);
insert into comments(id, park, user_id, text, occurrence, photo_url, rating) values (1, 1, 2, 'This park sucked', NOW(), NULL, 1);
insert into comments(id, park, user_id, text, occurrence, photo_url, rating) values (1, 2, 2, NULL, NOW(), 'http://google.com', NULL);


insert into events(id, name, description, url, when_it_happens_encoded, next_occurrence) values (1, 'Patty Cake', 'Let us play patty cake!', 'http://www.google.com', '05/06/2011[20-21]', NOW());

insert into events(id, name, description, url, when_it_happens_encoded, next_occurrence) values (2, 'Professional Tag', 'Let us play tag!', 'http://www.google.com', '05/07/2011[20-21]', NOW());

insert into events_parks(id, event, park) values (1, 1, 1);
insert into events_parks(id, event, park) values (2, 2, 2);

insert into featured_links(id, park, description, url) values (1, 1, 'It is so great', 'http://google.com');
insert into featured_links(id, park, description, url) values (1, 2, 'Friends of the park', 'http://google.com');

insert into public_transits(id, name, url, location) values (1, 'Park Street', 'http://google.com', NULL):
insert into public_transits(id, name, url, location) values (2, 'Charles MGH', 'http://google.com', NULL):


insert into public_transits_parks(id, public_transit, park) values (1, 1, 1);
insert into public_transits_parks(id, public_transit, park) values (2, 2, 2);



insert into neighborhoods(id, name, location, description, photo_url, url) values (1, 'Cambridgeport', NULL, 'A pimple on the face of cambridge', 'http://google.com', 'http://google.com');
insert into neighborhoods(id, name, location, description, photo_url, url) values (2, 'Back Bay', NULL, 'AWhere the victorians love landfill', 'http://google.com', 'http://google.com');