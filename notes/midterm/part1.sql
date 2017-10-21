# 1. List the TitleID, Track Title of all tracks whose Track Number is 3 and are at least 250 seconds long.
SELECT TitleID, TrackTitle
FROM Tracks
WHERE TrackNum = 3 AND LengthSeconds > 250;

# 2. List the Title and Genre and UPC of all Titles whose second leftmost digit of UPC is '2'.
SELECT Title, Genre, UPC
FROM Titles
WHERE UPC LIKE '_2%';

# 3. List the number of tracks and the average length under title id 4.
SELECT COUNT(*) AS 'Number of tracks', AVG(LengthSeconds) AS 'The average length'
FROM Tracks
WHERE TitleID = 4;

# 4. Find the name(s) of the artist(s) that have more than one members related to him/her (related means artists and members are connected through XrefArtistsMembers Table)
SELECT ArtistName
FROM Artists a 
INNER JOIN XrefArtistsMembers x
USING (ArtistID)
GROUP BY ArtistName
HAVING COUNT(*) > 1;

# 5. List the following information of all members: the first name, the position of the first occurrence of 'e' within the first name, the last name, the position of the first occurrence of 'ar' within the last name. Use proper column names.
SELECT FirstName, 
    LastName,
    LOCATE('e', FirstName) AS 'Occurence of e in FirstName',
    LOCATE('ar', LastName) AS 'Occurence of ar in LastName'
FROM Members;

# 6. Find the track title of the longest track, the CD title of it and the artist's name.
SELECT TrackTitle, Title, ArtistName
FROM Tracks
INNER JOIN Titles
USING(TitleID)
INNER JOIN Artists
USING(ArtistID)
WHERE LengthSeconds = (
    SELECT MAX(LengthSeconds)
    FROM Tracks
);

# 7. List the artist name of all artists with ' ' anywhere in the artist's name.
SELECT ArtistName
FROM Artists
WHERE ArtistName LIKE '% %';

# 8. List the number of tracks and the total length of the tracks with length longer than 3 minutes.
SELECT COUNT(*) AS 'Number of tracks', SUM(LengthSeconds) AS 'Total length'
FROM Tracks
WHERE LengthSeconds > (60 * 3);

# 9. For each member, list the member id, area code, and the phone number without the area code.
SELECT MemberID, 
    LEFT(HomePhone, 3) AS 'Area code', 
    SUBSTRING(HomePhone, 4) AS 'Phone number without area code'
FROM Members;

# 10. List the member names in the form `{first initial}{period}{space}{last name}`, e.g. R. Alvarez. Order the results first by last name, then by first name. Only list those member who have both a first name and a last name in the database.
SELECT CONCAT(
    LEFT(FirstName, 1),
    '. ',
    LastName
) AS 'Name'
FROM Members
WHERE FirstName IS NOT NULL AND LastName IS NOT NULL AND
FirstName != '' AND LastName != ''
ORDER BY LastName, FirstName;
