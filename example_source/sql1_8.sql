--실습에 사용되는 추가 테이블
SELECT *
FROM job_history;
--집합연산자의 기본적인 사용법(UNION)
SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id FROM job_history;
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history;
SELECT employee_id AS 사번, department_id FROM employees
UNION
SELECT employee_id, department_id AS 부서번호 FROM job_history;
--UNION ALL
SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;
SELECT employee_id FROM employees
UNION ALL
SELECT employee_id FROM job_history;
--INTERSECT
SELECT employee_id FROM employees
INTERSECT
SELECT employee_id FROM job_history;
SELECT employee_id, job_id FROM employees
INTERSECT
SELECT employee_id, job_id FROM job_history;
--MINUS
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;
SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;
--COLUMN수와 DATATYPE 매칭시키기
SELECT employee_id, hire_date, TO_CHAR(null) AS department_name
FROM employees
UNION
SELECT department_id, TO_DATE(null), department_name
FROM departments;
SELECT employee_id, salary, TO_CHAR(null) AS department_name
FROM employees
UNION
SELECT department_id, -1, department_name
FROM departments;
--COLUMN수와 DATATYPE 매칭시키기 응용
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id;
SELECT department_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id;
SELECT COUNT(*), SUM(salary)
FROM employees;

SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id
UNION
SELECT TO_NUMBER(null), TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
ORDER BY 1,2;