# Homework 3

Due at 11/19 midnight.

Reminder:

> In this homework, you will need to install MongoDB before you start any coding.
Please follow notes from [here](../notes/introduction-nosql.md) to install MongoDB.

Please finish the following questions in single `homework3.js` file.

Questions:

1. Insert an object containing `name` of 'Eric', `age` of 25 and `position` of 'lecturer' to `users` collection
2. Insert another user object containing `name` of 'Alice', `age` of 20, `position` of 'student' and `grade` of 84 to `users` collection
3. Insert another user object containing `name` of 'Bob', `age` of 21, `position` of 'student' and `grade` of 89 to `users` collection
4. Find all documents under `users` collection 
5. Find user name of 'Eric'
6. Find users of age between 20 to 23 (inclusive)
7. Update user object of 'Alice' to grade 95
8. Delete user 'Bob'
9. Update user of position 'student' to have a new field called `homeAddress` containing of follwing json:

        {
            street: '1234 Random st.',
            city: 'Los Angeles',
            state: 'CA'
        }
        
    * Hint: https://docs.mongodb.com/manual/reference/sql-comparison/#create-and-alter
    * Please assume there are more than one students to be updated
10. Drop users collection
