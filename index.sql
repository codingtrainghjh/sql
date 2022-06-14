--자동 인덱스 생성
DROP TABLE emp;
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4));
--제약조건 관련 딕셔너리 정보 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP'; --제약조건으로 인덱스 자동생성 확인(중복을 허용하지 않음)
--수동으로 인덱스 생성
CREATE INDEX emp_ename_idx ON emp(ename);
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';
--인덱스 삭제
DROP INDEX emp_email_uk; --삭제는 수동으로 만든것만 가능
DROP INDEX emp_ename_idx;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMPLOYEES';

SELECT *
FROM employees
WHERE employee_id = 101;

CREATE OR REPLACE VIEW dept_sum_vu
  (name, minsal, maxsal, avgsal)
AS SELECT   d.department_name, MIN(e.salary), 
            MAX(e.salary),TRUNC(AVG(e.salary))
   FROM     employees e JOIN departments d
   ON       (e.department_id = d.department_id)
   GROUP BY d.department_name;
   
   SELECT *
   FROM dept_sum_vu;

--동의어 생성
SELECT * FROM dept_sum_vu;
CREATE SYNONYM d_sum FOR dept_sum_vu;
SELECT * FROM d_sum;
--동의어 관련 데이터딕셔너리 보기
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;
--동의어 삭제
DROP SYNONYM d_sum;
DROP TABLE emp;
--테이블 삭제 시 기타 객체들에 대한 정보 확인하기(10번문제)
CREATE TABLE test
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4));
CREATE INDEX test_job_ix 
ON test(job);
CREATE SEQUENCE test_no_seq
INCREMENT BY 1
START WITH 301
NOCACHE
NOCYCLE;
CREATE VIEW test_sum_vu
AS
SELECT empno, ename, job, deptno
FROM test;
CREATE SYNONYM t
FOR test_sum_vu;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'TEST';
SELECT object_name,object_type, status FROM user_objects
WHERE object_name LIKE 'TEST%' OR object_name ='T';
DROP TABLE test;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'TEST';
SELECT object_name,object_type, status FROM user_objects
WHERE object_name LIKE 'TEST%' OR object_name ='T';
DROP sequence test_no_seq;
DROP VIEW test_sum_vu;
DROP SYNONYM t;