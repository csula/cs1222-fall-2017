# General Instructions for Labs

Before you start the lab, you will need to ensure your computer has both MySQL
server running as well as your MySQL client (either MySQL Cli, MySQL workbench
or SequalPro).

Your job is to answer every question on the laboratory notes.

And the format of answering those questions should all be in a SQL file.

For example, if the question asks you to list all artists in Artists table, your
answer might be something like below:

> A friendly reminder, label your query with comment is required

```sql
# Question 1: List all artists in Artists table
SELECT * FROM Artists;
```

Furthermore, if the question asks general question where you have to answer it
in a paragraph. Write this paragraph in comments. E.g.

> A quick note on each line of comment should start with `#`

```sql
/* 
Question 2:
Lorem ipsum dolor sit amet, consectetur adipisicing elit.
Nisi, sunt! Alias incidunt hic, odit obcaecati, debitis beatae culpa
molestiae ea pariatur minus fugiat rem consequuntur fuga cum. Ab repellendus, quasi!
*/
```

In summary, your submission should be one `.sql` file and nothing else. And
your comment in SQL file should provide enough context for grader to grade.

After you finish your laboratory, you may ask me to quick check your result in
class to ensure you got everything correct and submit your sql file on CSNS.

> Remember to submit your SQL file on CSNS!
