-- SCHEMA INIT

-- Extensions
create extension pgcrypto;

create table Organizations (
	ID SERIAL primary key not null unique,
	Name varchar(80) not null unique
);

create table Users (
	ID SERIAL primary key not null unique,
	Name varchar(50) not null,
	Email varchar(120) not null unique,
	OrganizationID integer references Organizations(ID) not null,
	Password varchar(256) not null,
	Enabled boolean not null
);

create table Authorities (
	ID SERIAL primary key not null unique,
	Name varchar(60) not null unique
);

create table UserAuthorities (
	ID SERIAL primary key not null unique,
	AuthorityID integer references Authorities(ID) not null,
	UserID integer references Users(ID) not null
);

create table Devices (
	ControllerID UUID primary key not null unique,
	Name varchar(44),
	Description varchar(140),
	IpAddress varchar(24),
	MacAddress varchar(18),
	Status varchar(48),
	Gateway varchar(16),
	WgAddress varchar(16),
    OrganizationID integer references Organizations(ID) not null
);

create table DeviceCredentials (
	ID SERIAL primary key not null unique,
	ControllerID UUID references Devices(ControllerID) not null,
	SSHPrivateKey varchar(2048) not null unique,
	SSHPublicKey varchar(2048) not null unique,
	WgPrivateKey varchar(2048) not null unique,
	WgPublicKey varchar(2048) not null unique,
	Mongodbcertfs varchar(2048) not null,
	Passwd varchar(256)
);