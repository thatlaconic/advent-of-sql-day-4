SELECT *
FROM toy_production ;

SELECT toy_id, UNNEST(previous_tags), UNNEST(new_tags)
FROM toy_production;

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