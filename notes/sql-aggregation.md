# Aggregations and Sub-queries

We can use aggregations for better data reporting like summarizing data into
aggregated calculation.

And we can do query against our own query (sub-query!).

Moreover, we will also be learning `JOIN` to deal with more than one table.

## Objectives

* Review lab 1
* Understand what aggregate functions are
* Understand what sub-query is

## Metrics

* Write SQL queries to aggregate data
* Learn how to write sub-query in `WHERE` clause
* Use `ANY` and `ALL` with sub-query

## Lab 1 Review

It's very important for students to know the table structure before students start
to design any sort of query. You got to understand what the database is for first.

A general rule to get all talbes:

```sql
SHOW TABLES;
```

And with the table name, you can type in the following command to see their columns:

```sql
DESCRIBE {table};
```

Last but not least, I strongly recommend you to prepare a pen and paper to start
writing down all table and their columns so you know what column(s) you can read
from what table.

For example:

```
Artist(
  ArtistId,
  ArtistName,
  City,
  Region,
  Country,
  WebAddress,
  EntryDate,
  LeadSource
);

Genre(
  Genre
);

Members(
  MemberID,
  FirstName,
  LastName,
  Address,
  City,
  Region,
  PostalCode,
  Country,
  HomePhone,
  WorkPhone,
  EMail,
  Gender,
  Birthday,
  SalesID
);

SalesPeople(
  SalesID,
  FirstName,
  LastName,
  Initials,
  Base,
  Supervisor
);

Studios(
  StudioID,
  StudioName,
  Address,
  City,
  Region,
  PostalCode,
  Country,
  WebAddress,
  Countact,
  EMail,
  Phone,
  SalesID
);

Titles(
  TitleID,
  ArtistID,
  Title,
  StudioID,
  UPC,
  Genre
);

Tracks(
  TitleID,
  TrackNum,
  TrackTitle,
  LengthSeconds,
  MP3,
  RealAud
);

XrefArtistMembers(
  MemberID,
  ArtistID,
  RespParty
);
```

Is there other way you can represent the table?

ER Diagram (Entity-Relationship)! -- http://www.tutorialspoint.com/dbms/er_diagram_representation.htm

![Lyric ER Diagram](imgs/lyric_diagram.jpg)

### What is aggregation

It's not like computed column we covered last week only derive value from single
row.

Aggregation is about summarizing values from a group of rows.

### Standard aggregation functions in SQL

| \ | Purpose | Data types | Notes |
| :-- | :-- | :-- | :-- |
| Sum | To calculate totals | Numeric | |
| Avg | To calculate averages | Numeric | Ignores NULLs |
| Count | To count records | Any | Count records with `COUNT(*)` or with `COUNT({column})` |
| Min | To report minimum value | Any |  |
| Max | To report maximum value | Any |  |

### Basic Aggregate Functions

Syntax:

```sql
SELECT {aggregate_function}({field | expression}) [AS alias]
FROM {table}
```

Examples:

```sql
# Report the total time in seconds of all tracks
SELECT SUM(LengthSeconds)
FROM Tracks;

# Report the average length in minutes of the tracks for TitleID = 1
SELECT AVG(LengthSeconds) / 60
FROM Tracks
WHERE TitleID=1;

# Report the shortest and longest track lengths in seconds
SELECT MIN(LengthSeconds) AS Shortest, MAX(LengthSeconds) AS Longest
FROM Tracks;
```

### Group By

If SELECT has only aggregations, it will only report one row for the entire set of records.

If non-aggregate fields are included in the SELECT clause, query will report one
row for each combination of non-aggregated field value with aggregates calculated
for each.

> In other word, you must include `GROUP BY` clause to list the non-aggregate fields
> with aggregated fields

The more fields in the `GROUP BY` clause, the more rows will be reported

Syntax:

```sql
# again, order is important
SELECT {column(s)}, {aggregate_function}({column})
FROM {table(s)}
WHERE {condition(s)}
GROUP BY {column(s)}
ORDER BY {column(s)}
```

Example:

```sql
# Report the total time in seconds for each title
SELECT TitleId, SUM(LengthSeconds)
FROM Tracks
GROUP BY TitleID;

# Report the number of members in each state
SELECT Region, COUNT(*) AS NumMembers
FROM Members
GROUP BY Region;

# Report the number of members by state and gender
SELECT Region, Gender, COUNT(*) AS NumMembers
FROM Members
GROUP BY Region, Gender;

# Report the shortest and longest track lengths in seconds for each title
SELECT TitleID, MIN(LengthSeconds) AS Shortest, MAX(LengthSeconds) AS Longest
FROM Tracks
GROUP BY TitleID;
```

More GROUP BY Examples:

```sql
SELECT COUNT(*)
FROM Members
WHERE Email IS NOT NULL;

SELECT Gender, COUNT(*) AS Num
FROM Members
WHERE EMAIL IS NOT NULL
GROUP BY Gender;
```

### HAVING clause

HAVING clause is like WHERE but with a few differences:

* WHERE restricts results prior to aggregate calculations based on individual row values
* HAVING restricts results based on aggregated values
* HAVING always uses an aggregate function as its test

Syntax (**order** is important):

```sql
SELECT {column(s)},
  {aggregate_function}({column(s)}) AS {alias}
FROM {table(s)}
WHERE {condition(s)}
GROUP BY {column(s)}
HAVING {condition(s)}
ORDER BY {column(s)};
```

Examples:

```sql
SELECT TitleID, SUM(LengthSeconds) / 60 AS TotalMinutes
FROM Tracks
GROUP BY TitleID
HAVING SUM(LengthSeconds) / 60 > 40;
# In MySQL you can use column alias in HAVING Clause
```

Example of HAVING vs WHERE:

```sql
SELECT TitleID, AVG(LengthSeconds) AS AvgLength
FROM Tracks
GROUP BY TitleID;

/*
TitleID     AvgLength   
----------- -----------
1           279
3           212
4           221
5           231
6           532
7           309
*/

SELECT TitleID, AVG(LengthSeconds) AS AvgLength
FROM Tracks
GROUP BY TitleID
HAVING AVG(LengthSeconds) > 240;

/*
TitleID     AvgLength   
----------- -----------
1           279
6           532
7           309
*/

SELECT TitleID, AVG(LengthSeconds) AS AvgLength
FROM Tracks
WHERE LengthSeconds > 240;

/*
TitleID     AvgLength   
----------- -----------
1           327
3           294
4           352
5           282
6           532
7           325
*/
```

### Sub-Queries

A query within a query (Query-ception) (within parentheses)

> Sub-queries can be placed in WHERE, SELECT, and FROM clauses

Syntax:

```sql
SELECT {column(s)}
FROM {table(s)}
WHERE {column(s)} {comparison like IN} (
  SELECT {column(s)} FROM {table(s)}
);
```

Examples:

```sql
# List the name of the oldest member
SELECT LastName, FirstName
From Members
WHERE Birthday = (
  SELECT MIN(Birthday)
  FROM Members
);

# List all track titles and lengths of all tracks whose length is
# longer than the average of all track lengths
SELECT TrackTitle, LengthSeconds
FROM Tracks
WHERE LengthSeconds > (
  SELECT AVG(LengthSeconds)
  FROM Tracks
);

# List the names of all artists who have recorded a title
SELECT ArtistName
FROM Artists
WHERE ArtistID IN (
  SELECT ArtistID
  FROM Titles
);
```

More demonstration:

```sql
# Outer query looks for records with birthday matching sub-query value
SELECT LastName, FirstName
FROM Members
WHERE Birthday = (
  /*
  MIN(Birthday)
  -------------
  1955-11-01
  */
  SELECT MIN(Birthday)
  FROM Members
);
```

### ALL & ANY

Usually used with Sub-Queries but you can also used with greater than or less than conditions.

* ANY, comparison will be true if satisfies any value produced by the sub-query
* ALL, comparison must satisfied all values produced by the sub-query

Syntax:

```sql
SELECT {column(s)}
FROM {table(s)}
WHERE {column} {comparison} {ANY|ALL} (
  SELECT {column(s)}
  FROM {table(s)}
);
```

Example:

```sql
# List the name, region, and birthday of every member who is older than all
# of the members in Gerorgia (GA)
SELECT LastName, FirstName, Region, Birthday
FROM Members
WHERE Birthday < ALL(
  SELECT Birthday
  FROM Members
  WHERE Region='GA'
);

# List the name, region, and birthday of every member who is
# older than any of the members in Georgia(GA)
SELECT LastName, FirstName, Region, Birthday
FROM Members
WHERE Birthday < ANY(
  SELECT Birthday
  FROM Members
  WHERE Region='GA'
);
```
