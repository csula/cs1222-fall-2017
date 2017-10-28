# Exercise 3

## Story

We want to introduce a new *custom play list* feature for our customers where
they can customize the tracks all together as any way they want. To do so, we will
have to create a new table to track play list to tracks relationship.

1. Create `PlayLists` table with fields of `PlayListID`(int), `PlayListName` (varchar(255)), `Description`(text)
    * Primary ID should be on `PlayListID`
    * None of the fields should be allowed to have null
    * Use `DESCRIBE` to test result
2. Create `PlayListSongs` table with fields of `PlayListID`, `TitleID`, `TrackNum`, `NumberOfPlays`(int), `SongOrder`(int)
    * None of the fields should be allowed to have null
    * Default for `NumberOfPlays` and `SongOrder` should be zero
    * Use `DESCRIBE` to test result
3. Add `PlayListID` as foreign key from `PlayListSongs` table to `PlayList` table
    * Use `DESCRIBE` to test result
4. Add `TitleID` and `TrackNum` as foreign key from `PlayListSongs` table to `Tracks` table
    * hint: you may need to add primary key to Tracks table
    * hint: remember foreign key constraints -- data type has to be the same
    * Use `DESCRIBE` to test result
5. Insert sample records to `PlayLists` table like below:
    * hint: use `SELECT * FROM PlayLists` to test result
    
    | PlayListID | PlayListName | Description |
    | :-- | :-- | :-- |
    | 1 | My Custom Play List | Description |
    | 2 | Very second play list | Hello songs |
6. Insert sample records to `PlayListSongs` table like below:
    * hint: use `SELECT * FROM PlayLists` to test result
    
    | PlayListID | TitleID | TrackNum | NumberOfPlays | SongOrder |
    | :-- | :-- | :-- | :-- | :-- |
    | 1 | 1 | 1 | 9 | 1 |
    | 1 | 3 | 2 | 2 | 4 |
    | 1 | 3 | 5 | 5 | 3 |
    | 1 | 5 | 3 | 1 | 2 |
    | 1 | 5 | 9 | 99 | 5 |
    | 2 | 6 | 1 | 500 | 4 |
    | 2 | 6 | 2 | 201 | 3 |
    | 2 | 6 | 3 | 999 | 1 |
    | 2 | 1 | 4 | 42 | 2 |
7. `Hottie` (TitleID 1 and TrackNum 1 in Tracks table) is being requested to be taken down. We have to delete this track from title id 1. Design the deletion query.
    * hint: If you didn't set the `Cascading update & delete`, this is the time to go back to earlier table creation statement to do so
    * hint: use `SELECT * FROM PlayListSongs` to test result
8. We soon realized that int type for `NumberOfPlays` is too small for our scale. Design a query to update `NumberOfPlays` from int type to bigint type
    * hint: use `DESCRIBE` to test result
9. We no longer wants to support description field from `PlayLists` table. Design a query to delete `Description` field from `PlayLists` table
    * hint: use `DESCRIBE` to test result
10. Create a view called `PlayListGenres` that displays `PlayLists` and its Genre count containing fields of `PlayListID`, `Genre`, `Count`
    * hint, you will need to do Joins from `PlayList` all the way to `Genre`
    * hint: use `SELECT * FROM PlayListGenres` to test result

Github page reference: https://github.com/csula/cs1222-fall-2017/blob/master/notes/labs/exercise4.md

Use http://104.131.155.18:8000/exercise-3 for testing
