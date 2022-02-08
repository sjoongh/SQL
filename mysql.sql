-- 데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 
-- 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 
-- 이때 결과는 장바구니의 아이디 순으로 나와야 합니다

SELECT 
  CART_ID 
FROM 
  CART_PRODUCTS
WHERE NAME IN ("Milk", "Yogurt") 
GROUP BY CART_ID HAVING COUNT(DISTINCT(NAME)) >= 2
ORDER BY CART_ID


-- LAST_NAME, JOB, SALARY를 보여주는 부서 테이블을 만들려고 한다.
-- 급여가 2500, 3500, 7000와 같지 않은 판매원(SALES REPRESENTATIVE)과 증권사(STOCK CLERK)직원을 보여줘라
SELECT E.LAST_NAME , J.JOB_TITLE , E.SALARY 
FROM EMPLOYEES E JOIN JOBS J 
ON E.JOB_ID = J.JOB_ID 
WHERE E.SALARY NOT IN(2500,3500,7000)
AND (J.JOB_TITLE LIKE 'SALES REPRESENTATIVE'
OR J.JOB_TITLE LIKE 'STOCK CLERK');

-- 평균급여가 적은 업무
SELECT ASD 업무
FROM
(SELECT JOB AS ASD
FROM EMP
GROUP BY JOB
ORDER BY AVG(SAL) ASC)
WHERE ROWNUM=1;

--담당업무가 MANAGER 인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오
SELECT E.ENAME 사원명
FROM EMP E,
(SELECT DEPTNO FROM EMP WHERE JOB='MANAGER')E1
WHERE E.DEPTNO = E1.DEPTNO; 

-- JOIN활용
select ANIMAL_ID,NAME 
from ( select o.animal_id as 'ANIMAL_ID',
o.name as 'NAME',i.animal_id as 'i_id' 
from animal_outs as o left 
join animal_ins as i on i.animal_id = o.animal_id ) sq1
where i_id is NULL

-- DEPT Table에는 존재하는 부서 코드이지만 해당 부서에 근무하는 사람이 존재하지 않는 경우의 결과를 출력
select *
from dept
where deptno not in (
    select deptno
    from emp
    group by deptno
    having count(*) > 0
);

-- 동물의 종류 파악 (count)
select animal_type,count(*)
from animal_ins
group by animal_type

-- 멕시코(Mexico)보다 인구가 많은 나라이름과 인구수를 조회하시고 인구수 순으로 내림차순
select name, population
from country
where population > 
(select population from country where code = 'MEX' ) 
order by population desc;

-- 부서번호가 10인 사원중에서 최대급여를 받는 사원과 동일한 급여를 받는 사원의 사원번호, 이름을 조회
SELECT EMPNO,ENAME 
FROM EMP 
WHERE SAL = (
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10
);

-- 어린 동물 찾기
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE INTAKE_CONDITION != "Aged"
ORDER BY ANIMAL_ID

-- 한번도 구매하지 않은 사람의 직업
SELECT job FROM job_list
LEFT OUTER JOIN customers ON job_list.j_id = customers.j_id
LEFT OUTER JOIN order_list ON customers.c_id = order_list.c_id
WHERE order_list.c_id IS NULL;

-- 환산평점이 가장 높은 3명의 학생을 검색하는 예제(다중쿼리)
SELECT SNO,SNAME,(AVR/4.0 *4.5)
FROM STUDENT
ORDER BY 3 DESC;
SELECT ROWNUM, S.*
FROM (SELECT SNO,SNAME,(AVR/4.0 *4.5)
FROM STUDENT
ORDER BY AVR DESC)S
WHERE ROWNUM <= 3;

-- 직업이 student인 고객의 이름과 구매총액
SELECT c_name, sum(p_price)
FROM customers JOIN order_list JOIN products JOIN job_list
WHERE job = 'student';

-- self join
select emp1.empNo 사원번호, emp1.empName 직원이름,
emp1.manager 매니저 번호, emp2.empName 매니저이름
from employee emp1
join employee emp2 on emp1.manager = emp2.empNo

-- blake와 동일한 부서에 속한 사원의 이름과 입사일 표시
-- 단 bleak는 제외
ROM EMP E ,EMP E1
WHERE E.DEPTNO = E1.DEPTNO AND
-- BLAKE 가 속한 부서 
E.ENAME = 'BLAKE' AND
NOT E1.ENAME ='BLAKE';

-- 특정이름 조회
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE 
FROM ANIMAL_INS 
WHERE NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty') 
ORDER BY ANIMAL_ID
