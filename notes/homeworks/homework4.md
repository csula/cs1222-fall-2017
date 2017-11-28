# Homework 4

Due at 12/02 midnight.

Reminder:

* In order to run any mongo shell command, you will need mongod to be started

In this homework, you will need to download the sample data set from 
[piching.csv under samples folder](https://raw.githubusercontent.com/csula/cs1222-fall-2017/master/samples/pitching.csv).

After download is completed, you will then need to import the sample piching.csv into your mongo database. 
To do so, you will need to run command like below:

```sh
# MacOS and Linux
mongoimport --db cs1222 --collection pitching --drop --type csv --headerline --file ~/Downloads/pitching.csv

# Windows
"C:\Program Files\MongoDB\Server\3.2\bin\mongoimport.exe" --db cs1222 --collection pitching --drop --type csv --headerline --file /Users/Eric/Downloads/pitching.csv
```

> Remember to change the download file path to your download path accordingly.

And after you imported the data above, you can then proceed with the following questions.

> Please submit your mongo scripts in a `homework4.js` file

Questions:

1. Find out the number of rows are in collection `pitching`
2. Count the number of records are in the `year` of **1872**
3. Count the number of records that is **between year of 1870 to 1880**
4. Which `player_id` has **the highest ipouts**?
5. Find **average year** in the whole pitching collection
6. Group the players by `year` and return the average `ipouts` per year
7. Find out the players with max `era` and min `era` per year
8. Find out the average, maximun and minimum `h` and `er` per `team_id`
9. Find out the average, maximun and minimum `h` and `er` per `team_id` and year
10. Order the `team_id` by the number of players in the team and group by `year`

> Hint: there might be some of the field with empty string, you will need to do a query to skip those empty strings.
