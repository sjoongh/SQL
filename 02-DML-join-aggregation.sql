------------
---- JOIN
------------

-- employees와 departments를 확인
DESC employees;
DESC departments;

-- 두 테이블로부터 모든 레코드를 추출: Cartision Prodect(Cross Join)
SELECT first_name, t1.department_id, t2.department_id, department_name
FROM employees t1, departments t2
ORDER BY first_name;

-- 테이블 조인을 위한 조건 부여할 수 있다. Simple JOIN(INNER JOIN에 포함)
SELECT first_name, t1.department_id, t2.department_name
FROM employees t1, departments t2
WHERE t1.department_id = t2.department_id;

-- 총 몇 명의 사원이 있는가?
SELECT COUNT(*) FROM employees; -- 107명

SELECT first_name, emp.department_id, department_name -- 얘는왜 별칭 x?
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id; -- 106명

-- department_id가 null인 사원?
SELECT * FROM employees
WHERE department_id IS NULL;

--USING: 조인할 컬럼을 명시
SELECT first_name, department_name
FROM employees JOIN departments USING(department_id);

-- ON: JOIN의 조건절
SELECT first_name, department_name
FROM employees emp JOIN departments dept ON (emp.department_id = dept.department_id);

-- Natual JOIN
-- 조건 명시 하지 않고, 같은 이름을 가진 컬럼으로 JOIN
SELECT first_name, department_name
FROM employees NATUAL JOIN departments;
-- 잘못된 쿼리 : Natual Join은 조건을 잘 확인!

-- Theta JOIN
-- Join 조건이 = 이 아닌 것

-----------
-- OUTER JOIN
-----------

-- 조건이 만족하는 짝이 없는 튜플도 NULL을 포함하여 결과를 출력
-- 모든 레코드를 출력할 테이블의 위치에 따라 (LEFT, RIGHT, FULL) OUTER JOIN으로 구분
-- ORACLE의 경우 NULL을 출력할 조건 쪽에 (+)를 명시

SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, department dept
WHERE emp.department_id = dept.department_id(+);

-- ANSI SQL
SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
                                ON emp.department_id = dept.department_id;

-- RIGHT OUTER JOIN : 짝이 없는 오른쪽 레코드도 null을 포함하여 출력
SELECT first_name, t1.department_id, t2.department_id, t2.department_name
FROM employees t1, departments t2
WHERE t1.department_id (+) = t2.department_id;

-- ANSI SQL
SELECT emp.first_name, emp.department_id,
    dept.department_id, dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
                            ON emp.department_id = dept.department_id;
                            
-- FULL OUTER JOIN
-- 양쪽 테이블 레코드 전부를 짝이 없어도 출력에 참여
-- oracle SQL (+) 방식으로는 불가
--SELECT emp.first_name, emp.department_id,
--    dept.department_id, dept.department_name
--FROM employees emp, departments dept
--WHERE emp.department_id (+) = dept.department_id (+)

-- ANSI SQL
SELECT emp.first_name, emp.department_id, dept.department_id, dept.department_name
FROM employees emp FULL OUTER JOIN departments dept 
ON emp.department_ds = dept.department_id;

--------------
-- SELF JOIN
--------------
-- 자기 자신과 JOIN
-- 자기 자신를 두 번 이상 호출 -> alias를 사용할 수 밖에 없는 JOIN
SELECT * FROM employees; -- 107명

-- 사원 정보, 매니저 이름을 함께 출력
-- 방법1.
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
FROM employees emp JOIN employees man
ON emp.manager_id = man.employee_id
ORDER BY emp.employee_id;

-- 방법 2.
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id(+) -- LEFT OUTER JOIN
ORDER BY emp.employee_id;

------------
--집계 함수
------------
-- 여러 레코드로부터 데이터를 수집, 하나의 결과 행을 반환

--count : 갯수 세기
select count(*) from employees; -- 특절 컬럼이 아닌 레코드의 갯수 센다.

select count (commission_pct) from employees; -- 해당 컬럼이 null이 아닌 갯수
select count (*) from employees
where commission_pct is not null; -- 위랑 같은 의미

-- sum : 합계
-- 급여의 합계
SELECT sum(salary) FROM employees;

-- avg: 평균
-- 급여의 평균
SELECT avg(salary) FROM employees;
-- avg 함수는 null 값은 집계에서 제외

-- 사원들의 평균 커미션 비율
SELECT avg(commission_pct) FROM employees; -- 22%
SELECT avg(nvl(commssion_pct, 0)) FROM employees; -- 7 %

-- min/max: 최소값, 최대값
SELECT MIN(salary), MAX(salary), AVG(salary), MEDIAN(salary)
FROM employees;

-- 오류 ? PDF다시보기
--SELECT deptno, dname, AVG(sal) 
--FROM emp
--GROUP BY deptno
--ORDER BY deptno;

-- 일반적 오류
SELECT department_id, AVG(salary)
FROM employees; -- ERROR

-- 수정 : 집계함수
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- 집계 함수를 사용한 SELECT 문의 컬럼 목록에는
-- GROUP by에 참여한 필드, 집계 함수만 올 수 있다.

-- 부서별 평균 급여를 출력,
-- 평균 급여가 7000 이상인 부서만 뽑아봅시다.
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary) >= 7000 -- WHERE절 실행시에는 아직 AVG가 집계되지 않음
GROUP BY department_id;
-- 집계함수 실행 이전에 WHERE 절을 검사하기 때문에
-- 집계 함수는 WHERE 절에서 사용할 수 없다

-- 집계 함수 실행 이후에 조건 검사하려면
--HAVING 절을 이용
SELECT department_id, ROUND (AVG(salary), 2)
FROM employees
GROUP BY department_id
        HAVING AVG(salary) >= 7000
ORDER BY department_id;


--------
-- 분석 함수
--------
-- ROLLUP
-- 그룹핑된 결과에 대한 상세 요약을 제공하는 기능
-- 일종의 ITEM Total
SELECT department_id,
    job_id,
    SUM(salary)
FROM employees
GROUP BU ROLLUP(department_id, job_id);