-------------
-- SUBQUERY
------------
-- 하나의 질의문 안에 다른 질의문을 포함하는 형태
-- 전체 사원 중, 급여의 중앙값보다 많이 받는 사원

-- 1. 급여의 중앙값?
SELECT MEDIAN(salary) FROM employees; -- 6200
-- 2. 6200보다 많이 받는 사원 쿼리
SELECT first_name, salary FROM employees WHERE salary > 6200;

-- 3. 두 쿼리를 합친다
SELECT first_name, salary FROM employees
WHERE salary > (SELECT MEDIAN(salary) FROM employees);

-- Den 보다 늦게 입사한 사원들
-- 1. Den 입사일 쿼리
SELECT hire_date FROM employees WHERE first_name = 'Den'; -- 02/12/07
-- 2. 특정 날짜 이후 입사한 사원 쿼리
SELECT first_name, hire_date FROM employees WHERE hire_date >= '02/12/07';
-- 3. 두 쿼리를 합친다.
SELECT first_name, hire_54date FROM employees WHERE hire_date >= 
(SELECT hire_date FROM employees WHERE first_name = 'Den');

--다중행 서브 쿼리
-- 서브 쿼리의 결과 레코드가 둘 이상이 나올 때는 단일행 연산자를 사용할 수 없다
-- IN, ANY, ALL, EXISTS 등 집합 연산자를 활용
SELECT salary FROM employees WHERE department_id = 110; -- 2 ROW

SELECT first_name, salary FROM employees
WHERE salary = (SELECT salary FROM employees WHERE department_id = 110); -- ERROR

--결과가 다중행이면 집합 연산자를 사용
-- salary = 120008 OR salary = 8300
SELECT first_name, salary FROM employees
WHERE salary IN (SELECT salary FROM employees WHERE department_id = 110);

-- ALL(AND)
-- salary > 12008 AND salary > 8300
SELECT first_name, salary FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 110);

-- ANY(OR)
-- salary > 12008 OR salary > 8300
SELECT first_name, salary FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 110);

-- 각 부셔별로 최고 급여를 받는 사원을 출력
-- 1. 각 부서별 최고 급여 확인 쿼리
SELECT department_id, MAX(salary) FROM employees
GROUP BY department_id;

-- 2. 서브 쿼리의 결과 (department_id, MAX(salary))
SELECT department_id, employee_id, first_name, salary
FROM employees
WHERE (department_id, salary) 
IN (SELECT department_id, MAX(salary) FROM employees
GROUP BY department_id)
ORDER BY department_id;

-- 서브쿼리와 조인( 2.과 같은 결과
SELECT e.department_id, e.employee_id, e.first_name, e.salary
FROM employees e, (SELECT department_id, MAX(salary) s FROM employees
                            GROUP BY department_id) sal
WHERE e.department_id = sal.department_id AND e.salary = sal.s
ORDER BY e.department_id;