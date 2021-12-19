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
