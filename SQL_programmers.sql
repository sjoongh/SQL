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

--Mission 16
-- TO_CHAR로 HH24=24시간을 표현, MM60=60분
-- 해당 테이블 열을 전부 COUNT
-- WHERE ... BETWEEN 09 AND 19로 조건 걸어줌
-- SELECT에 GROUP BY문법(COUNT)을 사용했으므로 DATETIME을 기준으로 묶어줌
-- AES정렬
SELECT TO_CHAR(DATETIME, 'HH24') AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
WHERE TO_CHAR(DATETIME, 'HH24') BETWEEN 09 AND 19
GROUP BY TO_CHAR(DATETIME, 'HH24')
ORDER BY TO_CHAR(DATETIME, 'HH24');

--Mission 17
SELECT ANIMAL_TYPE, NVL(NAME,'No name') AS NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

--Mission 18
SELECT ANIMAL_ID, NAME, TO_CHAR(DATETIME, 'YYYY-MM-DD') AS 날짜
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

--Mission 19
SELECT ANIMAL_ID,NAME, CASE WHEN SEX_UPON_INTAKE LIKE '%Neutered%' THEN 'O' WHEN SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O' ELSE 'X' END AS 중성화 
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID;

--Mission 20
SELECT b.ANIMAL_ID, b.NAME
FROM ANIMAL_INS a
RIGHT JOIN ANIMAL_OUTS b 
ON a.ANIMAL_ID = b.ANIMAL_ID
WHERE a.ANIMAL_ID IS NULL
ORDER BY ANIMAL_ID;

--Mission 21
select emp.ename,emp.empno,dept.dname,dept.deptno
from emp, dept
where emp.deptno = dept.deptno;

--Mission 22
SELECT ANIMAL_ID, NAME,
CASE WHEN SEX_UPON_INTAKE
LIKE "%Neutered%" OR SEX_UPON_INTAKE
LIKE "%Spayed%" THEN "O" ELSE 'X' END AS "중성화"
FROM ANIMAL_INS

--Mission 23
SELECT B.ANIMAL_ID, B.NAME
FROM ANIMAL_INS A, ANIMAL_OUTS B
WHERE A.DATETIME > B.DATETIME
ORDER BY A.DATETIME;

--Mission 24
select empno, ename, job, hiredate, sal 
from emp 
where job=(select job from emp where empno=7521) 
and 
sal>(select sal from emp where empno=7934);

--Mission 25
SELECT ANIMAL_ID, NAME, 
(CASE 
 WHEN SEX_UPON_INTAKE LIKE '%Neutered%' THEN 'O'
 WHEN SEX_UPON_INTAKE LIKE '%Spayed%' THEN 'O'
 ELSE 'X'
 END) AS 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

--Mission 26
-- 동물중 오류가 발생한 동물만 찾아야 하므로 ANIMAL ID가 같은 것들 중 보호일이 입양일보다 빠른것을 찾음
SELECT B.ANIMAL_ID, B.NAME
FROM ANIMAL_INS A, ANIMAL_OUTS B
WHERE A.ANIMAL_ID = B.ANIMAL_ID AND A.DATETIME > B.DATETIME
ORDER BY A.DATETIME;

--Mission 27
select deptno, count(*)
from emp
group by deptno
having count(deptno) =
(select max(count(*))
from emp
group by deptno)

--Mission 28
select ename, hiredate, deptno
from emp
where hiredate < to_date('05/01/01', 'YY/MM/DD') order by hiredate;

-- Mission 29
select ename, empno, dname, dept.deptno
from emp join dept
on emp.deptno = dept.deptno;

-- Mission 30
-- 부서가 30이고 급여가 1500이상인 사원의 이름, 급여, 부서명, 부서번호 출력
select emp.ename, emp.sal, dept.dname, dept.deptno
from emp join dept on emp.deptno = dept.deptno
where emp.deptno = 30
and sal >= 1500;

--Mission 31
SELECT ANIMAL_TYPE, COUNT(*) AS COUNT FROM ANIMAL_INS GROUP BY ANIMAL_TYPE ORDER BY ANIMAL_TYPE

--Mission 32
select e.NAME as 사원명, d.NAME as 부서
from S_DEPT d, S_EMP e, S_REGION r
where d.REGION_ID = r.ID and 
e.DEPT_ID = d.ID and r.NAME = '서울특별시';
