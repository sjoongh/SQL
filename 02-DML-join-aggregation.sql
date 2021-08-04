------------
---- JOIN
------------

-- employees와 departments를 확인
DESC employees;
DESC departments;

-- 두 테이블로부터 모든 레코드를 추출: Cartision Prodect or Cross Join
SELECT first_name, t1.department_id, t2.department_id, department_name
FROM employees t1, departments t2
ORDER BY first_name;

-- 테이블 조인을 위한 조건 부여할 수 있다. Simple JOIN(INNER JOIN)
SELECT first_name, t1.department_id, t2.department_name
FROM employees t1, departments t2
WHERE t1.department_id = t2.department_id;