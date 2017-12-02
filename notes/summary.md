# Intro to Database Summary

In the last lesson, we will go over the practical sense of the database in the
modern web development generation. In other word, we will be looking at a overall
web application stack and focus on how database is used in it. 

## Recap

What have we learned so far?

* MySQL CRUD (Create, Read, Update & Delete)
* MySQL Aggregations 
* MySQL Joins (most challenged one) 
* MySQL Transactions 
* MongoDB CRUD 
* MongoDB Aggregations

In summary, we learned quite a lot on reading data from databases (MySQL and
MongoDB) with a few updating abilities.

With the knowledge, you should be able to look at the cheatsheet like:
http://files.zeroturnaround.com/pdf/zt_sql_cheat_sheet.pdf

## Expectations

Specifically, you should be able to do the followings:

1. You should be able to create a DDL file (data definition language) like what we
have in samples folder to create database and tables
2. You should be able to read data from the existing schema and modify data in this
schema
3. You should be able to do SQL joins across multiple tables if necessary
4. You should be able to do aggregation to generate data reports

## Aggregations

Aggregation operations are like special type of *read* operation that lets
developers to group and simplify data out of database.

Aggregations are commonly used to answer data science questions such as
counting, doing statistics on the data in order to tell a *story* from data.
From the story, company can then make action based on data (data-driven-decision)
and profit.

## Web application architecture

![Web application basic architecture](imgs/webapp-architecture.png)

Nearly all web application derives from this simplest stack (front end, back
end and database). The reason being that these three layers are on different
machines – front end on the user computer (browser), back end on the server and
database on different server.

Front end presents the view layer to end users. It consists of the UI (user
interface) to allow user interactions with your **data** friendly. In example,
you may have a form allowing user to enter their name and comment with a button
to post their comment.

From Front end, your client side application (sometimes called front end
applications) sends *requests* to your server (back end) indicating the intent
to view/change data. Follow up with the comment example above, after clicking
on the button, browser sends a request to server showing the intent to create
a new comment.

Back end contains your business logics (validation, authentication, and logic
related to business domain). Usually business domain logic is being contained
in, what I called, data models. Continue with the comment example above, back end
server needs to start validating the data from request (e.g. if the name is
presented and/or if the comment is too long). Some business logic may be added
from above and say comment may link to other comment by specific syntax like `@`
sign and what not.

With the data models from the back end, database is to store those data models
in most efficient way. Moreover, database is considered to be a single truth of
the business. In other word, all software business now relies a lot on the
database.

Going back to comment example, database may have a DDL like below:

```sql
CREATE TABLE comments (
    id int auto_increment not null,
    name varchar(255) not null,
    comment text not null
);
```

And have some queries like:

```sql
-- to create a new comment
INSERT comments (name, comment)
VALUES (?, ?);

-- to read all comments
SELECT * FROM comments;
```

What we have learned so far is only within the database layer. And this is not
enough to build a stand along application just yet. However, you should be able
to start connecting dots to see where database layer might be used.

## Web application example

The simplest web application we can build today would be built from Node.js because
there are a lot of modules online we can reuse already.

Lets do some live coding example here!

## Final thoughts

Lastly, I hope you all enjoy this intro to database class. In the upcoming
classes, you will all be learning more about the back end programming. And
maybe you will all mostly only focus on the back end programming (Java).

My hope for the students is not to be limited within academic area. Look up
online and look for other areas that interests you (e.g. if you are interested
in the front end, look for leaning JavaScript yourself!).

You may find this reference to start learning:
https://github.com/kamranahmedse/developer-roadmap
