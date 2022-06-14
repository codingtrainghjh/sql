SELECT*
FROM employees;
SELECT*
FROM departments;
SELECT location_id, department_name
FROM departments;
SELECT location_id, department_name FROM departments;
select location_id, department_name from departments;
--표현식(expression)과 별칭(AS)
SELECT employee_id, last_name, salary, salary*12
FROM employees;
SELECT employee_id, last_name, salary, salary+100*12, (salary+100)*12
FROM employees;
SELECT employee_id, last_name, salary, salary*12 연봉
FROM employees;
SELECT employee_id, last_name, salary, salary*12 annual_salary
FROM employees;
SELECT employee_id empno, last_name empname, salary, salary*12 "Annual salary"
FROM employees;
SELECT employee_id, last_name, salary,
            salary*12 annual_salary
FROM employees;
--연결연산자(||)
SELECT employee_id, first_name, last_name
FROM employees;
SELECT employee_id, first_name || last_name full_name
FROM employees;
SELECT employee_id, first_name || ' ' || last_name full_name
FROM employees;
SELECT employee_id, 
            first_name || ' ' || last_name full_name, email || '@yd.com' AS email
FROM employees;
SELECT last_name ||'''s salary : '|| salary
FROM employees;
SELECT last_name ||q'['s salary : ]'|| salary 
FROM employees;

--DISTINCT
SELECT department_id
FROM employees;
SELECT DISTINCT department_id
FROM employees;
SELECT DISTINCT department_id, job_id
FROM employees;
SELECT DISTINCT department_id, DISTINCT job_id
FROM employees;
SELECT department_id, DISNTINCT job_id
FROM employees;

--NULL값(아무것도 저장하지 않은 상태, 0 또는 공백과 다른 상태)
SELECT employee_id, last_name, manager_id, commission_pct, department_id
FROM employees;
SELECT employee_id, last_name, salary, commission_pct,
            salary  + salary*commission_pct AS 실급여
FROM employees;

--테이블구조(열구조)
DESCRIBE employees;
DESC departments;