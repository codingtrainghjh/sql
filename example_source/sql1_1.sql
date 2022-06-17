--기본 SELECT 문
SELECT *
FROM   departments;
SELECT  department_id, department_name, manager_id, location_id
FROM    departments;
SELECT department_id, location_id
FROM   departments;
SELECT location_id, department_name 
FROM departments;
--산술연산자의 사용
SELECT last_name, salary, salary + 300
FROM   employees;
SELECT last_name, salary, 12*salary+100
FROM   employees;
SELECT last_name, salary, 12*(salary+100)
FROM   employees;
--널값과 산술연산
SELECT last_name, job_id, salary, commission_pct
FROM   employees;
SELECT last_name, 12*salary*commission_pct
FROM   employees;
--Column Alias(별칭)
SELECT last_name AS name , job_id Job_Id , salary*12 AS "Annual_Sal", 
       commission_pct 수당
FROM   employees;
--연결연산자의 사용과 응용
SELECT first_name, last_name,
       first_name ||' '||last_name AS full_name
FROM employees;
SELECT employee_id||'-'||last_name||'''s Salary : '||salary
FROM employees;
--Q연산자로 가독성 증대
SELECT employee_id||'-'||last_name||q'['s Salary : ]'||salary
FROM employees;
--DISTINCT 사용으로 결과에서 중복제거
SELECT department_id 
FROM employees;
SELECT DISTINCT department_id 
FROM employees;
SELECT DISTINCT department_id, job_id 
FROM employees;
--DISTINCT의 잘못 사용 예시
SELECT  DISTINCT department_id, DISTINCT job_id 
FROM employees;
SELECT  department_id, DISTINCT job_id 
FROM employees;


