--Run SQL CommandLine에서 실습 진행
--새사용자 생성
conn / as sysdba
CREATE USER demo IDENTIFIED BY demo
DEFAULT TABLESPACE users;
--접속권한 부여
GRANT create session TO demo;
--DEMO 사용자로 접속 및 테이블 생성 시도
conn demo/demo
CREATE TABLE demo_emp
(id NUMBER(2),
name VARCHAR2(20)); 
--관리자세션에서 롤 부여
conn / as sysdba
grant  connect, resource to demo;
--DEMO 세션에서 부여받은 권한 확인
conn demo/demo
SELECT * FROM session_privs;
--테이블 생성 구문 재실행 성공 후 뷰 생성 시도에 권한부족으로 실패
CREATE TABLE demo_emp
(id NUMBER(2),
name VARCHAR2(20)); 
CREATE VIEW demo_emp_vu
AS SELECT * FROM demo_emp;
--DEMO 세션에서 hr.employees 테이블 쿼리 시도 후 권한부족으로 실패
SELECT * FROM hr.employees;
--HR(인사관리) 사용자로 접속 후 employees 테이블에 대한 읽기 권한 부여
conn hr/hr
GRANT select on hr.employees TO demo;
--DEMO사용자로 로그인하여 hr.employees테이블 읽기
conn demo/demo
SELECT * FROM hr.employees;
--HR 세션에서 권한 회수 후 뷰생성
conn hr/hr
REVOKE select on hr.employees FROM demo;
CREATE VIEW emp_list_vu
AS
SELECT employee_id empno, first_name||' '||last_name AS empname, job_id AS position,
          email, phone_number, department_name
FROM employees JOIN departments
USING (department_id)
WHERE department_id <> 90;
--뷰에 대한 조회 권한을 DEMO에게 부여
GRANT select on hr.emp_list_vu TO demo;
--DEMO 세션으로 접속
conn demo/demo
SELECT * FROM hr.emp_list_vu;
--조회권한만 부여되었으므로 UPDATE 시도는 불가능
UPDATE hr.emp_list_vu
SET email='APPLE'
WHERE empno = 144;
--HR세션에서 UPDATE 권한 부여
conn hr/hr
GRANT update(email) on hr.emp_list_vu TO demo;
--DEMO 세션에서 다시 UPDATE 시도
conn demo/demo
UPDATE hr.emp_list_vu
SET email='APPLE'
WHERE empno = 144;
COMMIT;
SELECT * FROM hr.emp_list_vu;
--HR세션에서 employees 테이블의 144번 사원의 이메일 계정이 APPLE로 변경됨을 확인
conn hr/hr
SELECT employee_id, email
FROM employees
WHERE employee_id = 144;
--관리자세션(Run SQL CommandLine)에서 롤 생성 후 DEMO에게 부여
conn / as sysdba
CREATE ROLE r_demo;
GRANT create view, create synonym TO r_demo;
GRANT select on hr.jobs TO r_demo;
GRANT r_demo TO demo;
--DEMO 세션에서 권한확인
conn demo/demo
SELECT * FROM hr.jobs;
--DEMO 사용자가 동의어(Synonym) 생성하여 사용
CREATE SYNONYM j FOR hr.jobs;
CREATE SYNONYM emp FOR hr.emp_list_vu;
SELECT * FROM j;
SELECT * FROM emp;
SELECT object_name, object_type, status FROM user_objects;
--관리자세션에서 r_demo에서 객체권한 회수
conn / as sysdba
REVOKE select on hr.jobs FROM r_demo;
--DEMO사용자로 접속한 후 권한회수 후의 동의어 사용불가 확인
conn demo/demo
SELECT * FROM hr.jobs;
SELECT * FROM j;
--PUBLIC SYNONYM(공용동의어)사용하기
--관리자가 새 사용자 YD(암호: yd)생성 
conn / as sysdba
CREATE user yd IDENTIFIED BY yd
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;
GRANT create session TO yd;
--HR 사용자에게 create public synonym 권한 부여
GRANT create public synonym TO hr;
--HR 세션에서 부서목록을 도시와 함께 보기위한 뷰 생성 및 PUBLIC  권한 부여
conn hr/hr
CREATE VIEW dept_city_list_vu 
AS
SELECT department_id deptno, department_name dept_name, city
FROM departments JOIN locations
USING (location_id);
GRANT select on dept_city_list_vu TO public;
CREATE PUBLIC SYNONYM d FOR hr.dept_city_list_vu;
--여러사용자로 접속하여 공용동의어 사용테스트
conn yd/yd
SELECT * FROM d;
conn demo/demo
SELECT * FROM d;
conn hr/hr
SELECT * FROM d;
--관리자로 접속하여 DUAL 테이블에 대하여 알아보기
conn / as sysdba
col owner for a10
col object_name for a20
SELECT owner, object_name, object_type
FROM dba_objects
WHERE object_name = 'DUAL';
--사용자 암호 변경
conn / as sysdba
ALTER USER demo IDENTIFIED BY 1234;
conn demo/demo
conn demo/1234
--사용자 삭제로 실습 정리 
drop public synonym d;
drop user yd cascade;
drop user demo cascade;

