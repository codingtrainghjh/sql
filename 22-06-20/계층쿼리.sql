--������ ���� ������ ������ ���� "��������"
--��������
--�����(Top-Down)
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id; --connect by prior(�������� �����ȣ�� �������� �Ŵ�����ȣ�� ����ȴ�) �������
--CONNECT BY manager_id = PRIOR employee_id; -- prior�� �������� ������(����� �����)

--102���� ���������� ����� �˻�
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 102
CONNECT BY PRIOR employee_id = manager_id;

--�����(Bottom-Up) �˻�
SELECT LEVEL, employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 144
CONNECT BY  employee_id = PRIOR manager_id;

--LEVEL���� ǥ��
SELECT LEVEL, employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id;

SELECT LEVEL, employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 102
CONNECT BY PRIOR employee_id = manager_id;

--����� ��ü������ ����ϴ� ���
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'-')
       AS org_chart
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--�������� ���� �Լ�
--CONNECT_BY_ISLEAF : �ش� ���� LEAF �̸� 1�� ��ȯ
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart, CONNECT_BY_ISLEAF AS isleaf
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--����� �˻������� LEAF
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart, CONNECT_BY_ISLEAF AS isleaf
FROM   employees 
START WITH employee_id = 144
CONNECT BY   employee_id= PRIOR manager_id ;

--SYS_CONNECT_BY_PATH : Root���� ���� ������� ��� ǥ��
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart,  SYS_CONNECT_BY_PATH(employee_id,'/') path
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--CONNECT_BY_ROOT : ���� ��������� ROOT �� ǥ��
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart,  CONNECT_BY_ROOT(last_name) isroot
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--������� Ư�� ������ �����ϴ� ��
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'-')
       AS org_chart
FROM   employees 
WHERE employee_id <> 101 --�ش� �ุ ����
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--������� Ư�� ������ �����ϴ� ��2
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'-')
       AS org_chart
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id
AND employee_id <> 101; --�ش� �ุ ����