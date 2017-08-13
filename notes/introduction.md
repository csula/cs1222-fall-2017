# Introduction to database

Welcome to Introduction to Database class (CS-1222)!

This is the first day of class, please stay seated and enjoy for the first half
of the class while I'm going over the [syllabus][1] and overall format of the class.

## Objectives

* [Syllabus][1]
* Introduction to database
* Set up your environment
* Set up CSNS account

## Metrics

* Environment set up
* Understanding of database concept
* CSNS set up

### What is database?

The purpose of database is to store data persistently like physical files on your
disk. For instance, you may have a text file, word document or your code sitting
at your documents.

Note that these files don't vanish when you exit the program or restart the computer,
it stays the same state until you open and continue to edit or until you manually
delete the file.

In other word, the file is **persistent** or **durable** not like data stored in the
memory -- temporary.

What is data stored in memory like?

Back to the physical file example, the characters you typed without hitting the
save button -- you can see them showing on the screen -- are an example. These
*temporary* changes are the data stored in the memory. In other word, if you
forgot to save and exit the program, you lose all these changes. Oh no!!

### Why databases?

Programs can read and write the files just fine. So why bothers with databases?

Databases offers many features in addition to the durability.

First, there are several kinds of databases:

* Relational databases
* NoSQL databases
* Key-value pair databases

They all are persistent and give us some kind of data structures for storing and
searching our data. Usually much faster and easier than we could in flat files.

With database, it is also possible to have multiple users(programs) modifying the
same data at the same time without stepping on top of each others' toes. In other
word, database is usually **distributed**.

This distributed attribute is generally hard to do with a flat file (think about
when you and your friends editing the google document at the same time). If two
programs write to the same file at the same time, often one will overwrite the other.

### Relational databases

Relational databases do even more than above (persistent and distributed).

Relational databases also offers:

* Flexible query languages (SQL) with aggregation and join operations
* Constraints -- rules for protecting consistency of your data

An example of SQL could be:

```sql
SELECT * FROM students;
```

Above sql will retrieve all records from `students` table.

Constraints helps us to ensure the data integrity.

### How does relational databases store data?

Tables!

For example of a students table:

| ID | Name | CIN | Grade | LastModified |
| --- | --- | --- | --- | --- |
| 1 | Eric | 12345678 | 93 | 2016-09-30 12:59 |
| 2 | Michael | 32145678 | 96 | 2016-08-22 13:10 |
| 3 | Mark | 555555555 | 90 | 2016-08-12 18:30 |
| 4 | Pierre | 87654321 | 100 | 2016-08-03 19:03 |

By looking at table, users will be able to tell what grade a person get, CIN of
a user, and when is the last modified date for the user.

Now is the time to introduce some of the terminology:

* Table (Relation)
  * like name of the table (students)
* Record (table row or tuple)
  * Each row is a record
* Field (column or attribute)
  * Each column is a field

### Relational database concepts

* Candidate key
  * Unique identifier per record
  * Can have multiple candidate key
* Primary key
  * Only candidate key(s) as primary key
  * Only one primary key per table

In example:

ID and CIN above are a candidate key also can be a primary key as the rest are
not of keys as they may not be unique. In example, there could be two "Eric"s
and thus `Name` field cannot be candidate key nor primary key.

### Data types

Determine what type of data a column will store.

A few examples of data types:

* Integer
  * like `ID`
* String(Text)
  * like `Name`
* Date/time
  * like `LastModified`
* Boolean (true or false)
  * Maybe we can add more field like Passing

### Schema

The "definition" of a table:

* Names of table
* Attributes and attribute types
* Constraints on the table
* Dependencies between tables

Above all summarizes the introduction to database, from now we will be setting
up environment on your computer and hopefully get you used to the environment.

An example on how SQL defines schema:

```sql
CREATE TABLE `students` (
  `ID` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(200) unsigned NOT NULL DEFAULT 0,
  `CIN` varchar(8) NOT NULL DEFAULT '',
  `Grade` mediumint(8) unsigned NOT NULL DEFAULT 0,
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
```

Running above sql query will create a students table.

### Set up CSNS

Go to http://csns.calstatela.edu/ to activate your account.

If this is your first time getting your account, your username and password are
both your CIN.

Once you get your account, you should see CS-1222 (section 1 or 2) showing up
under your session.

> If you don't see CS-1222, please see me after the class.

### Set up environment

Download [MySQL](http://dev.mysql.com/doc/refman/5.7/en/windows-installation.html#windows-installation-simple).

> If you are using lab computers, just go to next step.

Start MySQL workbench.

> Addition on the MySQL server setup

Follow note here to set up MySQL server --
https://github.com/csula/Utilities/blob/master/setups/mysql.md

Once you finished installation above, you will always need to start your MySQL
server first before you start MySQL workbench or any other MySQL client.

[1]: ../SYLLABUS.md
