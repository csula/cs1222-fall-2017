# Joins

Joining tables is the most fundamental knowledge of relational database.

In earlier part of lecture, we are learning how to deal with single table. From
this lecture on, we will be dealing with relationships between tables by using
Joins.

## Objectives

* Homework 1 reminder
* Lab 1 review
* Learn how SQL join works
* Join tables using EQUI JOIN
* Join tables using INNER JOIN
* Understand difference between INNER JOIN and OUTER JOIN
* Join tables using OUTER JOIN
* Join the sub-query in the FROM clause
* Self join
* Join tables with FULL JOIN and CROSS JOIN

## Metrics

* Able to perform Join in queries

### Joins

When SQL join tables, they join table "side by side"

Think of the following examples:

```sql
USE examples;

CREATE TABLE Table_A (
	`ID` int,
	`Name` varchar(200)
);

INSERT INTO Table_A (`ID`, `Name`)
VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Eve');

CREATE TABLE Table_B (
	`ID` int,
	`Class` varchar(200)
);

INSERT INTO Table_B (`ID`, `Class`)
VALUES (1, 'Computer Science'), (2, 'Mathematic'), (3, 'Physics');
```

**Table_A**

| ID | Name |
| :-- | :-- |
| 1 | Alice |
| 2 | Bob |
| 3 | Eve |

**Table_B**

| ID | Class |
| :-- | :-- |
| 1 | Computer Science |
| 2 | Mathematic |
| 3 | Physics |

When `Table_A` joins `TABLE_B`, SQL takes the following steps:

```sql
SELECT *
FROM Table_A
JOIN Table_B;
```

1. Create Cartesian Product

| ID | Name | ID | Class |
| :-- | :-- | :-- | :-- |
| 1 | Alice | 1 | Computer Science |
| 2 | Bob | 1 | Computer Science |
| 3 | Eve | 1 | Computer Science |
| 1 | Alice | 2 | Mathematic |
| 2 | Bob | 2 | Mathematic |
| 3 | Eve | 2 | Mathematic |
| 1 | Alice | 3 | Physics |
| 2 | Bob | 3 | Physics |
| 3 | Eve | 3 | Physics |

2. Eliminate Non-Matching Records

> If you have set WHERE clause

```
SELECT * FROM
TABLE_A JOIN TABLE_B
WHERE Class = 'Computer Science';
```

| ID | Name | ID | Class |
| :-- | :-- | :-- | :-- |
| 1 | Alice | 1 | Computer Science |
| 2 | Bob | 1 | Computer Science |
| 3 | Eve | 1 | Computer Science |

### Equi JOIN (Comma Join)

Equi join (or often being referred as comma join) is to not using JOIN keyword to
join tables but to simply select them and manually join them on the WHERE Clause.

Syntax:

```sql
SELECT {column(s)}
FROM {table1}, {table2}
WHERE {table1.column} = {table2.column};
```

Example:

```sql
# list the CD, title and the title of all tracks recorded in StudioID 2
SELECT Title, TrackTitle
FROM Titles, Tracks
WHERE Titles.TitleID = Tracks.TitleID AND
StudioID = 2;

# List the names of members from Georgia (GA) and their salespeople
SELECT Members.LastName, Members.FirstName, SalesPeople.LastName, SalesPeople.FirstName
FROM Members, SalesPeople
WHERE Members.SalesID = SalesPeople.SalesID AND
Region = 'GA';

# Join with Aggregate
# List the names of all artists who have recorded a title and the number of titles they have
SELECT ArtistName, Count(Titles.ArtistID) AS NumTitles
FROM Artists, Titles
WHERE Artists.ArtistID = Titles.ArtistID
GROUP BY ArtistName;

# Three table join
# List the names of members in The Bullets.
SELECT Members.LastName, Members.FirstName
FROM Members, XRefArtistsMembers, Artists
WHERE Members.MemberID = XRefArtistsMembers.MemberID AND
Artists.ArtistID = XRefArtistsMembers.ArtistID AND
ArtistName = 'The Bullets';
```

### Inner Join

Inner join produces same result as Equi Join but with a slightly different syntax.

> Think of the relationship specifications moved from WHERE clause to ON clause

Syntax:

```sql
SELECT {column(s)}
FROM {Table1}
INNER JOIN {Table2} ON {Table1.column} = {Table2.column};
```

Example:

```sql
# List the CD title and titles of all tracks recorded in StudioID 2
SELECT Title, TrackTitle
FROM Titles
INNER JOIN Tracks
ON Titles.TitleID = Tracks.TitleID # relationship specifications
WHERE StudioID = 2;

# List the names of members from Georgia (GA) and their salespeople
SELECT Members.LastName, Members.FirstName, SalesPeople.LastName, SalesPeople.FirstName
FROM Members
INNER JOIN SalesPeople
ON Members.SalesID = SalesPeople.SalesID
WHERE Region = 'GA';

# Join with Aggregate
# List the names of all artists who have recorded a title and the number of titles they have
SELECT ArtistName, Count(Titles.ArtistID) AS NumTitles
FROM Artists
INNER JOIN Titles
ON Artists.ArtistID = Titles.ArtistID
GROUP BY ArtistName;

# Three table join
# List the names of members in The Bullets.
SELECT Members.LastName, Members.FirstName
FROM Members
INNER JOIN XRefArtistsMembers
ON Members.MemberID = XRefArtistsMembers.MemberID
INNER JOIN Artists
ON Artists.ArtistID = XRefArtistsMembers.ArtistID
WHERE ArtistName = 'The Bullets';
```

### Table Aliases

Just like column, you can also alias the table name.

Syntax:

```sql
SELECT {column(s)}
FROM {Table1} {t1}
INNER JOIN {Table2} {t2}
ON {t1.column} = {t2.column}
WHERE {condition(s)};
```

Example:

```sql
SELECT m.LastName, m.FirstName, s.LastName, s.FirstName
FROM Members m
INNER JOIN SalesPeople s
ON m.SalesID = s.SalesID
WHERE Region = 'GA';
```

### Outer Join

Lets talk about inner join first:

* Compares all records of tables being joined
* Matches rows based on shared fields
* Reports only matching rows

OUTER JOINs are a way to make SQL show you unmatched rows

And there are two kinds of OUTER JOINS: LEFT OUTER JOIN & RIGHT OUTER JOIN
* LEFT JOIN reports all of the records of the first (left) of two tables plus matching records in the second (right) table.
* RIGHT JOIN reports all of the records of the second (right) of two tables plus matching records in the first (left) table.

Example:

```sql
# inner join
SELECT ArtistName, Title
FROM Artists a
INNER JOIN Titles t
ON a.ArtistID = t.ArtistID;

/*
Artistname                       Title                        
-------------------------------- ----------------------------
The Neurotics                    Meet the Neurotics
Confused                         Smell the Glove
The Bullets                      Time Flies
The Neurotics                    Neurotic Sequel
Sonata                           Sonatas
Louis Holiday                    Louis at the Keys
*/

# outer join
SELECT ArtistName, Title
FROM Artists a LEFT JOIN Titles t
ON a.ArtistID = t.ArtistID;

/*
Artistname                        Title                         
--------------------------------- -----------------------------
The Neurotics                     Meet the Neurotics
The Neurotics                     Neurotic Sequel
Louis Holiday                     Louis at the Keys
Word                              NULL
Sonata                            Sonatas
The Bullets                       Time Flies
Jose MacArthur                    NULL
Confused                          Smell the Glove
The Kicks                         NULL
Today                             NULL
21 West Elm                       NULL
Highlander                        NULL
*/
```

Syntax of outer join:

```sql
SELECT {column(s)}
FROM Table1
{LEFT|RIGHT} JOIN Table2
ON Table1.column = Table2.column;
WHERE {condition(s)}
```

Example:

```sql
# List the names of all artists and the titles (if any) that they have recorded.
SELECT ArtistName, Title
FROM Artists a
LEFT JOIN Titles t
ON a.ArtistID = t.ArtistID;

# List every genre from the Genre table and count of
# the number of recorded tracks in that genre, if any
SELECT g.Genre, COUNT(TrackNum) AS NumTracks
FROM Genre g
LEFT JOIN Titles ti
ON g.Genre = ti.Genre
LEFT JOIN Tracks tr
ON ti.TitleID = tr.TitleID
GROUP BY g.Genre;
```

More examples on outer join to duplicate not IN functionality:

```sql
SELECT a.ArtistID, ArtistName, t.ArtistID
FROM Artists a
LEFT JOIN Titles t
ON a.ArtistID = t.ArtistID;

/*
ArtistID    Artistname                   ArtistID    
----------- ---------------------------- -----------
1           The Neurotics                1
1           The Neurotics                1
2           Louis Holiday                2
3           Word                         NULL
5           Sonata                       5
10          The Bullets                  10
14          Jose MacArthur               NULL
15          Confused                     15
17          The Kicks                    NULL
16          Today                        NULL
18          21 West Elm                  NULL
11          Highlander                   NULL
*/

SELECT ArtistName
FROM Artists a
LEFT JOIN Titles t
ON a.ArtistID = t.ArtistID
WHERE t.ArtistID IS NULL;

SELECT ArtistName
FROM Artists
WHERE ArtistID NOT IN (
  SELECT ArtistID FROM Titles
);

/*
Artistname                    
-----------------------------
Word
Jose MacArthur
The Kicks
Today
21 West Elm
Highlander
*/
```

### Joining on More than One Column

Include AND in ON or WHERE clause to link more columns.

```sql
# inner join
SELECT TrackTitle
FROM Tracks t
INNER JOIN AudioFiles a
ON t.TitleID = a.TitleID AND t.TrackNum = a.TrackNum
WHERE AudioFormat = 'MP3';

# equi join
SELECT TrackTitle
FROM Tracks t, AudioFiles a
WHERE t.TitleID = a.TitleID AND
t.TrackNum = a.TrackNum AND
AudioFormat = 'MP3';
```

### Self joins

A table join itself. For example, you may have a employee table and each employee has boss (which refer to the employee id). Then, you will need to do self join to find out the boss name.

For example:

```sql
USE examples;

CREATE TABLE Employee (
	`ID` int,
	`Name` varchar(200),
  `BossID` int
);

INSERT INTO Employee (`ID`, `Name`, `BossID`)
VALUES (1, 'Alice', NULL), (2, 'Bob', 1), (3, 'Eve', 1);
```

Then to find out the boss name, we would:

```sql
SELECT e.Name, b.Name AS "Boss's Name"
FROM Employee e
INNER JOIN Employee b
ON e.BossID = b.ID;
```

Syntax of self join:

```sql
SELECT {table1.column(s)}, {table2.column(s)}
FROM Table1
{INNER|LEFT|RIGHT} JOIN Table 2;
```

Examples:

```sql
# List the names of all salespeople who have
# supervisors along with the names of their supervisors
SELECT Sales.FirstName AS EmpFirst, Sales.LastName AS EmpLast,
  Sup.FirstName AS SupFirst, Sup.LastName, SupLast
FROM SalesPeople Sales
INNER JOIN SalesPeople Sup
ON Sales.Supervisor=Sup.SalesID;
```

### Joining to Sub-queries

You can also join a sub-query (since they return table anyway)

Syntax:

```sql
SELECT {columns}
FROM Table1
{INNER|LEFT|RIGHT} JOIN (
  SELECT {column(s)} FROM {Table} WHERE {condition(s)}
) Table2
ON Table1.column = Table2.column;
```

Examples:

```sql
# list all artists with members in Georgia.
SELECT DISTINCT ArtistName
FROM Artists a
INNER JOIN XRefArtistsMembers x
ON a.ArtistID = x.ArtistID
INNER JOIN (
  SELECT MemberID
  FROM Members m
  WHERE m.Region='GA'
) m
ON m.MemberID = x.MemberID;
```

### Full Join

To recap on outer join, outer join reports all records in one table plus matching records in a second table. But Full join reports all ercords in both tables whether they match or not.

> Think of full join as doing both LEFT JOIN and RIGHT JOIN at the same time.

Syntax:

```sql
SELECT {column(s)}
FROM Table1
FULL JOIN Table2
ON Table1.column = Table2.column;
```

Examples:

```sql
SELECT phone1.Phone AS FirstPhone, phone2.Phone AS SecondPhone
FROM Phone1 FULL JOIN Phone2
ON Phone1.Phone = Phone2.Phone;
```

### Cross Join

* Builds a Cartesian Product
* Uses no ON keyword

Syntax:

```sql
SELECT {column(s)}
FROM Table1 CROSS JOIN Table2;
```

Examples:

```sql
SELECT FirstName, LastName, Genre
FROM SalesPeople CROSS JOIN Genre;
```

### Summary

| Join type | Comments |
| :-- | :-- |
| Inner (equi) joins | Reports only matched rows |
| Outer joins | Reports all of records from one table plus the matching records from the other tables |
| Self joins | Column in one table matched to another column in same table |
| Full joins | Matches rows like outer joins but includes rows from either table that match to NULL |
| Cross joins | Cartesian product without dealing with matches |
