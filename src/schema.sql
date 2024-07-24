-- Extensions
create extension pgcrypto;

-- COMPLEX TYPES

CREATE TYPE OrderStatus AS ENUM (
    'Pending', 'Saved', 'Completed', 'Deleted', 'Canceled'
);

CREATE TYPE SubscriptionStatus AS ENUM (
    'Arrears', 'Ok', 'Revoked', 'Canceled'
);

create table Users (
	ID SERIAL primary key not null unique,
	Username varchar(50) not null,
	LastName varchar (120) not null,
	Email varchar(120) not null unique,
	OrganizationID integer references Organizations(ID) not null,
	password varchar(256) not null,
	enabled boolean not null
);

create table Authorities (
	ID SERIAL primary key not null unique,
	Name varchar(60) not null unique
)

create table UserAuthorities (
	ID SERIAL primary key not null unique,
	AuthorityID integer references Authorities(ID) not null,
	UserID integer references Users(ID) not null
)

create table Orders (
	ID SERIAL primary key not null unique,
	DateCreated date not null,
	Status OrderStatus not null,
	UserID integer references Users(ID) not null,
	SaleAmount numeric(12, 2) not null,
    OrganizationID integer references Organizations(ID) not null
);

SaleItems (
    ID SERIAL primary key not null unique,
    Name varchar(140) not null unique,
    description varchar(200)
)

OrderItems (
    ID SERIAL primary key not null unique,
    OrderID integer references Orders(ID),
    ItemID integer references SaleItems(ID)
)

create table CloudPackages (
	ID SERIAL primary key not null unique,
	RetentionTime interval not null,
	RetentionSize integer not null,
	MonthlyFee decimal not null
);

create table Subscriptions (
	ID SERIAL primary key not null unique,
	DateCreated date not null,
	Status subscriptionStatus not null,
	Package integer references CloudPackages(ID) not null,
	DueDate date not null,
    OrganizationID integer references Organizations(ID) not null
);

create table Organizations (
	ID SERIAL primary key not null unique,
	Name varchar(80) not null unique
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

