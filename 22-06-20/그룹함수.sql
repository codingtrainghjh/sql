--GROUP BY 확장
SELECT COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees;

SELECT department_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id, job_id
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null),  COUNT(*)  인원수,  SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id
UNION
SELECT TO_NUMBER(NULL), TO_CHAR(NULL), COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
ORDER BY 1,2;

SELECT department_id, job_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY GROUPING SETS((department_id, job_id), ()) --보고싶은 결과만 보여줌
ORDER BY 1;

--Ex
SELECT department_id, job_id, COUNT(*)  인원수, SUM(salary) 총급여, TRUNC(AVG(salary)) 평균급여
FROM employees
GROUP BY GROUPING SETS((department_id,manager_id),(job_id), ()) --보고싶은 결과만 보여줌
ORDER BY 1,2,3;
