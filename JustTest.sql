-- NAME순으로 정렬하고 NAME이 같다면 DATETIME이 늦은 순으로 정렬
SELECT NAME, ANIMAL_ID, DATETIME
FROM ANIMAL_INS
ORDER BY NAME, DATETIME DESC;

-- UNION 중첩
SELECT C0L1, COL2, COUNT(*) AS CNT
FROM (SELECT COL1, COL2
FROM TBL1
UNION ALL
SELECT COL1, COL2
FROM TBL2
UNION
SELECT COL1, COL2
FROM TBL1)
GROUP BY COL1, COL2；

-- DATETIME에서 DATE로 형 변환ANIMAL_INS 
-- 테이블에 등록된 모든 레코드에 대해, 
-- 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 
-- SQL문을 작성해주세요. 이때 결과는 아이디 순으로 조회
-- 해야 합니다.
SELECT ANIMAL_ID, NAME, 
DATE_FORMAT(DATETIME, '%Y-%m-%d') AS 날짜 
FROM ANIMAL_INS
