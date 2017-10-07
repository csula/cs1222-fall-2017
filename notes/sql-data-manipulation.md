# Data Manipulation

## Objectives

* Learn the concepts of front-end and back-end as it relates to database applications
* Recap of JOINs
* Add rows to a table using INSERT
* Delete rows from a table using DELETE
* Edit data in existing rows using UPDATE
* Learn the concept of transactions and the use of commits and rollbacks
* Learn how SQL Server rollback transactions on errors
* Understand the concepts of concurrency, locking and deadlock

## Quick note on the SQL mode

Run the query like:

```sql
SELECT * FROM Artists GROUP BY ArtistName;

SELECT TitleID, COUNT(*) FROM Tracks;
```

If any of the above queries works for you without throwing the syntax error, you
are in trouble!

Run the following command to fix it.

```sql
SET sql_mode = 'ONLY_FULL_GROUP_BY';
```

## Front-end vs. Back-end

* Back-end
  * Host data
  * Database system
  * Server
  * Service
* Front-end
  * MySQL Workbench
  * MySQL CLI
  * Website

## JOINs Recap

There were some general confusions around the concept of JOINs. In this section,
we will review over the concept of JOINs all over again.

First off, there are a lot of resources online that you can use to learn SQL. By
now, you should be able to understand what they are saying because we have learned
majority of the SQL.

In example, https://sqlbolt.com/ is a interactive SQL exercise that you can
follow through for more practice questions.

http://sql-joins.leopard.in.ua/ provides a really good visualization on Venn
Diagram to SQL query.

JOINs are usually explained through the classic Venn Diagram … See
https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/

There are also other side of debate on using Venn Diagram to explain JOINs by
https://blog.jooq.org/2016/07/05/say-no-to-venn-diagrams-when-explaining-joins/

## INSERT

* Adds a new records to table

Syntax:

```sql
INSERT INTO
{table}
[(column, column, column)]
VALUES
(value, value, value);
```

Examples:

```sql
# Add 'Hip-hop' as a new genre in the Genre table
INSERT INTO Genre
(Genre)
VALUES
('hip-hop');

# Add new title as TitleID 8 that been recorded by Word (ArtistID 3)
# called 'Word Live', recorded in StudioID 2 in the Genre 'pop'
INSERT INTO Titles
(TitleID, ArtistID, Title, StudioID, Genre)
VALUES
(8, 3, 'Word Live', 3, 'pop');

# Add a new sales person as SalesID 5 named Breyce Sanders
# with initials of bgs, a base salary of 200, and supervisor by SalesID 1
INSERT INTO SalesPeople
VALUES
(5, 'Bryce', 'Sanders', 'bgs', 200, 1);
```

**Rules**

* Must apply values to all fiels except:
  * Those that auto-generate
  * Those with default values
  * Those that can have null values
* Foreign key constraints may further limit the kinds of values you can insert into tables
* To explicitly insert a Null value, use the word NULL without quotes
* Cannot use two commas together with nothing between them

### Insert with using a query

Syntax:

```sql
INSERT INTO {table1}
(column, column, column)
SELECT {column, colulm, column}
FROM {table2};
```

Examples:

```sql
# create AudioFiles
create table AudioFiles (
	TitleID int,
	TrackNum int,
	AudioFormat varchar(50)
);
# Populate the AudioFile table with all the MP3s from the Tracks table.
INSERT INTO AudioFiles
(TitleID, TrackNum, AudioFormat)
SELECT TitleID, TrackNum, 'mp3'
FROM Tracks
WHERE MP3 = 1;

# Add a new sales person as SalesID 6, named Courtney Mulligan
# with initials of cgm, a base salary of 200, and supervised by Bob Bentley
INSERT INTO SalesPeople
(SalesID, FirstName, LastName, Initials, Base, Supervisor)
SELECT 6, 'Courtney', 'Mulligan', 'cgm', 200, SalesID
FROM SalesPeople
WHERE FirstName = 'Bob' AND LastName = 'Bentley';
```

## Delete

To delete record(s) from table

Syntax:

```sql
DELETE FROM {table}
WHERE {condition};
```

Examples:

```sql
# Delete the sales person with SalesID 6
DELETE FROM SalesPeople
WHERE SalesID = 6;

# Delete the sales person named Courtney Mulligan
DELETE FROM SalesPeople
WHERE FirstName = 'Courtney' AND LastName = 'Mulligan';

# Delete all records in the AudioFiles table related to the CD, Time Files
DELETE FROM AudioFiles
WHERE TitleID = (
  SELECT TitleID
  FROM Titles
  WHERE Title = 'Time Flies'
);
```

## Update

* Syntax in simplest form is to specify the table to be updated followed by SET and field = value
* If setting multiple values, use SET only once and separate each field = value pair with a comma
* The value that you set the field(s) to can be:
  * A specific value
  * The old value with new information added
  * The result of a mathematical calculation
  * Value from another field
* Use WHERE clause to specify which records to change

Syntax:

```sql
UPDATE {table}
SET {column} = {value}, {column}, {value}
WHERE {condition};
```

Examples:

```sql
# Change the base for SalesID 3 to $200
UPDATE SalesPeople
SET Base = 200
WHERE SalesID = 3;

# Give sales person Bob Bentley a $50 raise in Base
UPDATE SalesPeople
SET Base = Base + 50
WHERE FirstName = 'Bob' AND LastName = 'Bentley';

# Member Frank Payne works from his home. Set his workphone number
# to the value of his homephone number
UPDATE Members
SET WorkPhone = HomePhone
WHERE FirstName = 'Frank' AND LastName = 'Payne';

# Change the record for the Time Flies to set the UPC to
# 1828344222 and the Genre to 'pop'
UPDATE Titles
SET UPC = '1828344222', Genre = 'pop'
WHERE Title = 'Time Flies';
```

### Update (multiple-table)

Syntax:

```sql
UPDATE {table1}, {table2}
SET {column} = {value}, {column} = {value}
WHERE {table1.column} = {table2.column} AND {condition};
```

Examples:

```sql
# All the members of the group confused now have email addresses
# that are the members first name followed by an @confused.com
# update the member records appropriately
UPDATE Members m, XRefArtistsMembers x, Artists a
SET Email = Concat(FirstName, '@confused.com')
WHERE m.MemberID = x.MemberID AND a.ArtistID = x.ArtistID AND
ArtistName = 'Confused'

# All the members who live in Virginia and who have previously
# been handled by sales person Scott Bull will now be handled
# by Clint Sanchez
UPDATE Members, SalesPeople
SET SalesID = (
  SELECT SalesID
  FROM SalesPeople
  WHERE FirstName = 'Clint' AND LastName = 'Sanchez'
)
WHERE Members.SalesID = SalesPeople.SalesID AND
  Region = 'VA' AND
  SalesPeople.FirstName = 'Scott' AND
  SalesPeople.LastName = 'Bull';
```

## Transactions

* Suppose you want to add a new CD title and its tracks
  * Need to insert a record to titles
  * Need to insert multiple records to tracks
* What if we did part of those inserts and not all of them?
  * Result would be an incomplete data
* Transactions let you group individual commands and require that they are all completed or not completed as a group

Definition of a Transaction:

> A transaction is logical unit of work made up of a series of statements (selects, inserts, updates, or deletes). If no errors are encountered during a transaction, all of the modifications in the transaction become a permanent part of the database. If errors are encountered, none of the modifications are made to the database.

## ACID Properties of Transactions

* **A** tomicity - A transaction is a logical unit of work that should be completely done or not done at all
* **C** onsistency - When completed, data is consistent with itself
  * Detail and totals match
  * No orphans
* **I** solation - no other users see any parts of transaction until it is completed
* **D** urability - When finished, it persists

Syntax:

```sql
BEGIN TRANSACTION;
DELETE FROM Tracks WHERE TitleID = 44;
DELETE FROM Titles WHERE TitleID = 44;
COMMIT;
# OR ROLLBACK if there is any error
```

## Concurrency Problems

* Dirty reads (Uncommitted dependency)
  * One user reads a record that is part of another user's incomplete transaction
* Unrepeatable reads (Inconsistent Analysis)
  * A record is read twice during a transaction, and the second read is affected by a separate transaction
* Phantoms
  * One user may be updating all the records in a table at the same time another user is inserting a new record to the table
* Lost updates
  * Two transaction try to update the same record

### Locks help solve concurrency problems

* Automatic locking by database
  * Record locking
  * Page locking
  * Table locking
* Front-end concurrency handling
  * ADO Access method locking
  * Timestamp checking and other methods

### Deadlock

* Two transactions each waiting for each other to complete

![Deadlock](imgs/traffic-deadlock.jpg)

### Solving/Preventing Deadlock

# Some database have build-in procedures for solving deadlocks
# Better to prevent deadlocks (front-end & stored procedure programming)
  * Always update table in the same order
  * Keep transactions as short as possible
  * Do not place user interaction in the middle of transaction
