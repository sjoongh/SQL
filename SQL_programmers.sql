-- Mission 1
-- animal_id순으로 정렬
SELECT ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

-- Mission 2
-- datetime이 가장 늦은 animal select
SELECT MAX(DATETIME)
FROM ANIMAL_INS;

-- Mission 3
--name이 null인 animal select
SELECT ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NULL;

-- Mission 4
-- animal_id순으로 desc
SELECT NAME, DATETIME
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC;

--Mission 5
-- name이 null값이 아닌 animal select
SELECT ANIMAL_ID
FROM ANIMAL_INS
WHERE NAME IS NOT NULL;

-- Mission 6
-- intake_condition의 상태가 Sick인 animal select
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION LIKE '%Sick%';

-- Mission 7
-- intake_condition의 상태가 Aged가 아닌 animal select
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION NOT LIKE '%Aged%';

-- Mission 8

SELECT NAME, COUNT(NAME) AS COUNT
FROM ANIMAL_INS
GROUP BY NAME
WHERE COUNT(NAME) > 0;

--Mission 9
SELECT NAME, COUNT(NAME) AS COUNT
FROM ANIMAL_INS
GROUP BY NAME
HAVING COUNT(NAME) > 1
ORDER BY NAME;

--Mission 10
SELECT * FROM USER;

--Mission 11
SELECT MIN(DATETIME)
FROM ANIMAL_INS;

--Mission 12
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE ANIMAL_TYPE LIKE '%Dog%' AND (NAME LIKE '%El%' OR NAME LIKE '%el%')
ORDER BY NAME;

--Mission 13
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME LIKE '%Lucy%' OR NAME LIKE '%Pickle%' OR NAME LIKE '%Rogan%' OR NAME LIKE '%Sabrina%' OR NAME LIKE '%Mitty%' OR NAME LIKE '%Ella%'
ORDER BY ANIMAL_ID;

--Mission 14
SELECT COUNT(ANIMAL_ID)
FROM ANIMAL_INS;

--Mission 15
SELECT count(DISTINCT name)
FROM animal_ins
WHERE name IS NOT null;
