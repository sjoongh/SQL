-- NAME순으로 정렬하고 NAME이 같다면 DATETIME이 늦은 순으로 정렬
SELECT NAME, ANIMAL_ID, DATETIME
FROM ANIMAL_INS
ORDER BY NAME, DATETIME DESC;