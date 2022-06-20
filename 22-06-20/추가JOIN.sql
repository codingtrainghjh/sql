--Equi Join
--�Ӽ��� ���� �� �÷��� ����
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id;

--�߰�����
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE salary > 8000;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 8000;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id
AND e.salary > 8000;

--Outer Join
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id(+);

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id); --�ϳ��� ���忡�� outer join�� �ϳ��ۿ� ���� ����

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id(+) = d.department_id
UNION
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e , departments d
WHERE e.department_id = d.department_id(+);

--����� �μ����̺��� ������ ��� �ƿ����ุ ǥ���Ͻÿ�.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id)
MINUS
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

--Non Equi Join
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e , job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

--Self Join
SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m
ON (e.manager_id = m.employee_id);

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

--3Way Join
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.city
FROM employees e ,departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

--Cross Join --��� ����� ���� �߻���Ű�� join
SELECT last_name, department_name
FROM employees CROSS JOIN departments;

SELECT last_name, department_name
FROM employees ,departments;