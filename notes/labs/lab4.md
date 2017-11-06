# Lab 4

Total points: 10pts (each problem 1 point)

Due at the end of class, please raise your hand when you are finished and we can go over your implementation together.

> I may ask a few question on your implementation to further clarify your understanding


## Afternoon Section (12:00 - 16:30)

Story:

We want to start tracking artist to studio contract now and thus we have to introduce a couple new tables.

In addition, we also want to allow artist to create multiple personal pages. Currently we only store a webaddress under artist table. Maybe a redesign on the Artist table is also required?

> Note that if you need any additional steps to answer questions such as adding primary keys. Please list them under the question as part of your answer.

1. Create `ArtistStudioContract` Table containing ArtistID, StudioID, and a ContractDate (Date type).
    * Use `DESCRIBE` to test result
2. Change `ArtistStudioContract` table from question 1 to have foreign keys of ArtistID to Artists table and StudioID to Studios table
    * Use `DESCRIBE` to test result
3. Add SalesID to `ArtistStudioContract` table with foreign key to SalesPeople table
    * hint: you may need to update SalesPeople table
    * Use `DESCRIBE` to test result
4. Add a record to `ArtistStudioContract` table indicating artist id 1 signed up contract sales person id 3 for studio id 2 and artist id 5 signed up with sales person id 1 with studio id 3 while both having contract date being Artist's entry date
   You should have records like below:
    
      ```
      ArtistID | StudioID | SalesID | ContractDate
      1        | 2        | 3       | ...
      5        | 3        | 1       | ...
      ```
    
    * Use `SELECT` to test result
5. Artist ID 1 decide to leave the company, delete Artist id 1 from the Artist table
    * Hint: remember we still have the foreign keys set up from ArtistStudioContract table, if you have to do anything in the table, please list them as well
    * Use `SELECT * FROM ArtistStudioContract` to test result
6. Create `ArtistPages` table containing ArtistID (with ArtistID having foreign key to Artist table) and WebAddress (as same data type from Artists table)
    * Use `DESCRIBE` to test result
7. Copy ArtistID and WebAddress from Artists table to ArtistPages table
    * Use `SELECT` to test result
8. Delete the column `WebAddress` from the ArtistPages table
    * Use `DESCRIBE` to test result
9. Artist id 5 decide to be a developer and decide to remove himself/herself out of Artists table. Delete Artist id 5 from artists table
    * Hint: remember we still have the foreign keys set up from earlier table, if you have to do anything in the table, please list them as well
    * Use `SELECT * FROM ArtistPages` to test result
10. Create a view called `ArtistNamePages` containing ArtistID, ArtistName, Country and WebAddress from `Artists` table
    * USE `SELECT` to test result

http://104.131.155.18:8000/lab-4_1

## Evening Section (16:30 - 20:30)

Story:

We want to start tracking sales of the Titles now for us to increase sales salary.

To do this, we will need to add a new table to track sales per transaction per title.

Once we created the trasaction table, we also want to create a webaddress for the title to further increase more sales.

> Note that if you need any additional steps to answer questions such as adding primary key. Please list them under the question as part of your answer.

1. Create table `TitleSales` containing `TitleID`, `Sales` (float type), `SalesID`
    * Use `DESCRIBE` to test result
2. Change `TitleSales` table from question 1 to have foreign key of SalesID to SalesPeople table and foreign key of TitleID Titles table
    * Use `DESCRIBE` to test result
3. Add index to `TitleID` and `SalesID` to `TitleSales` table
    * Use `SHOW INDEX FROM TitleSales` to test result
4. Add a random sale values to `TitleSales` table of `TitleID 1 and SalesID 2` and `TitleID 3 and SalesID 3`
    * Hint: You can use `Rand(int)` function to get random value
        * Usually, we can simply use `rand` function as it is, for the testing purpose, please give a seed value to rand function as their SalesID id
    * Your table should look something like below:

        ```
        TitleID | SalesID | Sales
        1       | 2       | 0.521432
        3       | 3       | 0.821381
        ```
5. TitleID 1 is now being requested to be take down. You have to remove this TitleID 1 from Titles table.
    * Hint: remember we setup foreign keys from the `TitleSales` table, if you have to do anything in any other table other than Titles table. Please list them as well.
    * Use `SELECT * FROM TitleSales` to test result
6. Create `WebTitleSales` table containing `TitleID`, `Sales`, `WebAddress` (with TitleID being foreign key to Titles table)
    * Use `DESCRIBE` to test result
7. For every title in Titles, add them to `WebTitleSales` table with same TitleID, random sales, and WebAddress being www.{title (`replace` spaces with "_" (underline))}.lyrics.com
    * Hint: you can replace by replace function -- http://dev.mysql.com/doc/refman/5.7/en/string-functions.html#function_replace
    * Hint: You can use `Rand(int)` function to get random value
        * Usually, we can simply use `rand` function as it is, for the testing purpose, please give a seed value to rand function as their TitleID
    * Use `SELECT` to test result
    * Your table should look something like below:

        ```
        TitleID | WebAddress                        | Sales
        1       | www.Meet_the_Neurotics.lyrics.com | 0.645212
        ...
        ```
8. Add unique constraint to `WebAddress` in `WebTitleSales` table
    * Use `DESCRIBE` to test result
9. TitleID 5 is now also being requested to take down. You have to remove TitleID 5 from Titles table.
    * Hint: remember we setup foreign keys from the `TitleSales` table, if you have to do anything in any other table other than Titles table. Please list them as well.
    * Use `SELECT * FROM WebTitleSales` to test result
10. Create a view called `TitleTotalSales` containing TitleID, Sales, SalesType (being either personal or web), Identifier (either SalesID or WebAddress).
    * Hint: you will need to use `UNION` to combine two tables
    * Use `SELECT` to test result
    
        ```
        TitleID | Sales    | SalesType | Identifier
        1       | 0.645212 | web       | www.Meet_the_Neurotics.lyrics.com
        ```


http://104.131.155.18:8000/lab-4_2
