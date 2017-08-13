# Database-specific statements and functions

In this lesson, we will be learning some database specific functions to
do some advance stuff where SQL standard didn't define.

## Objectives

* Concatenate text fields
* Perform other kinds of text manipulation
* Perform date manipulation
* Learn how to test for and manipulate null values
* Convert data from one data type to another
* Write SQL with Access If and Choose logic

## Metrics

* Able to perform SQL functions in MySQL

### Concatenation

* Concatenation is the combination of two or more text values into one text value
* You can concatenate multiple fields or fields with constant text

Syntax:

```sql
SELECT CONCAT({column}, {column})
FROM {table};

# OR

SELECT CONCAT('Constant Text', {column})
FROM {table};

# OR

SELECT CONCAT_WS({seperator}, {column1}, {column2}, {column3}, ...)
FROM {table};
```

Examples:

```sql
# List the full name of each member
SELECT CONCAT_WS(' ', FirstName, LastName) AS FullName
FROM Members;

# Report the city, state, and zip of each member, formatted as City, State Zip.
SELECT CONCAT(City, ', ', Region, ' ', PostalCode) AS MailAddr
FROM Members;

# Report each lead source preceded by the text, 'source: ' along
# with a count of the number of artists leads from that source
SELECT CONCAT('Source: ', LeadSource) AS Source,
  COUNT(*) AS NumLead
FROM Artists
GROUP BY Source;
```

### Text functions in MySQL

| Function | Meaning |
| :------------- | :------------- |
| LENGTH(expression) | Returns the length in characters of the text |
| RIGHT(expression, length) | Returns text containing the specified number of characters from the right side of a text value |
| SUBSTRING(expression, start, length) | Returns any specified portion of a text value. Start specifies the first character position to include. Length specifies the number of characters to include. |
| LOCATE(searchText, text, start) | Returns position of first occurrence of one text expression within another. Expression is text searched for. Text is text searched. Start is optional, specifies position within Text to start search. If expression is not found, will return 0. |
| TRIM(expression), LTRIM(expression), RTRIM(expression) | Returns a copy of a text value without leading spaces (LTRIM), trailing spaces (RTRIM), or both leading and trailing spaces (TRIM). |
| UPPER(expression), LOWER(expression) | Returns a copy of a text value converted to uppercase (UPPER), or lowercase (LOWER) |
| LPAD(expression, num_char, pad_chars), RPAD(expression, num_char, pad_chars) | Makes a string a certain length (num_char) by adding a certain set of pad characters (pad_chars) to the left (LPAD) or right (RPAD) |

### Date manipulation

| Function | Meaning |
| :------------- | :------------- |
| NOW(), CURDATE(), CURTIME() | NOW() returns the current date and time. CURDATE() returns the current date. CURTIME() returns the current time. |
| DAYOFMONTH(expression), MONTH(expression), YEAR(expression) | DAYOFMONTH returns the day of month of specified date. MONTH returns a number between 1 and 12, representing the month of a specified date. YEAR returns the year of a specified date. |
| ADDDATE(expression, interval expression type), SUBDATE(expression, interval expression type) | Adds or subtracts a specified time interval to a date or time. Interval is the literal word interval. Expression is the number of those date intervals you want to add or subtract. Type indicates the interval size. The types include: second, minute, hour, day, month, year, minute_second, hour_minute, day_hour, year_month, hour_second, day_minute, and day_second |
| TO_DAYS(date) | Given a date, return a daynumber. To subtract two dates use TO_DAYS on each and subtract the daynumbers. |
| LAST_DAY(date) | Returns the last day of the month for a given date. |

### Data type conversions

Most database systems can implicitly (automatically) convert between some data types.

Some data type conversions may not be handled implicitly, there are explicit data type conversion functions. (aka. casting type)

Syntax in MySQL:

```sql
SELECT CAST({expression} AS {data type});
SELECT CONVERT({data type}, {expression});
SELECT TRUNCATE({number}, {num_decimal_places});

# data type must be one of the following: binary, date, datetime, singed {integer}, time, unsigned {integer}
```

### Handling nulls in MySQL

You can use ISNULL() function to check if certain data is null. In addition to check if the data is null, you can also specified default value by adding default value to second parameter.

Example syntax in MySQL:

```sql
#  List the web address of each artist and whether or not the web address is null
SELECT WebAddress, ISNULL(WebAddress) AS IS_IT_NULL
FROM Artists;

# List the web address of each artist. If the web address is null, list 'no website'
SELECT IFNULL(WebAddress, 'No website')
FROM Artists;
```

### Miscellaneous functions

Syntax:

```sql
SELECT GREATEST(number1, number2, number3);
SELECT LEAST(number1, number2, number3);
FORMAT(number, num_decimal_places);
```

Examples

```sql
# List the largest of the following numbers: 3, 5, 7, and 9
SELECT GREATEST(3, 5, 7, 9);

# List any tracks that lack either an MP3 or Real Audio recording.
SELECT TrackTitle
FROM Tracks
WHERE LEAST(MP3, RealAud) = 0;

# Report the name and yearly base of each salesperson formatted with comma and two decimal places
SELECT CONCAT(FirstName, LastName), FORMAT(Base * 52, 2)
FROM SalesPeople;
```

### Formatting date

In additional to format number, you can also formate date using `DATE_FORMAT` function!

```sql
SELECT ArtistName, DATE_FORMAT(entrydate, '%m-%d-%y') AS Entered
FROM Artists;
```

### Control flow

Syntax:

```sql
# switch case
SELECT CASE {value}
  WHEN {condition1} THEN {result}
  WHEN {condition2} THEN {result}
  ELSE {else_result}
END;

# if statement
SELECT IF({condition}, {true_result}, {false_result});
```

Example:

```sql
SELECT CASE 1
  WHEN 1 THEN 'one'
  WHEN 0 THEN 'zero'
  ELSE 'NaN'
END;  

SELECT IF(1 < 2, '1 is less than 2', 'wtf');
```
