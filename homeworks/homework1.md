# Homework 1

You should see the "Homework 1" entry showing up on CSNS now. Please submit one
`homework1.sql` there.

This is due **September 17th** midnight.

Study the Books database and create the following queries. (Note: you need to run Books.sql to create the tables)

1. View the table Publishers and design the queries:
  1. List all the information in the table.
  2. List the name of all the publishers in the table.
  3. List the all the information of publishers that are in California.

2. View the table Titles and design the queries
  1. List all the titles whose type is history.
  2. List the title name, sales and publication date of all the titles whose pub_id is 'P01'.

3. General
  1. List the title id and title name of all books whose type are psychology and are at least 300 pages long.
  2. List the title name of all books with 'my' anywhere in the title name.
  3. List the name of all history books that are published in 1999.
  4. List the first name, last name and zip code of all authors whose second leftmost digit of zip code is '4'.
    * The format of output is: `First Name Last Name Zip Code`
  5. List the city and the state of all authors without duplicates.

4. Aggregation & Joins
  1. List the number of books, the minimum price, maximum price and the average sales of history books.
    * The format of output is: `Number Min Price Max Price Average Sale`
  2. List the number of books and the average number of pages published by pub_id 01.
  3. List the number of books and the total sales of the books with price greater than $15.
  4. For each book type, list the the number of books and the average price. Sort the results by the number of books.
  5. For each book type, list the book type and the average number of pages in the books with price greater than $10 in each category, excluding the types where the average number of pages is less than 200. Sort the results by the average number of pages.


Good luck!
