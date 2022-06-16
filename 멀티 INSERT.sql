--Creating Tables For Multitable INSERT Test
@C:\DB\db_test\sql_labs\cre_minstab.sql
UPDATE employees
SET salary = 10500
WHERE employee_id = 206;
COMMIT;
SELECT * FROM tab;

--Subquery�� �پ��� Ȱ���
SELECT l.location_id, l.city, l.country_id 
                        FROM locations l JOIN countries c
                       ON (l.country_id = c.country_id)
                       JOIN regions USING (region_id)
                       WHERE region_name ='Europe';
SELECT department_name, city
FROM departments
NATURAL JOIN (SELECT l.location_id, l.city, l.country_id 
                        FROM locations l JOIN countries c
                       ON (l.country_id = c.country_id)
                       JOIN regions USING (region_id)
                       WHERE region_name ='Europe');
INSERT INTO (SELECT l.location_id, l.city, l.country_id 
                        FROM locations l JOIN countries c
                       ON (l.country_id = c.country_id)
                       JOIN regions USING (region_id)
                       WHERE region_name ='Europe')
VALUES(3300, 'Cradiff', 'UK');
SELECT * FROM locations;
--����� DEFAULT �� ���
DROP TABLE dept3 PURGE;
CREATE TABLE dept3
AS
SELECT * FROM departments;
--DEPT3 ���̺��� manager_id ���� �⺻������
ALTER TABLE dept3
MODIFY manager_id DEFAULT '9999';
SELECT * FROM dept3;
--DML �۾��� DEFAULT �� ����ϱ�
INSERT INTO dept3(department_id, department_name, manager_id)
VALUES(300, 'Engneering', DEFAULT);
UPDATE dept3
SET manager_id = DEFAULT
WHERE department_id = 10;
SELECT * FROM dept3;
COMMIT;
--Subquery�� ����� INSERT ����
DROP TABLE sales_reps PURGE;
CREATE TABLE sales_reps
AS
SELECT employee_id, last_name, salary, commission_pct
FROM employees 
WHERE 1=2;
INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

--Unconditional Insert Test
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;
INSERT  ALL
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200; -- �ѹ� �о �ι��� ���� �س���

SELECT * FROM sal_history;
SELECT * FROM mgr_history;
ROLLBACK;

--���� ALL INSERT
INSERT ALL
WHEN SAL > 10000 THEN
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
WHEN MGR > 200   THEN 
INTO mgr_history VALUES(EMPID,MGR,SAL)  
SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
FROM   employees
WHERE  employee_id > 200;

SELECT * FROM sal_history;
SELECT * FROM mgr_history;
COMMIT;

--���� FIRST INSERT
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

INSERT FIRST   --ù��° ������ �����ϴ� ���� ù��° �࿡�� �־��
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) 
WHEN HIREDATE like ('10%') THEN    
INTO hiredate_history_10 VALUES(DEPTID,HIREDATE)  
WHEN HIREDATE like ('09%') THEN
INTO hiredate_history_09 VALUES(DEPTID, HIREDATE)
ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

SELECT * FROM special_sal;
SELECT * FROM hiredate_history_10;
SELECT * FROM hiredate_history_09;
SELECT * FROM hiredate_history;
COMMIT;

--�ǹ� INSERT
DESC sales_source_data --�������� Ư�� �� �ϳ� : ������ ������ �÷��� �÷����� �������� �ʰ� ������ ������
SELECT * FROM sales_source_data;
                                 --�ݺ��� �߻��ϴ� �κ��� ���̾ƴ϶� ������ �� �� �ְ� ó���ؾ� ��
 
--�ǹ������� ���ο� ���̺� ����
CREATE TABLE sales_data
(sales_no NUMBER(8),
employee_id NUMBER(6),
WEEK_ID	NUMBER(2),
SALES	NUMBER(8,2));

SELECT * FROM sales_data;

--�ǹ� INSERT �����ϱ�
INSERT ALL
INTO sales_data VALUES (1, employee_id,week_id,sales_MON)  
INTO sales_data VALUES (1, employee_id,week_id,sales_TUE)
INTO sales_data VALUES (1, employee_id,week_id,sales_WED)
INTO sales_data VALUES (1, employee_id,week_id,sales_THUR)
INTO sales_data VALUES (1, employee_id,week_id, sales_FRI)
SELECT EMPLOYEE_ID, week_id, sales_MON, sales_TUE,
       sales_WED, sales_THUR,sales_FRI 
FROM sales_source_data;
SELECT * 
FROM sales_data;

--���������� �� sales ��ȣ(sales_no) ����
CREATE SEQUENCE sales_data_seq
START WITH 101
INCREMENT BY 1
NOCACHE
NOCYCLE;
UPDATE sales_data
SET sales_no = sales_data_seq.nextval;
commit;
SELECT * FROM sales_data;
--����ȭ�� �Ϸ�� ���̺� Ȱ��
SELECT employee_id, SUM(sales) FROM sales_data
WHERE week_id = 6
GROUP BY employee_id
ORDER by 1;
COMMIT;

--�ٽ� �ϰ� �ʹٸ� ó������ ���ư��� @�� �����ϸ� ��
