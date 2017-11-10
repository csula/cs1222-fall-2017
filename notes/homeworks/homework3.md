# Homework 3

Due at 11/18 midnight.

Reminder:

> In this homework, you will need to install MongoDB before you start any coding.
> Please follow notes from [here](../notes/introduction-nosql.md) to install MongoDB.

Please finish the following questions in single `homework3.js` file.

Questions:

> For each of the following question, please use `db.{collectionName}.find({query}).toArray()` to test result
> In example, `db.users.find().toArray()` for first three questions

1. Insert an object containing `name` of "Eric", `age` of 25 and `position` of "lecturer" to `users` collection
2. Insert another user object containing `name` of "Alice", `age` of 20, `position` of "student" and `grade` of 84 to `users` collection
3. Insert another user object containing `name` of "Bob", `age` of 21, `position` of "student" and `grade` of 89 to `users` collection
4. Find users of age between 20 to 23 (inclusive)
    * hint: at the end of find(), please append `toArray()` for testing
5. Delete user bob
    * use `db.users.find().toArray()` to test result
6. Update user object of 'Alice' to grade 95
    * use `db.users.find().toArray()` to test result
7. Update Eric to have a new field called homeAddress containing of following json:

    ```
    {
        street: '1234 Random st.',
        city: 'Los Angeles',
        state: 'CA'
    }
    ```

    * Find user's homeAddress to test result

> From question 8 to 10, you will be using primer-dataset.json example from the course note in "restaurants" collection

8. Find restaurant ids that is in zipcode "11215" and has score of greater than 50
9. Update above restaurants to have additional attribute called `"featured": true`
    * use the same search query as above to test result including the featured field
10. Delete restaurants in zipcode "11205" with score of higher than 40
    * find all the restaurants in zipcode "11205" with restaurant id sorted in ascending to test result
