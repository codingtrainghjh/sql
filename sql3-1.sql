SELECT last_name, email, job_id
FROM employees;

--UPPER �ԷµǴ� ���� ���� �빮�ڷ� ��ȯ
--LOWER �ԷµǴ� ���� ���� �ҹ��ڷ� ��ȯ
--INITCAP ù���ڸ� �빮�ڷ� ����ϰ� �������� �ҹ��ڷ� ��ȯ
SELECT UPPER (last_name),  LOWER (email), INITCAP(job_id) 
FROM employees;

SELECT UPPER ('oracle database'),  LOWER ('ORACLE DATABASE'), INITCAP('ORACLE DATABASE')
FROM dual;

SELECT 12324+32123
FROM dual;

SELECT employee_id, CONCAT(first_name, last_name) AS fullname, salary --�յ� ����
FROM employees;
SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) AS fullname, salary
FROM employees;
SELECT employee_id, last_name, CONCAT(email, '@yd.com') AS email_addr
FROM employees;

--�� �μ���° ���ڿ��� �� �μ� ���ڸ�ŭ ���, 
--�� ���� ���� ��� �� �׿��� ������ ��ġ���� ��� ���, 
--������ ���� ����
SELECT SUBSTR('oracle database', 1,6), SUBSTR('oracle database', 8,4), SUBSTR('oracle database', 8),
            SUBSTR('oracle database', -4,4)
FROM dual;

SELECT employee_id, last_name, SUBSTR(last_name, 1,3)
FROM employees
WHERE SUBSTR(last_name, -1,1)='s';

SELECT employee_id, last_name, SUBSTR(last_name, 1,3)
FROM employees
WHERE last_name LIKE '%s';

SELECT employee_id, last_name, LENGTH(last_name) --���� ��
FROM employees;

SELECT LENGTH('oracle database'), LENGTH('����Ŭ �����ͺ��̽�')--��� ���ڵ� ������ ��
FROM dual;
SELECT LENGTHB('oracle database'), LENGTHB('����Ŭ �����ͺ��̽�') --������ ũ�� ��
FROM dual;

SELECT employee_id, last_name, INSTR(last_name,'a') --���� �μ��� �� ���� �μ����� ���°���� �������� �� �� ����
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name,'a')=0; --Ư�� ������ ��ġ�� ã�� ��ȯ
SELECT *
FROM employees
WHERE last_name NOT LIKE '%a%';

SELECT employee_id, RPAD(last_name,9,'*'), LPAD(salary, 15, '*') --�� Ȥ�� �쿡������/���� ���� /2��° �μ���ŭ ũ�⸦ �����ϰ�/ ���� ũ�⸸ŭ 3��° �μ��� ä����
FROM employees;

SELECT TRIM('o' FROM 'oracle database') --���� �ܾ�� ���� ' '�� �߶󳻶�(���̾� Ȥ�� ���ξ ����, �߰��� �ִ°� �Ұ���)
FROM dual;

SELECT TRIM('w' FROM 'window'),
            TRIM(LEADING 'w' FROM 'window'),
            TRIM(TRAILING 'w' FROM 'window')
FROM dual;

SELECT employee_id, last_name, 
           CONCAT('+82', TRIM(LEADING '0' FROM phone_number))
FROM employees;

SELECT TRIM ('0' FROM '000000123001122')
FROM dual;
SELECT TRIM ('01' FROM '01010101010000123001122') --�� ���ڸ� ���� ����
FROM dual;
SELECT LTRIM ('01010101010000123001122', '01') --���ʺ��� ������ ���� ���� �� ����
FROM dual;
SELECT RTRIM(LTRIM ('01010101010000123001122', '01'), '01') --�����ʺ���..
FROM dual;

SELECT REPLACE('Jack and Jue', 'J', 'Bl') --���� ���� Ȥ�� ����/�ι�° �μ���/����° �μ��� ��ȯ�Ͽ���
FROM dual;

SELECT employee_id, last_name,
           REPLACE (last_name, SUBSTR(last_name, 2, 2), '**')
FROM employees;

SELECT *
FROM employees
WHERE LOWER (last_name) = 'king';
