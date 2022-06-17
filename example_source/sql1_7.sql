--Subquery의 기본 사용
SELECT salary 
FROM employees
WHERE last_name = 'Abel';
SELECT *
FROM employees
WHERE salary > 11000;
SELECT *
FROM employees
WHERE salary > (SELECT salary 
                             FROM employees
                            WHERE last_name = 'Abel');
--단일행 서브쿼리(Single Row Subquery)
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id =  
                             (SELECT job_id
                              FROM   employees
                              WHERE  last_name = 'Matos')
AND    salary >
                             (SELECT salary
                              FROM   employees
                              WHERE  last_name = 'Matos');
SELECT MAX(salary) 
FROM employees;
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees);
SELECT   department_id, COUNT(*)
FROM     employees
GROUP BY department_id
HAVING  COUNT(*) > (SELECT COUNT(*)
                                         FROM   employees
                                         WHERE  department_id = 20);                
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                             WHERE department_id = 60);              
--다중 행 서브쿼리(Multiple Row Subquery)     
SELECT MAX(salary) 
FROM employees
GROUP BY department_id;
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                              GROUP BY department_id);    
SELECT last_name, job_id, salary
FROM   employees
WHERE salary IN (SELECT MAX(salary) 
                               FROM employees
                              GROUP BY department_id);  
SELECT salary 
FROM employees
WHERE department_id = 60;              
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary 
                              FROM employees
                             WHERE department_id = 60)
AND department_id <> 60;      
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ANY (SELECT salary 
                                      FROM employees
                                      WHERE department_id = 60)
AND department_id <> 60; 
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ALL (SELECT salary 
                                    FROM employees
                                    WHERE department_id = 60)
AND department_id <> 60;
--Subquery 사용 시 주의사항
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary
                              FROM employees
                              WHERE last_name = 'Mark');
SELECT employee_id, last_name
FROM employees 
WHERE employee_id IN (SELECT manager_id
                                           FROM employees);
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees);    
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees
                                                     WHERE manager_id IS NOT NULL);    