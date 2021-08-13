CREATE TABLE emaillist (
	no NUMBER PRIMARY KEY,
	last_name VARCHAR2(20) NOT NULL,
	first_name VARCHAR2(20) NOT NULL,
	email VARCHAR2(128) NOT NULL,
	createdAt DATE DEFAULT SYSDATE);
CREATE SEQUENCE seq_emaillist_pk
	START WITH 1
	INCREMENT BY 1;
    
INSERT INTO emaillist (no, first_name, last_name, email)
VALUES(seq_emaillist_pk.NEXTVAL, '중호', '신', 'az45687@naver.com');

SELECT * FROM emaillist;

COMMIT;