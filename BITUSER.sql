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

CREATE TABLE users (
    no number primary key,
    name varchar2(20) NOT NULL,
    password varchar2(20) NOT NULL,
    email varchar2(128) NOT NULL UNIQUE,
    gender char(1) CHECK(gender IN ('M', 'F')),
    created_at date DEFAULT sysdate);
CREATE SEQUENCE seq_users_pk
    START WITH 1
    INCREMENT BY 1;
INSERT INTO users (no, name, password, email, gender)
VALUES(seq_users_pk.nextval, '관리자', '12345678', 'admin@example.com', 'M');
commit;

SELECT * FROM users;


CREATE TABLE address_book (
    no number primary key,
    name varchar2(20) NOT NULL,
    hp varchar2(20) NOT NULL,
    tel varchar2(20) NOT NULL);
CREATE SEQUENCE seq_address_book_pk
	START WITH 1
	INCREMENT BY 1;
    
INSERT INTO address_book (no, name, hp, tel)
VALUES(seq_address_book_pk.NEXTVAL, '비비빅', '010-2454-1231', '02-2134-1242');

SELECT * FROM address_book;

COMMIT;