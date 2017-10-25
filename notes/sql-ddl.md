# Data Definition Language

## Objectives

* Lean how databases are created
* Save and use DDL in scripts
* Create and alter the field structure of tables
* Create and drop primary key constraints
* Create and drop default constraints
* Create and drop check constraints
* Create and drop foreign key constraints
* Field types
* Prepare Statements
* Create and drop indexes
* Create and drop views

## Database Definition Language (DDL)

* Subset of SQL commands to create and modify database objects
* Can create an entire database using SQL rather than a graphical user interface
* With DDL you gain more control over exactly what database objects are built and what they are named
* DDL saved into a script can be easily ported from one database installation to another

## Scripts

* Set of SQL commands saved in a text file
    * Duplicate database structure on another server or at another time
    * Test commands on a development server and them run on a production server

## Using Scripts with MySQL

* MySQL can run script st a command prompt
    * Run by `mysql database_name < path_and_script_name*`
* Script can also be imported in MySQL workbench as below:
    * http://recordit.co/dHS4kCbl97
* Or as simple as just copy and paste the whole script content and execute them

## Naming tips

* Using consistent names
* Do not include spaces in your table or fields
* Avoid the use of SQL reserved words and punctuation marks in table and field names
* Keep names short, but long enough to be descriptive
* Be consistent in your use of abbreviations
* Name primary key and foreign key fields consistently
* Avoid generic field names, such as ID or Date

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">There are two hard things in computer science: cache invalidation, naming things, and off-by-one errors.</p>&mdash; Jeff Atwood (@codinghorror) <a href="https://twitter.com/codinghorror/status/506010907021828096?ref_src=twsrc%5Etfw">August 31, 2014</a></blockquote>

## Databases

* Instance of MySQL running on a server computer can contain multiple databases
* New MySQL database can be created with Create Database followed by the name to be used for the new database or Create Database If Not Exists followed by the name of the database
* There are no other options for the Create Database command
* Can switch between databases by typing USE keyword followed by the database name

Overall hierarchy:

```
Database > Table > Column > Record

+---Database-------------------------------+
|                                          |
|  +--Table-----------------------+        |
|  | Column | Column | Column     |+       |
|  +------------------------------+|+      |
|  | Vale   | Value  | Value      |||      |
|  | Vale   | Value  | Value      |||      |
|  | Vale   | Value  | Value      |||      |
|  +------------------------------+||      |
|   +------------------------------+|      |
|    +------------------------------+      |
+------------------------------------------+
```

## Create a Table

Syntax:

```mysql
CREATE TABLE {tableName} (
    {fieldName} datatype null | not null,
    {fieldName} datatype null | not null
);
```

Example:

```mysql
# Create table called contracts with the ArtistID from the Artists table and a ContractDate field
CREATE TABLE Contracts (
    ArtistID Integer NOT NULL,
    ContractDate DateTime NOT NULL
);
```

### Dropping a table

Syntax:

```mysql
DROP TABLE {tableName};
```

Example:

```mysql
# Remove the Contracts table from the database
DROP TABLE Contracts;
```

## Adding columns to an existing table

Syntax:

```mysql
ALTER TABLE {tableName}
ADD {columnName} {dataType} {null | not null};
```

Example:

```mysql
# Add a text field called contract type with a length of 10 to the Contracts table
ALTER TABLE Contracts
ADD ContractType VarChar(10) NULL;
```

## Altering Existing Columns in a table

Syntax:

```mysql
ALTER TABLE {tableName}
MODIFY COLUMN {columnName} {dataType} {null | not null};
```

Example:

```mysql
# Change the length on the ContractType field to 15 in the Contracts Table
ALTER TABLE Contracts 
MODIFY ContractType VarChar(15);
```

## Dropping a column

Syntax:

```mysql
ALTER TABLE {tableName}
DROP COLUMN {columnName};
```

Example:

```mysql
# Remove the ContractType column from Contracts table
ALTER TABLE Contracts
DROP COLUMN ContractType;
```

## Identify Columns and Sequences

* Techniques to automatically generated a sequential number with each row that is inserted
* Never have to insert a value to it, but it will always be unique within the table
* Make excellent primary key in cases where there is no naturally occurring primary key

## Defining as Identify Column

```mysql
CREATE TABLE tbl (
    ID int AUTO_INCREMENT NOT NULL,
    anotherField int null,
    primary key(ID)
);
```

## Identity vs GUID columns

* An identity column (or sequence) is unique within a given a table in a given database on a given server
* With distributed database, identity column may not\be unique across every instance of the table
* One solution is to use the identity column in conjunction with a locationID as the primary key
* Another solution Globally Unique Identifier (GUID), which is supported in some databases
* A GUID is a 16-byte ID guaranteed to be unique across every instance of a distributed database
* GUIDs are cumbersome to work with: `C1C5FCE2-879E-4A96-B845-9F3FC4A10EC8`

## Constraints

* A constraint is any kind of *restriction* that is placed on the data that is inserted into a table
    * The purpose of constraints is to ensure data integrity
* **Entity constraints** ensure the value in a column meets some criteria compared to other rows in the table
    * Primary key
    * Unique
* **Domain constraints** ensure the value in a column meets some particular criteria without respect to another row in the table
    * Default
    * Check
* **Referential integrity constraints** ensure the value in a column matches a value in another column in a different table or (sometimes) the same table
    * Foreign key

## Constraint Naming Conventions

* Sometimes have to refer to constraints by name, so name them consistently
* Begin the constraints with two letter that indicate the type of constraint
    * (pk for primary key, fk for foreign key, df for default, ck for check, and un for unique)
* Follow that with the table name
* If it is a check, default, or unique constraint, follow the table name with the column being constrained
* If it is a foreign key constraint, follow the table name with the name of the table it refers to.

## Primary Key Constraint (with alter table)

> Primary keys are unique identifier for each record in a database table

Syntax:

```mysql
ALTER TABLE {tableName}
ADD CONSTRAINT {constraintName} PRIMARY KEY ({columnname}, {columnname});
```

Example:

```mysql
# Set the primary key of the Contracts table to ArtistID and ContractDate
ALTER TABLE Contracts
ADD CONSTRAINT pk_contracts PRIMARY KEY (ArtistID, ContractDate);

# Set the primary key of tbl to the ID column
ALTER TABLE tbl
ADD CONSTRAINT pk_tbl PRIMARY KEY (ID);
```

## Primary key constraint with create table

Syntax:

```mysql
# Only allow one pk fields
CREATE TABLE {tableName} (
    {column} datattype null | not null PRIMARY KEY
);

CREATE TABLE tableName (
    column1 datatype not null,
    column2 datatype not null,
    CONSTRAINT pk_tableName PRIMARY KEY (column1, column2)
);
```

## Unique Constraint with alter table

* Sometimes want to make sure a non-primary key column has unique values
* Sometimes called **alternate keys** because they could be used as primary key if you wished

Syntax:

```mysql
ALTER TABLE {tableName}
ADD CONSTRAINT {constraintName} UNIQUE (column1, column2);
```

Example:

```mysql
# Add a constraint to the Ttiles table so taht UPC is unique
ALTER TABLE Titles
ADD CONSTRAINT un_title_upc UNIQUE (UPC);

# Add a constraint to the Titles table so that the combination of ArtistID and Title is unique
ALTER TABLE Titles
ADD CONSTRAINT un_titles_artistid_title UNIQUE (ArtistID, Title);
```

## Unique constraint with create table

Syntax:

```mysql
# create a single column unique constraint
CREATE TABLE {tableName} (
    {column} datatype not null unique
);

# Can be used to create combination of unique keys
CREATE TABLE {tableName} (
    {column1} datatype not null,
    {column2} datatype not null,
    CONSTRAINT {constraintName} UNIQUE (column1, column2)
);
```

## Default Constraint

* A default constraint automatically fills in a value if the user fails to supply a value
* Used only with inserts - once a row exists in a table the default plays no part in setting the value
    * If the insert supplies a value, it is used instead of the default
    * If the insert does not supply a value, the default value will be inserted

## Default Constraints with alter table

Syntax:

```mysql
ALTER TABLE {tableName}
ALTER {column} SET DEFAULT {value};
```

## Default Constraint with create table

Syntax:

```mysql
CREATE TABLE {tableName} (
    {column2} datatype DEFAULT {value}
);
```

Example:

```mysql
CREATE TABLE tbl (
    ID int NOT NULL,
    anotehrColumn int DEFAULT 0 NOT NULL
);
```

## Check Constraints

* A check constraint requires that data match certain patterns or have certain values
* Virtually anything can go in a WHERE clause can be used in a check constraint
    * Test against specific values
    * Test against other columns
    * Cannot test against another table - need stored procedures
* MySQL does not support check constraints
    * In order to do `check` constraint, you will need to know how to use *triggers*

## Foreign Key Constraints

* Foreign key constraint requires that every CD_ID in Child table matches existing CD_ID in parent table
* Foreign key constraint requires the parent_column in parent_table to be primary key

## Foreign Key Constraints with alter table

Syntax:

```mysql
ALTER TABLE child_tablename
ADD CONSTRAINT constraintName FOREIGN KEY (child_column, child_column2) 
REFERENCES parent_tablename (parent_column, parent_column2);
```

Example:

```mysql
# Create a foreign key relationship to enforce that StudioID of the Titles table refers to StudioID of the Studios table
ALTER TABLE Titles
ADD CONSTRAINT fk_titles_studios FOREIGN KEY (StudioID)
REFERENCES Studios (StudioID);
# Note that above may not work until you have added primary key StudioID in Studios table

# Create a foreign key relationship between the Supervisor column of SalesPeople and SalesID column of SalesPeople such that Supervisor must be a valid SalesID
ALTER TABLE SalesPeople 
ADD CONSTRAINT fk_salespeople_salespeople FOREIGN KEY (Supervisor)
REFERENCES SalesPeople (SalesID);
# Note that above may not work until you have added primary key SalesID in Sales table
```

## Foreign key constraint

Syntax:

```mysql
CREATE TABLE { table_name } (
    { column1 } { datatype },
    { column2 } { datatype },
    CONSTRAINT { constraintName } FOREIGN KEY ({ column1 })
    REFERENCES { parent_tablename } ({ parent_column })
);
```

Example:

```mysql
# Create a table called constracts with the ArtistID from the Artists table and a ContractDate field. Create a foreign key constraint between ArtistID and the ArtistID in the Artist table
CREATE TABLE Contracts (
    ArtistID Integer NOT NULL,
    ContractDate SmallDateTime NOT NULL,
    CONSTRAINT fk_contracts_artist FOREIGN KEY (ArtistID)
    REFERENCES Artists (ArtistID)
);
```

## Foreign Key Implications

* Foreign key constraints require that every PK field in child table matches existing FK in the parent table
* Constraint will not allow "orphan" records
    * Before insert new parent record before inserting related child records
    * Must delete child records before deleting related parent record
    * If updating PK value in parent tableo
        * Drop constraint before updating either parent or child
        * Or use *CASCADE UPDATE*

## Cascading update & deletes

* Cascade update would change all references in child table when a PK is changed in parent table
* Cascade delete would delete all related records in child table when a record is deleted in parent table
* Avoid orphan records

```mysql
CREATE TABLE Titles (
	TitleID int ,
	ArtistID int NOT NULL ,
	Title varchar (50) NULL ,
	StudioID int NULL ,
	UPC varchar (13) NULL ,
	Genre varchar (15) NULL ,
	CONSTRAINT fk_titles_artist FOREIGN KEY (ArtistID)
    REFERENCES Artists (ArtistID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

ALTER TABLE Titles ADD CONSTRAINT fk_titles_studios 
FOREIGN KEY (StudioID) 
REFERENCES Studios (StudioID)
ON DELETE CASCADE;
```

## Cascading updates & deletes

* MySQL supports cascade deletes with the inclusion of on delete cascade at the end of the constraint clause

## Dropping Constraints

Syntax:

```mysql
ALTER TABLE tableName
DROP PRIMARY KEY;

ALTER TABLE tableName
DROP CONSTRAINT constraintName;
```

Example:

```mysql
# Drop the fk_constracts_artist constaint on the Contracts table
ALTER TABLE Contracts
DROP FOREIGN KEY fk_contracts_artist;
```

## Field Types

* Number
    * bit
    * int
    * float
    * double
* String
    * varchar
    * text
    * enum
* Date/time
    * Date
    * Datetime
    * timestamp

## Indexes

* Used to speed up searches, sorts, and joins
* Primary keys are by definition indexes
* Other good index candidates
    * Foreign key columns
    * Non-foreign key columns used regularly to join tables
    * Columns regularly used in WHERE clauses
    * Columns regularly used in ORDER BY clauses
* Performance trade-off
    * Indexes require overhead
    * Sometimes delays to reorganize index
* Database "tuning" through analyzing and adjusting indexes

## Create an index

Syntax:

```mysql
CREATE INDEX indexname ON TableName (column1, column2);
```

Example:

```mysql
# Create an index on SalesID column in Members
CREATE INDEX ix_members_salesid ON Members(SalesID);
```

## Dropping an index

Syntax:

```mysql
DROP INDEX indexName ON tableName;
```

Example:

```mysql
DROP INDEX ix_members_salesid ON Members;
```

## Views

* Users can select from a view just as they would select from a table, but it is constructed "on-the-fly" from the SELECT instructions inside the view
* Views reduce complexity for end users and front-end programmers
* Since view don't have to include all columns ina table, you can use them to hide sensitive data
* Views can hide many of the differences between database systems

## Creating a view

Syntax:

```sql
CREATE VIEW viewname SQL select_statement;
```

Example:

```sql
# Create a view of just the ArtistName, WebAddress and LeadSource columns of Artists for just those Artists with a WebAddress
CREATE VIEW vwArtistWebs AS
SELECT ArtistName, WebAddress, LeadSource
FROM Artists WHERE WebAddress IS NOT NULL;
```

## Dropping a view

Syntax:

```sql
DROP VIEW viewName;
```

Example:

```sql
# Drop the view vwArtistWebs
DROP VIEW vwArtistWebs;
```

## Stored Procedures & Triggers

* Stored procedures and triggers move programming code from the front-end application to back-end database
* Advantages
    * Simplifies front-end programming
    * Allows database programmers rather than application programmers to control and monitor complex data relationships
    * Can simplify data migration
    * Back-end programming generally runs faster than front-end programming
