# SQL Execution Plan

The goal for this article is to explain the SQL behind the scene based on the
execution plan order.

## Execution order:

* FROM clause
* WHERE clause
* SELECT clause
* GROUP BY clause
* HAVING clause
* ORDER BY clause

SELECT Name, AVG(Grade)
FROM Student_Grades
WHERE Grade > 80
GROUP BY Name
HAVING AVG(Grade) > 92;

1. FROM Clause

```
# Student_Grades

ID     | Name      | Grade
-------|-----------|-----------
1      | Eric      | 89
2      | John      | 94
3      | Eve       | 100
4      | Eric      | 95
5      | John      | 78
```

2. WHERE Clause

```
# WHERE Grade > 80;
ID     | Name      | Grade
-------|-----------|-----------
1      | Eric      | 89
2      | John      | 94
3      | Eve       | 100
4      | Eric      | 95
```

3. SELECT Clause

```
# SELECT Name, Grade
Name      | AVG(Grade)
----------|-----------
Eric      | 89
John      | 94
Eve       | 100
Eric      | 95
```

4. GROUP BY clause

```
# GROUP BY Name
Name      | Grade List  | AVG(Grade)
----------|-------------|-------------
Eric      | [89, 95]    | (89+95)/2
John      | [94]        | 94/1
Eve       | [100]       | 100/1
```

5. HAVING clause

```
# HAVING AVG(Grade) > 92
Name      | Grade List  | AVG(Grade)
----------|-------------|-------------
John      | [94]        | 94
Eve       | [100]       | 100
```


