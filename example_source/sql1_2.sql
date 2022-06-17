--WHERE절의 기본적인 사용
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE  department_id = 60 ;
SELECT last_name, job_id, department_id
FROM   employees
WHERE  last_name = 'king';
SELECT last_name, job_id, department_id
FROM   employees
WHERE  last_name = 'King';
SELECT last_name, hire_date
FROM employees
WHERE hire_date='99/09/21';
SELECT last_name, hire_date
FROM employees
WHERE hire_date='1999/09/21';
SELECT last_name, hire_date
FROM employees
WHERE hire_date='21/09/99';
SELECT last_name, salary
FROM   employees
WHERE  salary <= 5000 ;
SELECT last_name, hire_date
FROM employees
WHERE hire_date < '00/01/01';
SELECT last_name, hire_date
FROM employees
WHERE last_name < 'King';
SELECT employee_id, salary, department_id
FROM employees
WHERE department_id <> 90;
--BETWEEN 연산자의 사용
SELECT last_name, salary, hire_date
FROM   employees
WHERE  salary BETWEEN 6000 AND 9000 ;
SELECT last_name, salary, hire_date
FROM   employees
WHERE  salary BETWEEN 9000 AND 6000 ;
SELECT last_name, salary, hire_date
FROM   employees
WHERE last_name BETWEEN 'Grant' AND 'King';
SELECT last_name, salary, hire_date
FROM   employees
WHERE hire_date BETWEEN '99/01/01' AND '99/12/31';
--IN연산자의 사용
SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  department_id IN (50,60,80) ;
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE job_id IN ('IT_PROG','SA_REP');
--LIKE연산자
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name LIKE 'A%';
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name LIKE '%a%';
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name LIKE '_a%';
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name LIKE '__a%';
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name LIKE '____';
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name LIKE '%s';
SELECT employee_id, last_name, job_id
FROM   employees 
WHERE  job_id LIKE '%SA\_%' ESCAPE '\';
--널값의 검색
SELECT employee_id, last_name, job_id, manager_id
FROM   employees 
WHERE manager_id IS NULL;
SELECT employee_id, last_name, job_id, manager_id
FROM   employees 
WHERE manager_id = null;
--논리연산자의 사용
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
OR salary > 8000;
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id LIKE 'IT%'
AND salary > 8000;
--NOT연산자
SELECT last_name, salary
FROM   employees
WHERE  salary NOT BETWEEN 6000 AND 9000 ;
SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  department_id NOT IN (50,60,80) ;
SELECT employee_id, last_name, job_id, department_id
FROM   employees
WHERE last_name NOT LIKE '%a%';
SELECT employee_id, last_name, job_id, manager_id
FROM   employees 
WHERE manager_id IS NOT NULL;
--연산자의 우선 순위
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE  job_id LIKE 'IT%'
OR job_id LIKE '%CLERK%'
AND salary < 5000;
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE  (job_id LIKE 'IT%'
OR job_id LIKE '%CLERK%')
AND salary < 5000;
--NULL값에대한 IN과 NOT IN 연산의 특징
SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id IN (100, 101, NULL);
SELECT employee_id, last_name, job_id, manager_id
FROM employees
WHERE manager_id NOT IN (100, 101, NULL);
--1개 열 기준의 정렬
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY last_name;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY hire_date;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY salary DESC;
--2개 이상의 열 기준
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY department_id, salary DESC;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
ORDER BY department_id ASC , salary DESC;
--표현식 또는 별칭 기준
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY department_id ASC , salary*12 DESC;
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY department_id , annsal DESC;
--위치값(Position Number)
SELECT employee_id, last_name, hire_date, salary*12 AS annsal, department_id
FROM employees
ORDER BY 5 , 4 DESC;
--치환변수의 사용  
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = &dept_no;
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = '&job_title';
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE job_id = UPPER('&job_title');
SELECT employee_id, last_name, job_id, &column_name
FROM employees;
SELECT employee_id, last_name, job_id, &column_name
FROM employees
ORDER BY &column_name;
SELECT employee_id, last_name, job_id, &&column_name
FROM employees
ORDER BY &column_name;
define column_name
undefine column_name
define column_name
SELECT employee_id, last_name, job_id, &&column_name
FROM employees
ORDER BY &column_name;
undefine column_name