# Basic SQL Syntax

Time to dive into SQL!

## Objectives

* Recap of SQL
* Basic select statements
* Setup MySQL server

## Metrics

* Report information of one to many fields
* Sort reports
* Create computed columns
* Filter results
* Able to run MySQL queries

### What is SQL?

Structured Query Language.

It's open **ANSI standard** -- which means SQL syntax will not likely to be changed
for a long long time and likely to be supported from different vendors.

As I mentioned earlier in introduction lectures, SQL is used by many different
roles -- DBA (database administrators), application developers even front end
developers can use SQL on the front end now! In other word, it is quite useful
skill for developers like you to have.

### What can SQL do?

* View information from relational database
* Manipulate data in relational database
* Define relational database schema

### How standard is SQL?

Most vendors (Microsoft, Oracle, MySQL ... etc.) meets SQL89 standards and many
meets SQL92 standard.

> So SQL you write in standard will like to work from one to the other database

However, there are still some variety in SQL from vendors to vendors because:

* ANSI doesn't define everything
* Vendors may not comply with standards
* Vendors wishes to include extra features/better performance

In summary, when it comes to ANSI SQL (standard) vs DBMS(Database Management System)
SQL (vendor specific):

| ANSI SQL | DBMS SQL |
| :------------- | :------------- |
| Maintains portability of code | Gain added functionalities |
| Maintains portability of your skill set | Gain performance for specific vendor |

### Basic select structures

```sql
SELECT {column(s)}
FROM {table(s)}
[WHERE {condition(s)}];
```

### General tips for writing SQL

Although names and keywords are generally not case sensitive. I usually like to
write keyword in all CAPITALIZED and name in the correct case with quote.

Table name, on the other hand, is case sensitive!

If you somehow name the field name same as any of the keywords in SQL, you will
have to surround your field name in quote.

### Set up of examples below

Before starting the examples below, you will want your SQL server set up and
MySQL workbench or MySQL client ready.

Once you have MySQL server running and then you may start MySQL workbench.

You want to connect to your local MySQL server and run
[samples/Lyric.sql](../samples/Lyric.sql) to create sample data.

### Example of select statements

```sql
# selecting one field from Artists table
SELECT ArtistName
FROM Artists;
```

```sql
# selecting multiple fields from Artists table
SELECT ArtistName, City, Region
FROM Artists;
```

```sql
# selecting all fields from Artists table
SELECT *
FROM Artists;
```

### Duplicates

Note that if you try do do the following:

```sql
SELECT *
FROM Members;
```

You will see duplicated records in the result table.

This is sometimes not what we expect to get from the result.

So how do we get rid of duplicated records?

```sql
SELECT DISTINCT *
FROM Members;
```

Or we can generalize the syntax above like:

```sql
# DISTINCT option allows you to get rid of duplicated records
SELECT [DISTINCT] {column(s)}
FROM {table(s)}
[WHERE {condition(s)}];
```

### Calculated columns

Note that the columns you used in SELECT above can be calculated column too with
alias (label) on column (by using `AS`)

For example:

```sql
# You can compute numeric field
SELECT (1+1);
# will return 2!
```

```sql
# List title and length in minutes of each Track
SELECT TrackTitle, LengthSeconds/60 AS LengthMinutes
FROM Tracks;
```

```sql
# Assume base is weekly base, report the first name, last name and yearly base
# salary of each salesperson
SELECT Firstname, Lastname, Base * 52 AS YearlyBase
FROM Salespeople;
```

So what are the syntax of computation?

| Syntax | Meaning |
| :------------- | :------------- |
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |

### Alias (cont.)

Sometimes you may find that one word is not descriptive enough for alias (label),
you can actually use multi-words (separated by space) for label too!

> You do need to surround this multi-words alias with quote

Example:

```sql
# MySQL
SELECT WebAddress AS `Web Site`
FROM Artists;

# Oracle
SELECT WebAddress AS "Web Site"
FROM Artists;
```

> Note that Aliases can NOT be used in WHERE clause.

### Where Clauses (filter out results)

So far we covered how to get all rows from tables. For usual use case, you want
to get certain rows. You can accomplish this by using `WHERE` clauses.

> Note that the where clauses can be case sensitive!

Example:

```sql
# List firstname, lastname of every Member from Canada
SELECT Firstname, Lastname
FROM Members
WHERE Country='Canada';
```

```sql
# List title and length in seconds of tracks that run more than 240 seconds
SELECT TrackTitle, LengthSeconds
FROM Tracks
WHERE LengthSeconds > 240;
```

```sql
# Find salesperson with yearly base salary less than 10,000
SELECT Firstname, Lastname, Base * 52 AS YearlyBase
FROM Salespeople
WHERE Base * 52 < 10000;
```

```sql
# Find all tracks whose TrackNum is the same as its TitleID
SELECT *
FROM Tracks
WHERE TrackNum=TitleID;
```

### Basic Comparison Operators

| Comparison | MySQL | Oracle |
| :------------- | :------------- | :------ |
| Equals to | = | = |
| Not equals to | != or <> | != or <> |
| Less than | < | < |
| Greater than | > | > |
| Greater than or equals to | >= | >= |
| Less than or equals to | <= | <= |

### Using Dates in Where Clauses

Example:

```sql
SELECT Firstname, Lastname, Birthday
FROM Members
WHERE Birthday > '1975-01-01';
```

### Multiple Where Clauses

You can combine multiple conditions with `AND`, `OR`.

Before we talk about the combinations, you will probably find this truth table useful.

| P | Q | AND | OR |
| :------------- | :------------- | :-- | :-- |
| T | T | T | T |
| T | F | F | T |
| F | T | F | T |
| F | F | F | F |

Syntax of combining conditions can be like:

```sql
SELECT {column(s)}
FROM {table(s)}
WHERE {condition1} {AND|OR} {condition2}
```

More examples:

```sql
SELECT *
FROM Members
WHERE Region='GA' AND SalesID=2;
```

Just like math formula, you can use parentheses to group conditions so that can
be treated as a unit.

> You should probably always use parentheses when you are mixing ANDs and ORs

Example:

```sql
SELECT Firstname, Lastname, Region, SalesID
FROM Members
WHERE Region='GA' OR Region='TX' AND SalesID=2;
```

```sql
SELECT Firstname, Lastname, Region, SalesID
FROM Members
WHERE (Region='GA' OR Region='TX') AND SalesID=2;
```

### Booleans in Where clauses

```sql
# List the tracktitles and realaud fields for all track records that do not have
# a real audio file
SELECT Tracktitle, Realaud
FROM Tracks
WHERE realaud = False;
```

> In MySQL, True = 1 and False = 0

### Like and Wildcards

Like and Wildcards can be test a group of letters anywhere in the field value.

Syntax is like `%value%` or `_value_`.

* `_` stands for any **single** character
* `%` stands for any number of characters

Example:

| Wildcards | Match examples |
| :------------- | :------------- |
| LIKE 'Mac%' | Mac, MacIntosh, Mackenzie, MacOS |
| LIKE 'J%n' | John, Johnso, Jason, Juan |
| LIKE 'Mac_' | Mack, Macs |
| LIKE '%s_n' | Anderson, Johnson, san, sun |

Furthermore, you can use `LIKE` in your WHERE clauses.

```sql
SELECT Tracktitle
FROM Tracks
WHERE TrackTitle LIKE '%time%';
# Note that wildcards (% and _) only works when you use LIKE
```

```sql
# Find all web address with a `.com` domain
SELECT WebAddress
FROM Studios
WHERE WebAddress LIKE '%.com';
```

### Between

You can use Between clause to find value falls between two values inclusively (
mostly used with dates but also works with numeric and text fields)

Example:

```sql
# Find all artists with entry dates in August
SELECT *
FROM Artists
WHERE Entrydate BETWEEN '2003-08-01' AND '2003-08-31';
```

### NULL

> Oh billion-dollar mistake! https://en.wikipedia.org/wiki/Tony_Hoare

NULL indicates empty or undefined field.

To test Null, you have to use `IS`

```sql
SELECT Artistname
FROM Artists
WHERE WebAddress IS NULL;
```

### IN

You can use IN field to match any items in a list (placed inside of parentheses
and individual items are separated by commas)

Syntax:

```sql
SELECT {column(s)}
FROM {table(s)}
WHERE {field} IN (value1, value2, ...)
```

Example:

```sql
# List members living in Indianna(IN), Illinois(IL), or Ohio(OH)
SELECT *
FROM Members
WHERE Region IN ('IN', 'IL', 'OH');
```

### NOT

Reverses the selection criterion (True becomes False and vice versa)

> Note that Parenthese(s) is required in MySQL

Syntax:

```sql
SELECT {column(s)}
FROM {table(s)}
WHERE NOT (conditions)
```

Example:

```sql
# List titles whose genre is not alternative
SELECT *
FROM Titles
WHERE NOT (Genre = 'alternative');
# Or below works the same way
SELECT *
FROM Titles
WHERE Genre != 'alternative';
```

### CASE

You can use CASE to do condition logic.

> If you took programming classes before, think of CASE as Switch

Syntax:

```sql
SELECT {column(s)},
CASE {column}
  WHEN value1 THEN result1
  WHEN value2 THEN result2
  ELSE result3
END [AS {alias}]
FROM {table(s)};
```

Example:

```sql
SELECT Firstname,
CASE Gender
  WHEN 'F' THEN 'Woman'
  WHEN 'M' THEN 'Man'
END AS 'Sex'
FROM Members;
```

Computed value can be used in CASE too!

```sql
# List first two tracks of each title, identifying short 1st tracks
# and long 1st tracks
SELECT TrackNum, TrackTitle, LengthSeconds,
CASE
  WHEN TrackNum=1 AND LengthSeconds<240 THEN 'Short 1st'
  WHEN TrackNum=1 AND LengthSeconds>480 THEN 'Long 1st'
  ELSE 'Another Track'
END AS 'Eval'
FROM Tracks;
```

### Sorting

From now, the result we are getting from the SELECT statement is usually not
sorted in any order. We can use `ORDER BY` to sort the result

> Note that default sorting order is ASCending (A-Z, 0-9), you can specify DESC
for descending order

Syntax:

```sql
SELECT {column(s)}
FROM {table(s)}
ORDER BY {column(s)} [DESC];
```

Example:

```sql
# sort in ascending order (default behavior)
SELECT Artistname
FROM Artists
ORDER BY Artistname;
```

```sql
# sort in descending order
SELECT TrackTitle, LengthSeconds
FROM Tracks
WHERE TitleID=5
ORDER BY LengthSeconds DESC;
```

```sql
# sort multiple columns by their order
SELECT Title, Genre
FROM Titles
ORDER BY Genre, Title;
```
