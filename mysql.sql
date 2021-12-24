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
