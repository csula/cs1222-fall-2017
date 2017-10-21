# 11. List the author name as '{FirstName}{space}{LastName}' (e.g. Eric Liao) and address of any authors. Rename the attributes name, address as Author Name, Street Address.
SELECT CONCAT(au_fname, ' ', au_lname) AS 'Author Name',
Address AS 'Street Address'
FROM Authors;

# 12. Report author id and the number of titles for each authors
SELECT au_id, COUNT(*) AS 'Number of titles'
FROM Authors
INNER JOIN Title_Authors
USING (au_id)
GROUP BY au_id;

# 13. List all the information of titles that do not have a price.
SELECT *
FROM Titles
WHERE price IS NULL;

# 14. Report the number of Authors who are in CA.
SELECT COUNT(*) AS 'Number of authors'
FROM Authors
WHERE State = 'CA';

# 15. Report the type, average, smallest and largest price for each type with average price greater than 20. Use proper column alias.
SELECT type, AVG(price) AS 'Average', MIN(price) AS 'Smallest', MAX(price) AS 'Largest'
FROM Titles
GROUP BY type
HAVING AVG(price) > 20;

# 16. List the title name, type and pages of the longest book (count in pages) without using max(). (Hint: use a subquery and ALL)
SELECT title_name, type, pages
FROM Titles
WHERE pages IS NOT NULL AND pages >= ALL (
    SELECT pages
    FROM Titles
    WHERE pages IS NOT NULL
);

# 17. List unique name of publisher from California (CA) and their authors.
SELECT DISTINCT pub_name, au_fname, au_lname
FROM Publishers
LEFT JOIN Titles
USING (pub_id)
LEFT JOIN Title_Authors
USING (title_id)
LEFT JOIN Authors
USING (au_id)
WHERE Publishers.state = 'CA';

# 18. Report all the unique types from the titles table. Capitalize the first letter of each and the rest of the letters should be lower case.
SELECT DISTINCT CONCAT(UPPER(LEFT(type, 1)), LOWER(SUBSTRING(type, 2))) AS 'Type'
FROM Titles;

/* SELECT CONCAT(UPPER(LEFT(type, 1)), LOWER(SUBSTRING(type, 2))) AS 'Type' */
/* FROM Titles */
/* GROUP BY Type; */

# 19. Report the publisher name and the last word of each publisher name. Hint: the last word is the part that follows the space.
# only display the last word not the last two words
SELECT pub_name, TRIM(RIGHT(pub_name, LOCATE(' ', REVERSE(pub_name)))) AS 'Last word'
FROM Publishers;

# 20. List the names of books published by the 'Tenterhooks Press'.
SELECT title_name
FROM Titles
INNER JOIN Publishers
USING(pub_id)
WHERE pub_name = 'Tenterhooks Press';
