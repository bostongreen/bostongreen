create table users(
	id		 					integer primary key,
	screen_name 	 			varchar(50),
	real_name					varchar(50),
	email	 					varchar(256),
	last_search_text			varchar(256),
	last_search_neighborhood_id integer,
	prefer_view_as_map			boolean
);

create table parks (
	id							integer primary key,
	name						varchar(50),
	--location					polygon,
	photo_url					varchar(1024),
	description					varchar(4096),
	when_its_open_encoded		varchar(256),
	address_street				varchar(256),
	address_city						varchar(50),
	address_state						varchar(2),
	address_zipcode						integer,
	rating						real,
	boston_connect_id			varchar(16),
	is_part_of_larger_park		boolean
);
select AddGeometryColumn('parks', 'location', 4326, 'POLYGON', 2);

create table parks_parks (
	id							integer primary key,
	parent_park_id				integer REFERENCES parks(id),
	child_park_id				integer REFERENCES parks(id)
);
	
create table tag_types(
	id			integer primary key,
	description	varchar(80)
);

create table tags(
	id			integer primary key,
	name		varchar(20),
	tag_type	integer REFERENCES tag_types(id),
	description varchar(80)
);

create table tags_parks(
	id			integer primary key,
	tag			integer REFERENCES tags(id),
	park		integer REFERENCES parks(id)
);

create table comments(
	id			integer primary key,
	park		integer REFERENCES parks(id),
	user_id		integer REFERENCES users(id),
	text		varchar(4096),
	occurrence	timestamptz,
	photo_url	varchar(1024),
	rating		integer
);

create table events(
	id			integer primary key,
	name		varchar(40),
	description	varchar(1024),
	url			varchar(256),
	when_it_happens_encoded varchar(256),
	next_occurrence	timestamptz
);

create table events_parks(
	id			integer primary key,
	event		integer REFERENCES events(id),
	park		integer REFERENCES parks(id)
);

create table featured_links(
	id			integer primary key,
	park		integer REFERENCES parks(id),
	description	varchar(256),
	url			varchar(1024)
);

create table public_transits(
	id			integer primary key,
	name		varchar(80),
	url			varchar(256)
	--location	geometry
);
select AddGeometryColumn('public_transits', 'location', 4326, 'POINT', 2);

create table public_transits_parks(
	id			integer primary key,
	public_transit integer REFERENCES public_transits(id),
	park		integer REFERENCES parks(id)
);

create table neighborhoods(
	id			integer primary key,
	name		varchar(80),
	--location	geometry,
	description	varchar(4096),
	photo_url	varchar(1024),
	url			varchar(1024)
);
select AddGeometryColumn('public_transits', 'location', 4326, 'POINT', 2);
