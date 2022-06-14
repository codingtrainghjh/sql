--NATURAL JOIN
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city, street_address
FROM departments NATURAL JOIN locations; --���� ���̺��� ����� �κ��� ã�Ƽ� �˾Ƽ� ����
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments; --natural join�� ���� ���̺��� ã���� �ִ� �������� �ϳ��϶� �ַ� ����Ѵ�.
--USING ���� ����ϴ� JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id); --�������� ��, �÷� '����'�� ������ ������ �Ѵ�.
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id); --�÷��� �������϶� �� �÷��� �����ؼ� ��밡��
--ON���� ����ϴ� JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id); --���� ���̺��� �÷����� �ٸ��� ���
--���̺� �̸� ��Ī ���
SELECT employees.employee_id, employees.last_name, 
               employees.department_id, departments.department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
SELECT e.employee_id, e.last_name, 
       e.department_id, d.department_name
FROM employees e JOIN departments d 
ON (e.department_id = d.department_id); --���� �ϼ��� join����
--WHERE �� �߰�
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.salary > 9000;
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000; --�߰� ���� �Է� ����
--INNER JOIN�� OUTER JOIN
SELECT e.employee_id, e.last_name,  --�̳����ο� �ƿ��������� �Բ� ���� ��
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);
--USING���� OUTER �����ϱ�
SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);

SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);

--SELF JOIN
SELECT employee_id, last_name, manager_id
FROM employees;


SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m
ON (e.manager_id = m.employee_id);

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id);

--NON-EQUI JOIN
SELECT * 
FROM job_grades;
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

--3Way JOIN
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);
--Cartesian Products
SELECT employee_id, city
FROM employees NATURAL JOIN locations;
SELECT employee_id, department_name
FROM employees CROSS JOIN departments;

--GROUP�Լ��� JOIN ����
SELECT   d.department_name, MIN(e.salary), 
                MAX(e.salary),TRUNC(AVG(e.salary))
FROM     employees e JOIN departments d
ON       (e.department_id = d.department_id)
GROUP BY d.department_name;

--����
--NATURAL JOIN
--JOIN~USING
--JOIN~ON
--CROSS JOIN

--���� ����� �ƿ������� �������� ����
--INNER JOIN
--OUTER JOIN (LEFT/RIGHT/FULL)

--���̺� ��
--1�� : SELF JOIN
--3�� : 3 Way JOIN

--������
--EQUI JOIN(=)
--NON EQUI JOIN(�� : BETWEEN)

