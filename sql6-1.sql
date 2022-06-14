--NATURAL JOIN
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city, street_address
FROM departments NATURAL JOIN locations; --양쪽 테이블의 공통된 부분을 찾아서 알아서 조합
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments; --natural join은 양쪽 테이블에서 찾을수 있는 공통점이 하나일때 주로 사용한다.
--USING 절을 사용하는 JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id); --강제성을 띔, 컬럼 '무엇'을 가지고 조인을 한다.
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id); --컬럼이 여러개일때 한 컬럼을 지정해서 사용가능
--ON절을 사용하는 JOIN
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id); --양쪽 테이블의 컬럼명이 다를때 사용
--테이블 이름 별칭 사용
SELECT employees.employee_id, employees.last_name, 
               employees.department_id, departments.department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
SELECT e.employee_id, e.last_name, 
       e.department_id, d.department_name
FROM employees e JOIN departments d 
ON (e.department_id = d.department_id); --가장 완성된 join문장
--WHERE 절 추가
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.salary > 9000;
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000; --추가 조건 입력 가능
--INNER JOIN과 OUTER JOIN
SELECT e.employee_id, e.last_name,  --이너조인에 아우터조인을 함께 보는 것
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
--USING절에 OUTER 조인하기
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

--GROUP함수와 JOIN 응용
SELECT   d.department_name, MIN(e.salary), 
                MAX(e.salary),TRUNC(AVG(e.salary))
FROM     employees e JOIN departments d
ON       (e.department_id = d.department_id)
GROUP BY d.department_name;

--문법
--NATURAL JOIN
--JOIN~USING
--JOIN~ON
--CROSS JOIN

--조인 결과에 아우터행을 포함할지 여부
--INNER JOIN
--OUTER JOIN (LEFT/RIGHT/FULL)

--테이블 수
--1개 : SELF JOIN
--3개 : 3 Way JOIN

--연산자
--EQUI JOIN(=)
--NON EQUI JOIN(예 : BETWEEN)

