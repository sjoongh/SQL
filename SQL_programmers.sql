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

