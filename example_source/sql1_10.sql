--테이블 생성과 삭제
CREATE TABLE dept (deptno   NUMBER(2),
         dname       VARCHAR2(14),
         loc         VARCHAR2(13));
--기본값 테스트
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부');
INSERT INTO dept
VALUES(20, '영업부', '서울');
COMMIT;
SELECT * FROM dept;
--기본키와 기본값 열을 포함하는 테이블 생성
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);
DROP TABLE dept;
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);
--기본값 테스트
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부');
INSERT INTO dept
VALUES(20, '영업부', '서울', '19/03/14');
COMMIT;
SELECT * FROM dept;
--여러가지 제약조건을 포함하는 테이블 생성
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)REFERENCES dept(deptno));
--제약조건 관련 딕셔너리 정보 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';
SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'EMP';
SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');
--DML을 수행하며 제약조건 테스트하기
INSERT INTO emp
VALUES(null, '김수현','shkim@naver.com','01023456789','회사원',3500, null);
INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, null);
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,1800, 20);
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
SELECT * FROM emp;
UPDATE emp
SET deptno=30
WHERE empno=1234;
UPDATE emp
SET deptno=10
WHERE empno=1234;
COMMIT;
DELETE FROM dept
WHERE deptno=10;
SELECT * FROM emp;
--테이블 복사 하기
CREATE TABLE 	dept80
AS  SELECT  employee_id, last_name, salary*12 ANNSAL, hire_date
FROM    employees 
WHERE   department_id = 80;
SELECT * FROM dept80;
--테이블 읽기 전용 설정 테스트
ALTER TABLE emp READ ONLY;
UPDATE emp
SET salary = salary*1.1;
ALTER TABLE emp READ WRITE;
--테이블 삭제
DROP TABLE dept;
DROP TABLE emp;
DROP TABLE dept;
SELECT * FROM emp;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');
--ON DELETE 절 실습을 위한 테이블 생성
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
         dname       VARCHAR2(14),
         loc         VARCHAR2(13),
         create_date DATE DEFAULT SYSDATE);
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부');
INSERT INTO dept
VALUES(20, '영업부', '서울', '19/03/14');
COMMIT;
SELECT * FROM dept;
-- ON DELETE CASCADE Test
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4),
CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE CASCADE);
INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, 10);
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
DELETE FROM dept
WHERE deptno = 20;
SELECT * FROM dept;
SELECT * FROM emp;
ROLLBACK;
DROP TABLE emp;

--ON DELETE SET NULL Test
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4),
CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE SET NULL);
INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, 10);
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
DELETE FROM dept
WHERE deptno = 20;
SELECT * FROM dept;
SELECT * FROM emp;
ROLLBACK;

--CASCADE CONSTRAINTS Test
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';
DROP TABLE dept;
DROP TABLE dept CASCADE CONSTRAINTS;
SELECT * FROM dept;
SELECT * FROM emp;
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';
DROP TABLE emp;