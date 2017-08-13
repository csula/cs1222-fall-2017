# Introduction to NoSQL Database

NoSQL database by definition is "next generation" type of database mostly
addressing some points: non-relational, distributed, open source and horizontal
scalable.

There are a couple NoSQL databases (where you can find the list here http://nosql-database.org/).
But we will be focusing on the MongoDB specifically based on its popularity in 
past few years.

## Why NoSQL?

Small to medium size company, like the company I work with, often uses MongoDB
as the starting point of the micro service. Why?

When building modern web application now, it's often that business requirement
changes in between development cycle and even change in a day or two.

MongoDB databases is designed to help with rapidly changing data types.

Please keep in mind that MongoDB is only within a type of NoSQL database, specifically
under document model database. For the class purose, we will not address other
type of databases.

> Don't just assume NoSQL = MongoDB. That is wrong.

Document model database like MongoDB stores the data in **documents**. And these
documents are typically use a structure like **JSON**. This format is very close
to how modern webapp develops.

In example, to store some data that will only be used by the front-end, you can
now simply store whatever data client side passes without any sort of schema definition
from the backend.

> Note that this type of storage without validation is considered to be ... dangerous.

Furthermore, in document storage, the notion of schema is very flexible: each
document can contain different fields. This flexibility is helpful for modeling
unstructured data. And it also makes the development easier to evolve application
in the development cycle, such as adding new fields.

In short, document model database are for general purpose and useful for wide
variety of applications due to the flexibility of the data modeling -- which we
will see in the following lectures.

You can read more on the comparison between NoSQL and Relational databases here -- 
https://www.mongodb.com/nosql-explained

## Install MongoDB

Now for the students who have laptop with you, you can follow the instruction here
to install MongoDB.

https://docs.mongodb.com/getting-started/shell/installation/

After you installed the MongoDB above, you should be able to verify from terminal
like below:

```sh
$ mongod
2016-11-09T22:47:40.000-0800 I CONTROL  [initandlisten] MongoDB starting : pid=91180 port=27017 dbpath=/data/db 64-bit host=Erics-MacBook-Pro-2.local
2016-11-09T22:47:40.000-0800 I CONTROL  [initandlisten] db version v3.2.4
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten] git version: e2ee9ffcf9f5a94fad76802e28cc978718bb7a30
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten] allocator: system
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten] modules: none
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten] build environment:
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten]     distarch: x86_64
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten]     target_arch: x86_64
2016-11-09T22:47:40.001-0800 I CONTROL  [initandlisten] options: {}
2016-11-09T22:47:40.001-0800 I -        [initandlisten] Detected data files in /data/db created by the 'mmapv1' storage engine, so setting the active storage engine to 'mmapv1'.
2016-11-09T22:47:40.012-0800 I JOURNAL  [initandlisten] journal dir=/data/db/journal
2016-11-09T22:47:40.012-0800 I JOURNAL  [initandlisten] recover : no journal files present, no recovery needed
```

## Import sample data

Download file from https://raw.githubusercontent.com/mongodb/docs-assets/primer-dataset/primer-dataset.json

And then run below command:

```sh
mongoimport --db test --collection restaurants --drop --file ~/downloads/primer-dataset.json
```

```sh
"C:\Program Files\MongoDB\Server\3.2\bin\mongoimport.exe" --db test --collection restaurants --drop --file C:\Users\IEUser\Downloads\primer-dataset.json
```

## Mongo shell commands

Once you finish the installation of MongoDB as above steps, you should also have
Mongo shell installed along with the MongoDB server.

You can start the shell by `mongo`.

> For windows user, look for `mongo.exe` under your MongoDB folder

## CRUD with Mongo shell

CRUD stands for Create, Read, Update and Delete. Often used to describe some
most basic functionality of an app.

In the following sections, we will be discussing the CRUD operations with Mongo
shell.

Before you start any of the CRUD command, you will need change your database (just
like mysql you have to `use` database).

```sh
use test;
```

### Common debugging commands

```sh
# to see all databases
# equals to `show databases;` in MySQL
show dbs; 

# to see all collections
# equals to `show tables;` in MySQL
show collections;
```

### To create and insert a document, you can follow below command.

```javascript
db.restaurants.insert(
   {
      "address" : {
         "street" : "2 Avenue",
         "zipcode" : "10075",
         "building" : "1480",
         "coord" : [ -73.9557413, 40.7720266 ]
      },
      "borough" : "Manhattan",
      "cuisine" : "Italian",
      "grades" : [
         {
            "date" : ISODate("2014-10-01T00:00:00Z"),
            "grade" : "A",
            "score" : 11
         },
         {
            "date" : ISODate("2014-01-16T00:00:00Z"),
            "grade" : "B",
            "score" : 17
         }
      ],
      "name" : "Vella",
      "restaurant_id" : "41704620"
   }
);
```

### To read or find a document, you can follow the below command.

```javascript
// to find all documents under `restaurants`
db.restaurants.find()

// to find a specific restaurants with a column
db.restaurants.find( { "borough": "Manhattan" } )

// or you can even find a field in an embed document 
db.restaurants.find( { "address.zipcode": "10075" } )

// query against a field of an array
db.restaurants.find( { "grades.grade": "B" } )

// if you want to use grater sign
db.restaurants.find( { "grades.score": { $gt: 30 } } )

// or less sign
db.restaurants.find( { "grades.score": { $lt: 10 } } )

// what about logical operation like and and or?
// AND
db.restaurants.find( { "cuisine": "Italian", "address.zipcode": "10075" } )

// OR
db.restaurants.find(
   { $or: [ { "cuisine": "Italian" }, { "address.zipcode": "10075" } ] }
)

// sorting
db.restaurants.find().sort( { "borough": 1, "address.zipcode": 1 } )
```

### To update a document

```javascript
// update takes a query object first and then the fields to update
db.restaurants.update(
    { "name" : "Juni" },
    {
      $set: { "cuisine": "American (New)" },
      $currentDate: { "lastModified": true }
    }
)

// can also update embed document
db.restaurants.update(
  { "restaurant_id" : "41156888" },
  { $set: { "address.street": "East 31st Street" } }
)

// update multiple documents at once
db.restaurants.update(
  { "address.zipcode": "10016", cuisine: "Other" },
  {
    $set: { cuisine: "Category To Be Determined" },
    $currentDate: { "lastModified": true }
  },
  { multi: true}
)

// remember if you don't specify $set then it will replace the whole document
db.restaurants.update(
   { "restaurant_id" : "41704620" },
   {
     "name" : "Vella 2",
     "address" : {
              "coord" : [ -73.9557413, 40.7720266 ],
              "building" : "1480",
              "street" : "2 Avenue",
              "zipcode" : "10075"
     }
   }
)
```

### Delete documents

```javascript
// remove all documents meeting this condition
db.restaurants.remove( { "borough": "Manhattan" } )

// to be on the safe side you can use `justOne` to remove a document at once
db.restaurants.remove( { "borough": "Queens" }, { justOne: true } )

// if you want to remove the entire documents
db.restaurants.remove( { } )

// or you can drop the whole document
db.restaurants.drop()
```

## SQL to MongoDB

Reference: https://docs.mongodb.com/manual/reference/sql-comparison/

Terminology and concept table:

| SQL Terms/Concepts | MongoDB Terms/Concepts |
| :-- | :-- |
| database | database |
| table | collection |
| row | document |
| column | field |
| index | index |
| table joins | embedded documents and linking |

Create and Alter

| SQL statements | MongoDB statements |
| :-- | :-- |
| `CREATE TABLE users ( ... )` | `db.users.insert({ ... })` |
| `ALTER TABLE users ADD column DATETIME` | `db.users.update({}, { $set: { column: new Date() } }, { multi: true })` |

## Reference

API documentation: https://docs.mongodb.com/manual/crud/
