DROP TABLES IF EXISTS Products,Customers,Orders,Order_details;
DROP TABLES IF EXISTS Artists,Genre, Members, Titles, Tracks,SalesPeople,Studios,XrefArtistsMembers;
DROP TABLES IF EXISTS Authors,Publishers,Titles,Title_Authors,Royalties;
DROP TABLES IF EXISTS Sailors,Boats,Reserves;



CREATE TABLE Products
  (
  pid    TEXT     NOT NULL,
  description  TEXT,
  quantity   INTEGER,
  price  REAL
  );

CREATE TABLE Customers
  (
  cid INTEGER  ,
  fname  TEXT,
  lname  TEXT ,
    address  TEXT 
  );

CREATE TABLE Orders
  (
   oid INTEGER,
   cid  INTEGER,
   odate  DATE,
   sdate  DATE
  );

CREATE TABLE Order_details
  (
   oid  INTEGER,
   pid  TEXT,
   quantity INTEGER
  );


INSERT INTO Products VALUES('CPU001','This is CPU 001', 10, 100);
INSERT INTO Products VALUES('CPU002','This is CPU 002', 8, 150);
INSERT INTO Products VALUES('CPU003','This is CPU 003', 0, 130);
INSERT INTO Products VALUES('HDD001','This is Hard Drive 001', 0, 180);
INSERT INTO Products VALUES('HDD002','This is Hard Drive 002', 5, 190);
INSERT INTO Products VALUES('MSE001','This is Mouse 001', 20, 20);
INSERT INTO Products VALUES('MSE002','This is Mouse 001', 12, 15);

INSERT INTO Customers VALUES(1001,'Sarah','Buchman', '75 West 205 St,NY');
INSERT INTO Customers VALUES(1002,'Wendy','Heydemark', '2922 Baseline Rd,CO');
INSERT INTO Customers VALUES(1003,'Hallie','Hull', '3800 Waldo Ave,CA');
INSERT INTO Customers VALUES(1004,'Klee','Hull', '114 Horatio St, NY');
INSERT INTO Customers VALUES(1005,'Paddy','Furniture', '1442 Main St,FL');
INSERT INTO Customers VALUES(1006,'Bob','Bob', '5255 Main St,FL');
INSERT INTO Customers VALUES(1007,'Wang','Wang', '5255 Horatio St, NY');



INSERT INTO Orders VALUES(2010,1001, '2004-12-01', '2004-12-05');
INSERT INTO Orders VALUES(2011,1002, '2005-04-21', NULL);
INSERT INTO Orders VALUES(2012,1003, '2005-06-21', '2005-07-08');
INSERT INTO Orders VALUES(2013,1005, '2005-06-22', NULL);
INSERT INTO Orders VALUES(2014,1004, '2005-07-20', '2005-08-01');
INSERT INTO Orders VALUES(2015,1001, '2005-07-20', '2005-08-01');


INSERT INTO Order_details VALUES(2010, 'CPU001', 2);
INSERT INTO Order_details VALUES(2010, 'HDD002', 1);
INSERT INTO Order_details VALUES(2011, 'CPU002', 1);
INSERT INTO Order_details VALUES(2011, 'HDD001', 2);
INSERT INTO Order_details VALUES(2011, 'MSE001', 3);
INSERT INTO Order_details VALUES(2012, 'MSE002', 5);
INSERT INTO Order_details VALUES(2013, 'CPU003', 1);
INSERT INTO Order_details VALUES(2013, 'HDD002', 2);
INSERT INTO Order_details VALUES(2014, 'MSE002', 1);
INSERT INTO Order_details VALUES(2014, 'CPU002', 2);
INSERT INTO Order_details VALUES(2015, 'CPU001', 3);


 
show tables;
