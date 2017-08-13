DROP TABLES IF EXISTS Products,Customers,Orders,Order_details;
DROP TABLES IF EXISTS Artists,Genre,Members,Titles,Tracks,SalesPeople,Studios,XrefArtistsMembers;
DROP TABLES IF EXISTS Authors,Publishers,Titles,Title_Authors,Royalties;
DROP TABLES IF EXISTS Sailors,Boats,Reserves;


create table Sailors(
	sid int primary key,
	sname text,
	rating int,
	age  float,
	phone  text
);

insert into Sailors values(1, "Dustin", 2, 45, "1311231123");
insert into Sailors values(2, "Brutus", 4, 33,"2312232323");
insert into Sailors values(3, "Lubber", 3, 55,"2117832323");
insert into Sailors values(4, "Tom", 1, 25,"2440836666");
insert into Sailors values(5, "John", 1, 20,"2550837777");



create table Boats(
	bid  int primary key,
	bname text,
	color  text
);

insert into Boats values(10, "Lake","blue");
insert into Boats values(20, "Mountain","red");
insert into Boats values(30, "Lion","blue");
insert into Boats values(40, "Tiger","Green");


create table Reserves(
	sid  int,
	bid  int,
	day date
);


insert into Reserves values(1, 20, "2001-01-01");
insert into Reserves values(1, 30, "2001-02-01");
insert into Reserves values(2, 20, "2002-01-02");
insert into Reserves values(2, 10, "2001-01-03");
insert into Reserves values(3, 20, "2001-01-03");




