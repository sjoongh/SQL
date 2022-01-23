-- 연습 문제:
-- 직원의 이름, 부서, 팀 출력
-- 부서 코드: 10 ~ 30 -> A-group
-- 부서 코드: 40 ~ 50 -> B-group
-- 부서 코드: 60 ~ 100 -> C-group
-- 나머지 : REMAINDER
SELECT first_name, department_id,
    (CASE WHEN (department_id >= 10 AND department_id <= 30)  THEN 'A-group'
            WHEN (department_id >= 40 AND department_id <= 50)  THEN 'B-group'
            WHEN (department_id >= 60 AND department_id <= 100)  THEN 'C-group'
            ELSE 'REMAINDER' 
    END) team
FROM employees;

--문제 1. 
--전체직원의 다음 정보를 조회하세요. 정렬은 입사일(hire_date)의 올림차순(ASC)으로 가장 선
--임부터 출력이 되도록 하세요. 이름(first_name last_name), 월급(salary), 전화번호
--(phone_number), 입사일(hire_date) 순서이고 “이름”, “월급”, “전화번호”, “입사일” 로 컬럼이름을 대체해 보세요.
SELECT first_name || ' ' || last_name as 이름,
    salary 월급, 
    phone_number 전화번호, 
    hire_date 입사일
FROM employees
ORDER BY hire_date;

--문제2.
--업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬
--하세요.
SELECT job_id 업무, job_title 업무이름, max_salary 최고월급
FROM jobs
ORDER BY max_salary, job_title DESC;

--문제3.
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저
--아이디, 커미션 비율, 월급 을 출력하세요.
SELECT first_name || ' ' || last_name 이름, manager_id 매니저아이디, commission_pct 커미션비율, salary 월급
FROM employees
WHERE commission_pct IS NULL AND
salary > 3000 AND manager_id IS NOT NULL;

--문제4.
--최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 최고월급(max_salary)을 
--최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요. 
SELECT job_title "업무 이름", max_salary 최고월급
FROM jobs
WHERE max_salary >= 10000
ORDER BY max_salary DESC;

--문제5.
--월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를 월급순
--(내림차순) 출력하세오. 단 커미션퍼센트 가 null 이면 0 으로 나타내시오
SELECT first_name 이름, salary 월급, nvl(commission_pct, 0) 커미션퍼센트
FROM employees
WHERE (10000 <= salary AND salary < 14000)
ORDER BY salary, commission_pct DESC;

--문제6.
--부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
--입사일은 1977-12 와 같이 표시하시오
SELECT (first_name || ' ' || last_name) "직원의 이름", salary 월급, 
TO_CHAR(hire_date, 'YYYY-MM') 입사일, department_id 부서번호
FROM employees
WHERE department_id IN(10, 90, 100);

--문제7.
--이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 나타내시오
SELECT first_name "직원의 이름", salary 월급
FROM employees
WHERE first_name LIKE '%S%' OR first_name LIKE '%s%';

--문제8.
--전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세오.
SELECT department_name
FROM departments
ORDER BY LENGTH(department_name) DESC;

--문제9.
--정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
--올림차순(ASC)으로 정렬해 보세오.
SELECT UPPER(country_name) 나라이름
FROM countries
ORDER BY country_name;

--문제10.
--입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력하세요
--전화번호는 545-343-3433 과 같은 형태로 출력하시오
SELECT first_name || ' ' || last_name 이름, salary 월급, REPLACE(phone_number, '.', '-') "전화번호", hire_date 입사일
FROM employees
WHERE hire_date >= '03/12/31';

-------------
-- 조인 문제
-------------

--문제1.
--직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을
--조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
--(106건)
SELECT employee_id, first_name, last_name, department_name
FROM employees JOIN departments USING (department_id)
ORDER BY department_name ASC, employee_id DESC;

--문제2.
--employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
--직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현
--재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
--부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.(106건)
SELECT employee_id, first_name, salary, department_name, job_title
FROM jobs t1 JOIN employees t2 ON (t1.job_id = t2.job_id) 
JOIN departments t3 ON (t2.department_id = t3.department_id)
WHERE department_name IS NOT NULL
ORDER BY t2.employee_id;

--문제2-1.
--문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요(107건)
SELECT employee_id, CONCAT(first_name, last_name), salary, job_title, employee_id
FROM jobs t1 JOIN employees t2 ON (t1.job_id = t2.job_id)
LEFT OUTER JOIN departments t3 ON (t2.department_id = t3.department_id)
ORDER BY t2.employee_id;

--문제3.
--도시별로 위치한 부서들을 파악하려고 합니다.
--도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요
--부서가 없는 도시는 표시하지 않습니다.(27건)
SELECT t1.location_id, city, department_name, department_id
FROM locations t1 JOIN departments t2 ON (t1.location_id = t2.location_id);

--문제3-1.
--문제3에서 부서가 없는 도시도 표시합니다.(43건)
SELECT t1.location_id, city, department_name, department_id
FROM locations t1 FULL OUTER JOIN departments t2 ON (t1.location_id = t2.location_id);

--문제4.
--지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하
--되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.(25건)
SELECT region_name, country_name
FROM regions t1 JOIN countries t2 ON (t1.region_id = t2.region_id)
ORDER BY region_name, country_name DESC;

--문제5. 
--자신의 매니저보다 채용일(hire_date)이 빠른 사원의
--사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입
--사일(hire_date)을 조회하세요.(37건)
SELECT e. employee_id, e.first_name, e.hire_date,
        m.first_name, m.hire_date
FROM employees e JOIN employees m ON (e.manager_id = m.employee_id)
WHERE e.hire_date < m.hire_date;

--문제6.
--나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
--나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여
--출력하세요. 값이 없는 경우 표시하지 않습니다.(27건)
SELECT t3.country_name, t3.country_id, t1.city, t1.location_id, t2.department_name, t2.department_id
FROM locations t1 JOIN departments t2 ON (t1.location_id = t2.location_id)
JOIN countries t3 ON (t1.country_id = t3.country_id)
--FROM locations t1, departments t2, countries t3
--WHERE t1.location_id = t2.location_id AND t1.country_id = t3.country_id 
--> WHERE절로 해도 상관없는듯 JOIN 대신
ORDER BY country_name;


--문제7.
--job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
--과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이
--디, 시작일, 종료일을 출력하세요.
--이름은 first_name과 last_name을 합쳐 출력합니다. (2건)
SELECT t1.employee_id, CONCAT(t1.first_name, t1.last_name), t2.job_id, t2.start_date, t2.end_date
FROM employees t1 JOIN job_history t2 ON t1.job_id = t2.job_id
WHERE t2.job_id LIKE '%AC_ACCOUNT%';

--문제8.
--각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
--매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
--(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
--(11건)
SELECT d.department_id, department_name, first_name, city, country_name, region_name
FROM departments d
JOIN employees m ON (d.manager_id = m.employee_id) -- 다른 컬럼이여도 id값은 정수이기 때문에 동등한 값이 조인됨
JOIN locations l ON (d.location_id = l.location_id) -- 위에서 조인된 11건의 결과가 다시 location_id로 locations테이블과 동등한id가 존재하는지 비교됨
JOIN countries c ON (l.country_id = c.country_id) -- 반복
JOIN regions r ON (c.region_id = r.region_id); -- 반복

--SELECT t1.manager_id, t2.employee_id
--FROM departments t1 JOIN employees t2 ON (t1.manager_id != t2.employee_id); 
-- 조인은 비교 연산자 사용 가능
-- =, !=, >, <, <=, >=

--문제9.
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
--(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
--부서가 없는 직원(Kimberely)도 표시합니다. (106명)
SELECT s.employee_id, s.first_name, d.department_name, m.first_name
FROM employees s JOIN employees m ON (s.employee_id = m.manager_id)
JOIN departments d ON (s.department_id = d.department_id);

-------------
-- 집계 문제
-------------

--문제1.
--매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요 (106)
SELECT COUNT(manager_id)
FROM employees;

--문제2.
--직원중에 최고임금(salary)과 최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력
--해 보세요. 두 임금의 차이는 얼마인가요? “최고임금 – 최저임금”이란 타이틀로 함께 출력
--해 보세요.
SELECT max(salary) 최고임금, min(salary) 최저임금, max(salary)-min(salary) "최고임금 - 최저임금"
FROM employees;

--문제3.
--마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
--예) 2014년 07월 10일
SELECT TO_CHAR(max(hire_date), 'YYYY"년"-MM"월"-DD"일"')
FROM employees;

--문제4.
--부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
--정렬순서는 부서번호(department_id) 내림차순입니다.
SELECT ROUND(AVG(salary), 0), MAX(salary), MIN(salary), department_id 
-- ROUND(AVG(salary) ) -> 0이 없어도 자동으로 0으로 소수점 자리수 설정
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id DESC;
--문제5.
--업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고 정렬
--순서는 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 순입니다.
--(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
SELECT job_id, ROUND(AVG(salary), 0), MAX(salary), MIN(salary)
FROM employees
GROUP BY job_id
ORDER BY MIN(salary) DESC, AVG(salary) ASC;

--문제6.
--가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
--예) 2001-01-13 토요일
SELECT TO_CHAR(MIN(hire_date), 'YYYY-MM-DD" 토요일"')
FROM employees;


--문제7.
--평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 그리
--고 (평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.
SELECT department_id, ROUND(AVG(salary) ), MAX(salary), MIN(salary)
FROM employees
GROUP BY department_id
    HAVING AVG(salary) - MIN(salary) < 2000
ORDER BY AVG(salary) - MIN(salary) DESC;

--문제8.
--업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
--차이를 확인할 수 있도록 내림차순으로 정렬하세요? 
SELECT job_id, MAX(salary) - MIN(salary) diff
FROM employees
GROUP BY job_id
ORDER BY diff DESC;

--문제9
--2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
--출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
--평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
SELECT manager_id, ROUND(AVG(salary) ), MAX(salary), MIN(salary)
FROM employees
WHERE hire_date >= '05/01/01'
GROUP BY manager_id
    HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;


--문제10
--아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
--입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’
--이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
--정렬은 입사일로 오름차순으로 정렬합니다.
--부서가 없는 직원(Kimberely)도 표시합니다.
--(106명)
SELECT employee_id, salary,
    CASE WHEN hire_date <= '02/12/31' THEN '창립멤버'
            WHEN hire_date <= '03/12/31' THEN '03년 입사'
            WHEN hire_date <= '04/12/31' THEN '04년 입사'
            ELSE '상장이후 입사'
    END optDate,
    hire_date
FROM employees
ORDER BY hire_date;

-------------
-- 서브쿼리 문제
-------------
-- 문제1
SELECT COUNT(salary)
FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);

--문제2. 
SELECT e.employee_id, e.first_name, e.salary, t.avgSalary, t.maxsalary
FROM employees e, (SELECT AVG(salary) avgsalary, MAX(salary) maxsalary FROM employees) t
WHERE e.salary BETWEEN t.avgsalary AND t.maxsalary
ORDER BY salary;

-- 문제3
SELECT t1.location_id, street_address, postal_code, city, state_province, country_id
FROM locations t1 JOIN departments t2 ON(t2.location_id = t1.location_id) 
JOIN employees t3 ON (t2.department_id = t3.department_id)
WHERE CONCAT(first_name, last_name) LIKE '%StevenKing%';

-- 문제4
SELECT employee_id, first_name, salary
FROM employees
WHERE salary < ANY 
(SELECT salary FROM employees WHERE job_id LIKE '%ST_MAN%')
ORDER BY salary;


-- 문제5
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary) FROM employees
GROUP BY department_id)
ORDER BY department_id;

--SELECT e.department_id, e.employee_id, e.first_name, e.salary
--FROM employees e, (SELECT department_id, MAX(salary) s FROM employees
--                            GROUP BY department_id) sal
--WHERE e.department_id = sal.department_id AND e.salary = sal.s
--ORDER BY e.department_id;
-- 다시보기

-- 문제6
--각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오
--(19건
SELECT j.job_title, sum(e.salary)
FROM jobs j, employees e
GROUP BY j.job_title
ORDER BY sum(e.salary) DESC;

-- 문제7
SELECT e.employees_id, e.first_name, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees
WHERE department_id = e.department_id);

-- 문제8
SELECT rnum, employee_id, first_name, salary, hire_date
FROM (SELECT rownum rnum, employee_id, first_name, salary, hire_date 
FROM( SELECT employee_id, first_name, salary, hire_date FROM employees ORDER BY hire_date))
WHERE rnum <= 15 and  rnum >= 11;


CREATE USER c##bituser IDENTIFIED BY bituser;
GRANT CONNECT, RESOURCE TO C##BITUSER;

ALTER USER C##BITUSER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

GRANT SELECT ON HR.EMPLOYEES TO C##BITUSER;


-- mission1. 서브쿼리 사원 조회
SELECT * 
FROM EMP 
WHERE SAL <= (SELECT AVG(SAL) FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL WHERE S.GRADE = 2);

-- question1.
-- 현재시간 기준으로 근무 개월이(12 * 30개월) 보다 많은 사람 출력
SELECT ENAME, SAL, HIREDATE, DNAME
FROM EMP E JOIN DEPT D USING(DEPTNO)
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) > 360;


