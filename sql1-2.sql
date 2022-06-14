SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees;
--WHERE ���� �⺻ ����
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id = 50; --���������� ��ڴ�
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id >= 50;
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id <> 50;
--���ڵ������� ��
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name = 'king';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name = 'King'; --��������ǥ ���� ���ڴ� ��ҹ��� ����
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name <> 'King';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name >= 'King';
--��¥ �������� ��
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '97/09/17'; --��¥�� ���� ���� Ÿ�Ե� ������
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '1997/09/17';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '1997-09-17';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '17-09-1997'; --���̺� ���� �� ������ ��ġ�ؾ���
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date > '1997/09/17'; --������ �̿��ؼ� �� ����
--SQL�񱳿�����(IN/LIKE//BETWEEN/IS NULL)
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id IN (50,60,80); --������ ������ ���� ��
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name IN('De Haan','Abel');
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE 'K%'; --'K'�� �����ϴ� ����� ã�ƶ�
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE '%a%'; --��ġ ������� 'a'�� �� ����� ã�ƶ�
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE '%s';  --'s'�� ������ ����� ã�ƶ�
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE '____'; --�̸��� 4������ ����� ã�ƶ�, �ٿ���ø� ĭ���� �� 
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE job_id LIKE 'IT\_%' ESCAPE '\'; --�ܼ��� ���ڷ� �ؼ��ǵ��� �ϴ� ��ɾ�(��������)
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE salary BETWEEN 9000 AND 6000 ; --�̻�� ����
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE last_name BETWEEN 'Abel' AND 'King';
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE hire_date BETWEEN '99/01/01' AND'99/12/31';
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id is null;--NULL�� �˻��ϴ� ������ ������,NULL�� � �����ڿ͵� ȣ���� �ȵ�
--�� ������(AND/OR/NOT)
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE department_id IN(50,60,80)
AND salary > 9000;

SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE department_id IN(50,60,80)
OR salary > 9000; --�� ���� �� �ϳ��� ������Ű�� ������

SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE (department_id = 50
OR department_id = 60)
AND salary > 8000; --OR�� AND�� ���� ���� ��� AND�� ���� ����

SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name NOT LIKE 'K%';
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE salary NOT BETWEEN 9000 AND 6000 ;
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE department_id NOT IN(50,60,80);
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id IS NOT NULL;

--����� �����ϱ�(ORDER BY ���� ���)
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY salary DESC; --DESC�� ��������
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY hire_date DESC;

SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY department_id DESC, salary DESC; --ASC�� �⺻�̹Ƿ� ��� ������������ �����ϰ� �ʹٸ� ��� column�� �������־����

SELECT employee_id, last_name, hire_date,salary*12 AS ����, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY department_id, salary*12;
SELECT employee_id, last_name, hire_date,salary*12 AS ����, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY department_id, ���� DESC; --��Ī���� ���� ����

SELECT employee_id, last_name, hire_date,salary*12 AS ����, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY 5,4 DESC; --������ ��ȣ�� ���� ����

SELECT employee_id, last_name, hire_date,salary*12 AS ����, department_id
FROM employees
WHERE ���� > 120000 --WHERE�������� ��Ī�� ������� ����
ORDER BY 5,4 DESC;