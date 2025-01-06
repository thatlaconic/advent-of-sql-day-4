# [The Great Toy Tag Migration of 2024](https://adventofsql.com/challenges/4)

## Description
During the annual toy database upgrade, something went terribly wrong with the magical toy-tracking system. The enchanted database that keeps track of all toy descriptions and magical properties had undergone a massive update, changing how toys were tagged and categorized.

Head Elf Database Administrator (HEDA) Pixelspring discovered that while they still had all the previous toy tags and the new ones, they desperately needed to understand what exactly changed during the upgrade. Some toys gained new magical properties, others lost their old enchantments, and some maintained their original charm.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-4/blob/main/advent_of_sql_day_4.sql)

Help the elves analyze toy tags by finding:

* New tags that weren't in previous_tags (call this added_tags)
* Tags that appear in both previous and new tags (call this unchanged_tags)
* Tags that were removed (call this removed_tags)
* For each toy, return toy_name and these three categories as arrays.

Find the toy with the most added tags, there is only 1.
Remember to handle cases where the array is empty, their output should be 0.
  
## Dataset
This dataset contains 1 table with 4 columns and 5000 rows. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM toy_production ;
```
**output**
![](https://github.com/thatlaconic/advent-of-sql-day-4/blob/main/toy_production.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-4/blob/main/advent_answer_day4.sql)

**input**
```sql
SELECT toy_id, 
	toy_name,
    (SELECT COUNT(*)
    FROM (
        SELECT UNNEST(new_tags)
        EXCEPT
        SELECT UNNEST(previous_tags)) a) AS added,
    (SELECT COUNT(*)
    FROM (
        SELECT UNNEST(previous_tags)
        INTERSECT
        SELECT UNNEST(new_tags)) a) AS unchanged,
    (SELECT COUNT(*)
    FROM (
        SELECT UNNEST(previous_tags)
        EXCEPT
        SELECT UNNEST(new_tags)) a) AS removed
FROM toy_production
ORDER BY added DESC
LIMIT 1;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-4/blob/main/day4_answer.PNG)




