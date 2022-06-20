--GROUP BY Ȯ��
SELECT COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees;

SELECT department_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id, job_id
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null),  COUNT(*)  �ο���,  SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id
UNION
SELECT TO_NUMBER(NULL), TO_CHAR(NULL), COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
ORDER BY 1,2;

SELECT department_id, job_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 1;

SELECT department_id, job_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY GROUPING SETS((department_id, job_id), ()) --������� ����� ������
ORDER BY 1;

--Ex
SELECT department_id, job_id, COUNT(*)  �ο���, SUM(salary) �ѱ޿�, TRUNC(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY GROUPING SETS((department_id,manager_id),(job_id), ()) --������� ����� ������
ORDER BY 1,2,3;
