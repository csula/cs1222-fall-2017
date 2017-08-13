DROP TABLES IF EXISTS Artists,Genre, Members, Titles, Tracks,SalesPeople,Studios,XrefArtistsMembers;
DROP TABLES IF EXISTS Authors,Publishers,Titles,Title_Authors,Royalties;
DROP TABLES IF EXISTS Products,Customers,Orders,Order_details;
DROP TABLES IF EXISTS Sailors,Boats,Reserves;

CREATE TABLE Artists (
	ArtistID int, 
	ArtistName varchar (50) NOT NULL ,
	City varchar (25) NULL ,
	Region varchar (15) NULL ,
	Country varchar (20) NULL ,
	WebAddress varchar (40) NULL ,
	EntryDate date NULL ,
	LeadSource varchar (10) NULL 
);

Insert Into Artists Values(1,'The Neurotics','Peterson','NC','USA','www.theneurotics.com','2003-05-14','Directmail');
Insert Into Artists Values(2,'Louis Holiday','Clinton','IL','USA' ,NULL,'2003-06-03','Directmail');
Insert Into Artists Values(3,'Word','Anderson','IN','USA',NULL,'2003-06-08','Email');
Insert Into Artists Values(5,'Sonata','Alexandria','VA','USA','www.classical.com/sonata','2003-06-08','Ad');
Insert Into Artists Values(10,'The Bullets','Alverez','TX','USA',NULL,'2003-08-10','Email');
Insert Into Artists Values(14,'Jose MacArthur','Santa Rosa','CA','USA','www.josemacarthur.com','2003-08-17','Ad');
Insert Into Artists Values(15,'Confused','Tybee Island','GA','USA',Null,'2003-09-14','Directmail');
Insert Into Artists Values(17,'The Kicks','New Rochelle','NY','USA',NULL,'2003-12-03','Ad');
Insert Into Artists Values(16,'Today','London','ONT','Canada','www.today.com','2003-10-07','Email');
Insert Into Artists Values(18,'21 West Elm','Alamaba','VT','USA','www.21westelm.com','2003-02-05','Ad');
Insert Into Artists Values(11,'Highlander','Columbus','OH','USA',NULL,'2002-08-10','Email');

CREATE TABLE Genre (
	Genre varchar (15)  
);

Insert into Genre Values('alternative');
Insert into Genre Values('classical');
Insert into Genre Values('jazz');
Insert into Genre Values('metal');
Insert into Genre Values('R&B');
Insert into Genre Values('rap');
Insert into Genre Values('pop');

CREATE TABLE Members (
	MemberID int ,
	FirstName varchar (25) NULL ,
	LastName varchar (25) NULL ,
	Address varchar (60) NULL ,
	City varchar (25) NULL ,
	Region varchar (15) NULL ,
	PostalCode varchar (10) NULL ,
	Country varchar (20) NULL ,
	HomePhone varchar (16) NULL ,
	WorkPhone varchar (16) NULL ,
	EMail varchar (40) NULL ,
	Gender char (1) NULL ,
	Birthday date NULL ,
	SalesID smallint NULL 
);

Insert Into Members Values(10,'Roberto','Alvarez','Rt 1','Anderson','IN','46019','USA','7651552983','7651628837','ral@mightyhostl.com','M','1968-01-18',2);
Insert Into Members Values(31,'Jose','MacArthur','51444 Vine','Santa Rosa','CA','99999','USA','6331289393',Null,'jmac@dowop.com','M','1978-06-24',1);
Insert Into Members Values(13,'Mary','Chrisman','1772 East 117th','Fishers','IN','46123','USA','3171820387',Null,'mjc17@daviscorp.com','F','1973-03-01',1);
Insert Into Members Values(15,'Warren','Boyer','167 Alamo Dr','Alverez','TX','75601','USA','8221722883',Null,'wbman@uptime.net','M','1969-04-19',2);
Insert Into Members Values(32,'Doug','Finney','2020 Dubois','Savannah','GA','30003','USA','9821222929',Null,'fennyd@bitspeed.com','M','1963-08-04',3);
Insert Into Members Values(19,'Terry','Irving','18a 7th St','Tybee Island','GA','30004','USA','5411252093',Null,Null,'M','1959-06-22',3);
Insert Into Members Values(21,'Michelle','Henderson','201 Bonaventure','Savannah','GA','30005','USA','8221928273',Null,Null,'F','1964-03-15',2);
Insert Into Members Values(34,'William','Morrow','PO Box 1882','New Rochelle','NY','10014','USA','9981722928',Null,'wmorrow@wmorrow.com','M','1965-03-17',2);
Insert Into Members Values(29,'Frank','Payne','5412 Clinton','New Rochelle','NY','10014','USA','9981737464',Null,Null,'M','1960-01-17',1);
Insert Into Members Values(35,'Aiden','Franks','167 East 38th','Alverez','TX','75601','USA','8321729283','8321723833','kosmo@ispl.com','M','1983-09-02',2);
Insert Into Members Values(3,'Bryce','Sanders','PO Box 1292','Peterson','NC','27104','USA','6441824283',Null,'bs@cookery.com','M','1966-06-11',2);
Insert Into Members Values(14,'Carol','Wanner','787 Airport Rd','Alverez','TX','75601','USA','6831223944',Null,Null,'F','1978-11-08',3);
Insert Into Members Values(33,'Brian','Ranier','23 Gregory Lane','London','ONT','M6Y 2Y7 ','Canada','6231842933',Null,Null,'M','1957-10-19',3);
Insert Into Members Values(7,'Marcellin','Lambert','142 Sample Rd','Alexandria','VA','20102','USA','8331929302',Null,'mlambert@corkscrew.com','M','1959-11-14',3);
Insert Into Members Values(8,'Caroline','Kale','1515 Stone Church Rd','Allen','VA','20321','USA','7321223742',Null,Null,'F','1956-05-30',3);
Insert Into Members Values(9,'Kerry','Fernandez','15 Midway','Lynchberg','VA','21223','USA','2211229384','2211223939',Null,'M','1962-01-16',1);
Insert Into Members Values(26,'Tony','Wong','115 Maple St','McKensie','ONT','M8H 3T1','Canada','3311692832','3311692822','twong@tamilla.org','M','1955-11-01',2);
Insert Into Members Values(18,'Bonnie','Taft','RR4','Alamaba','VT','05303','USA','3721223292',Null,'taffygirl@signon.com','F','1960-09-21',1);
Insert Into Members Values(20,'Louis','Holiday','15 Davis Ct','Clinton','IL','63882','USA','1451223838',Null,Null,'M','1969-07-27',2);
Insert Into Members Values(22,'Bobby','Crum','RR2','Pine','VT','05412','USA','1831828211',Null,Null,'M','1965-06-10',3);
Insert Into Members Values(28,'Vic','Cleaver','100 Maple','Reston','VT','05544','USA','8111839292',Null,Null,'M','1957-02-10',2);
Insert Into Members Values(30,'Roberto','Goe','14 Gray Rd','Columbus','OH','48110','USA','2771123943',Null,Null,'M','1967-09-12',1);
Insert Into Members Values(36,'Davis','Goodman','2020 Country Rd','Columbus','OH','48318','USA','2771152882','2771128833','goody@irvingnet.com','M','1980-10-27',2);


CREATE TABLE SalesPeople (
	SalesID smallint ,
	FirstName varchar (20) NOT NULL ,
	LastName varchar (20) NOT NULL ,
	Initials varchar (3) NULL ,
	Base decimal(5,2) NULL,
	Supervisor smallint NUll
);

Insert into SalesPeople Values(1,'Bob','Bentley','bbb',100,4);
Insert into SalesPeople Values(2,'Lisa','Williams','lmw',300,4);
Insert into SalesPeople Values(3,'Clint','Sanchez','cls',100,1);
Insert into SalesPeople Values(4,'Scott','Bull','sjb',Null, Null);	


CREATE TABLE Studios (
	StudioID int,
	StudioName varchar (40) NULL ,
	Address varchar (60) NULL ,
	City varchar (25) NULL ,
	Region varchar (15) NULL ,
	PostalCode varchar (10) NULL ,
	Country varchar (20) NULL ,
	WebAddress varchar (40) NULL ,
	Contact varchar (50) NULL ,
	EMail varchar (40) NULL ,
	Phone varchar (16) NULL ,
	SalesID smallint NULL 
);

Insert Into Studios Values(1,'MakeTrax','3000 S St Rd 9','Anderson','IN','46012','USA','www.maketrax.com','Gardner Roberts','groberts@maketrax.com','7651223000',3);
Insert Into Studios Values(2,'Lone Star Recording','PO Box 221','Davis','TX','76382','USA','www.lsrecords.com','Manuel Austin','ma@lonestarrec.com','8821993748',2);
Insert Into Studios Values(3,'Pacific Rim','681 PCH','Santa Theresa','CA','99320','USA','www.pacrim.org','Harry Lee','harry@pcrim.org','3811110033',2);


CREATE TABLE Titles (
	TitleID int ,
	ArtistID int NULL ,
	Title varchar (50) NULL ,
	StudioID int NULL ,
	UPC varchar (13) NULL ,
	Genre varchar (15) NULL 
);

Insert Into Titles Values(1,1,'Meet the Neurotics',1,'2727366627','alternative');
Insert Into Titles Values(3,15,'Smell the Glove',2,'1283772282','metal');
Insert Into Titles Values(4,10,'Time Flies',3,'1882344222','alternative');
Insert Into Titles Values(5,1,'Neurotic Sequel',1,'2828830202','alternative');
Insert Into Titles Values(6,5,'Sonatas',2,'3999320021','classical');
Insert Into Titles Values(7,2,'Louis at the Keys',3,'3838227111','jazz');


CREATE TABLE Tracks (
	TitleID int NOT NULL ,
	TrackNum smallint NOT NULL ,
	TrackTitle varchar (50) NULL ,
	LengthSeconds smallint NULL ,
	MP3 smallint NULL ,
	RealAud smallint NULL 
);

Insert Into Tracks Values(1,1,'Hottie',233,1,1);
Insert Into Tracks Values(1,2,'Goodtime March',293,1,1);
Insert Into Tracks Values(1,3,'TV Day',305,1,1);
Insert Into Tracks Values(1,4,'Call Me an Idiot',315,1,1);
Insert Into Tracks Values(1,5,'25',402,1,1);
Insert Into Tracks Values(1,6,'Palm',322,1,1);
Insert Into Tracks Values(1,7,'Front Door',192,1,1);
Insert Into Tracks Values(1,8,'Where''s the Rain',175,1,1);
Insert Into Tracks Values(3,1,'Fat Cheeks',352,1,1);
Insert Into Tracks Values(3,2,'Rocky and Natasha',283,1,1);
Insert Into Tracks Values(3,3,'Dweeb',273,1,1);
Insert Into Tracks Values(3,4,'Funky Town',252,1,1);
Insert Into Tracks Values(3,5,'Shoes',182,1,1);
Insert Into Tracks Values(3,6,'Time In - In Time',129,1,1);
Insert Into Tracks Values(3,7,'Wooden Man',314,0,0);
Insert Into Tracks Values(3,8,'UPS',97,0,0);
Insert Into Tracks Values(3,9,'Empty',182,0,0);
Insert Into Tracks Values(3,10,'Burrito',65,0,0);
Insert Into Tracks Values(4,1,'Bob''s Dream',185,1,1);
Insert Into Tracks Values(4,2,'My Wizard',233,1,1);
Insert Into Tracks Values(4,3,'Third''s Folly',352,1,1);
Insert Into Tracks Values(4,4,'Leather',185,1,1);
Insert Into Tracks Values(4,5,'Hot Cars Cool Nights',192,1,1);
Insert Into Tracks Values(4,6,'Music in You',204,1,1);
Insert Into Tracks Values(4,7,'Don''t Care About Time',221,1,1);
Insert Into Tracks Values(4,8,'Kiss',218,1,1);
Insert Into Tracks Values(4,9,'Pizza Box',183,1,1);
Insert Into Tracks Values(4,10,'Goodbye',240,1,1);
Insert Into Tracks Values(5,1,'Song 1',285,1,1);
Insert Into Tracks Values(5,2,'Song 2',272,1,1);
Insert Into Tracks Values(5,3,'Song 3',299,1,1);
Insert Into Tracks Values(5,4,'Song 4',201,1,1);
Insert Into Tracks Values(5,5,'Song 5',198,1,0);
Insert Into Tracks Values(5,6,'Song 6',254,1,0);
Insert Into Tracks Values(5,7,'Song 7',303,1,1);
Insert Into Tracks Values(5,8,'Song 8',230,1,0);
Insert Into Tracks Values(5,9,'Song 8 and 1/2',45,1,0);
Insert Into Tracks Values(6,1,'Violin Sonata No. 1 in D Major',511,1,1);
Insert Into Tracks Values(6,2,'Violin Sonata No. 2 in A Major',438,1,1);
Insert Into Tracks Values(6,3,'Violin Sonata No. 4 in E Minor',821,1,0);
Insert Into Tracks Values(6,4,'Piano Sonata No. 1',493,1,0);
Insert Into Tracks Values(6,5,'Clarinet Sonata in E Flat',399,1,0);
Insert Into Tracks Values(7,1,'I Don''t Know',201,1,0);
Insert Into Tracks Values(7,2,'What''s the Day',332,1,0);
Insert Into Tracks Values(7,3,'Sirius',287,1,0);
Insert Into Tracks Values(7,4,'Hamburger Blues',292,1,0);
Insert Into Tracks Values(7,5,'Road Trip',314,1,0);
Insert Into Tracks Values(7,6,'Meeting You',321,1,1);
Insert Into Tracks Values(7,7,'Improv 34',441,1,1);
Insert Into Tracks Values(7,8,'Hey',288,1,1);


CREATE TABLE XrefArtistsMembers (
	MemberID int NOT NULL ,
	ArtistID int NOT NULL ,
	RespParty smallint NOT NULL 
       );

Insert into XrefArtistsMembers Values(20,2,1);
Insert into XrefArtistsMembers Values(31,14,1);
Insert into XrefArtistsMembers Values(3,1,1);
Insert into XrefArtistsMembers Values(10,3,1);
Insert into XrefArtistsMembers Values(13,3,0);
Insert into XrefArtistsMembers Values(7,5,1);
Insert into XrefArtistsMembers Values(8,5,0);
Insert into XrefArtistsMembers Values(9,5,0);
Insert into XrefArtistsMembers Values(32,15,0);
Insert into XrefArtistsMembers Values(19,15,1);
Insert into XrefArtistsMembers Values(21,15,0);
Insert into XrefArtistsMembers Values(34,17,1);
Insert into XrefArtistsMembers Values(29,17,0);
Insert into XrefArtistsMembers Values(15,10,1);
Insert into XrefArtistsMembers Values(35,10,0);
Insert into XrefArtistsMembers Values(14,10,0);
Insert into XrefArtistsMembers Values(33,16,1);
Insert into XrefArtistsMembers Values(26,16,0);
Insert into XrefArtistsMembers Values(18,18,1);
Insert into XrefArtistsMembers Values(28,18,0);
Insert into XrefArtistsMembers Values(22,18,0);
Insert into XrefArtistsMembers Values(30,11,1);
Insert into XrefArtistsMembers Values(36,11,0);

show tables;
