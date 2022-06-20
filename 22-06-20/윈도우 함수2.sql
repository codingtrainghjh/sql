----------------------------------------------------------------------------------------------------------------------------------------------
--�׷� �� �� ���� ���� �Լ�
--FIRST_VALUE
--��Ƽ�Ǻ� �����쿡�� ���� ���� ���� ���� ���� �� �ִ�.
--sql server ������ �������� ����.

--�μ��� �������� ������ ���� �������� �����ϰ�, ��Ƽ�� ������ ���� ���� ���� ���� ����ϴ� ����

SELECT  department_id, last_name, salary,
        FIRST_VALUE(last_name) OVER (PARTITION BY department_id ORDER BY salary DESC
        ROWS UNBOUNDED PRECEDING) DEPT_RICH
FROM    employees ; 
--�μ��� �������� ������ ���� �������� �����ϰ�, ��Ƽ�� ������ ���� ���� ���� ���� ����ϴ� ����
SELECT  department_id, last_name, salary,
        FIRST_VALUE(last_name) OVER (PARTITION BY department_id ORDER BY salary 
        ROWS UNBOUNDED PRECEDING) DEPT_POOR
FROM    employees ; 

--���� �޿��� �޴� ����� �ִٸ� ������ �����ؾ� �Ѵ�. 
--FIRST_VALUE �� ���� ����� �������� �ʰ� ó�� ���� ���� ó���ϱ� �����̴�. 
--������ �߰��� ����. ���� �޿��� �ִٸ� �̸� ������������ ������ �ȴ�.

SELECT  department_id, last_name, salary,
        FIRST_VALUE(last_name) OVER (PARTITION BY department_id ORDER BY salary , last_name DESC
        ROWS UNBOUNDED PRECEDING) DEPT_POOR
FROM    employees ; 
 
--LAST_VALUE
--��Ƽ�Ǻ� �����쿡�� ���� ���� ���߿� ���� ���� ���� �� �ִ�.
--sql server ������ �������� ����.

--�μ��� �������� ������ ���� �������� �����ϰ�, ��Ƽ�� ������ ���� ���� ���߿� ���� ���� ����ϴ� ����

SELECT  department_id, last_name, salary,
        LAST_VALUE(last_name) OVER (PARTITION BY department_id ORDER BY salary DESC
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) DEPT_POOR
FROM    employees ; 

--ROW BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
-- ���� ���� �����ؼ� ��Ƽ�� ���� ������ ������� ������ �����Ѵ�. 

SELECT  department_id, last_name, salary,
        LAST_VALUE(last_name) OVER (PARTITION BY department_id ORDER BY salary 
        ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) DEPT_RICH
FROM    employees ; 


--LAG
--��Ƽ�Ǻ� �����쿡�� ���� �� ��° ���� ���� ������ �� �ִ�. 
--sql server ������ �������� ����.

--�������� �Ի����ڰ� ���� �������� �����ϰ�, ���κ��� �Ի����ڰ� �� �� �ռ� ����� �޿��� 
--������ �޿��� �Բ� ����ϴ� ����

SELECT  last_name, hire_date, salary, 
        LAG(salary) OVER (ORDER BY hire_date) PREV_SAL
FROM    employees 
WHERE   job_id LIKE 'SA%' ;

--PARTITON BY ���� �߰��� ����
SELECT department_id,  last_name, hire_date, salary, 
        LAG(salary) OVER (PARTITION BY department_id ORDER BY hire_date) PREV_SAL
FROM    employees ;

--LAG �Լ��� 3���� �μ����� ����� �� �ִ�. 
--LAG(SALARY, 2, 0) <-- �� ��° �μ��� �� ��° ���� ���� �������� �����ϴ� ���̰� (����Ʈ�� 1. ���⼭�� 2�� ���������ϱ� 2��° �տ� �ִ� ���� �������� ��), ����° �μ��� ��Ƽ�� ù ��° ���� ��� ������ �����Ͱ� ���� NULL ���� �����µ�, �� ��� �ٸ� ������ �ٲپ��� �� �ִ�.(NVL�� ����)

SELECT  last_name, hire_date, salary,
        LAG(salary,2,0) OVER (ORDER BY hire_date) PREV_SAL
FROM    employees
WHERE   job_id LIKE  'SA%' ; 
-- LAG(SAL,2,0) : �� �� ���� �޿��� ��������, ������ ���� ������ 0���� ó���϶�.

--�μ��� ���� ������� �Ի��Ϻ��� ������ �� ���� ���� �޿��� �Բ� ǥ��, �������� ������ 0���� ǥ��
SELECT department_id,  last_name, hire_date, salary, 
        LAG(salary,1,0) OVER (PARTITION BY department_id ORDER BY hire_date) PREV_SAL
FROM    employees ;

--LEAD
--��Ƽ�Ǻ� �����쿡�� ���� �� ��° ���� ���� ������ �� �ִ�. 
--sql server ������ �������� ����.

--�������� �Ի����ڰ� ���� �������� �����ϰ�, �ٷ� ������ �Ի��� �η��� �Ի����ڸ� �Բ� ����ϴ� ����

SELECT  last_name, hire_date,
        LEAD(hire_date) OVER (ORDER BY hire_date) NEXTHIRED
FROM    employees ;
--LAG ó�� LEAD �Լ��� 3���� �μ����� ����� �� �ִ�. 
SELECT department_id, last_name, hire_date,
        LEAD(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) NEXTHIRED
FROM    employees ;

SELECT department_id, last_name, hire_date,
        LEAD(hire_date, 1, sysdate) OVER (PARTITION BY department_id ORDER BY hire_date) NEXTHIRED
FROM    employees ;

----------------------------------------------------------------------------------------------------------------------------------------------
--�׷� �� ���� ���� �Լ�

--CUME_DIST
--��Ƽ�Ǻ� �������� ��ü�Ǽ����� ���� �ຸ�� �۰ų� ���� �Ǽ��� ���� ����������� ���Ѵ�. 
--sql server ������ �������� ����.

--���� �μ� �Ҽ� ������� ���տ��� ������ �޿��� ���� ������ �� ���� ��ġ�뿡 �ִ��� 0~1 ������ ������ ����ϴ� ����

SELECT  department_id, last_name, salary,
        CUME_DIST() OVER (PARTITION BY department_id ORDER BY salary DESC) CUME_DIST
FROM    employees ;

--��ü ��� �߿��� ������ �޿��� ���� ������ �� ���� ��ġ�뿡 �ִ��� 0~1 ������ ������ ����ϴ� ����
SELECT  department_id, last_name, salary,
        CUME_DIST() OVER ( ORDER BY salary DESC) CUME_DIST
FROM    employees ;

 
--PERCENT_RANK
--��Ƽ�Ǻ� �Լ��� �̿��ؼ� ��Ƽ�Ǻ� �����쿡�� ���� ���� ������ ���� 0����, ���� �ʰ� ������ ���� 1�� �Ͽ�, ���� ������ ������� ���Ѵ�. (���� �ƴ϶� ���� ������ �����)
--sql server ������ �������� ����.

--���� �μ� �Ҽ� ������� ���տ��� ������ �޿��� ������ �� ��° ��ġ�� �ִ��� 0�� 1 ������ ������ ����ϴ� ����

SELECT  last_name, salary,
        PERCENT_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) P_R
FROM    employees;

--department_id 80�� ��� 3�� �̹Ƿ� ������ 2�� �ȴ�. 
--0�� 1 ���̸� 2���� �������� ������ 0, 0.5, 1�� �ȴ�. 
--department_id 50�� ��� 5�� �̰�, ������ 4.
--0�� 1 ���̸� 4�� �������� ������ 0, 0.25, 0.5, 0.75, 1�� �ȴ�. 



--NTILE
--��Ƽ�Ǻ� ��ü �Ǽ��� ARGUMENT ������ N����� ����� ���� �� �ִ�. 

--��ü ����� �޿��� ���� ������ �����ϰ�, �޿��� �������� 4�� �׷����� �з��Ѵ�. 

SELECT  last_name, salary,
        NTILE(4) OVER (ORDER BY salary DESC) QUAR_TILE
FROM    employees ;

--NTILE(4) �� �ǹ̴� ��ü ������ 4�� ���� �����ٴ� �ǹ��̴�. 
--���� ��� 22���� 4���� �������� ������ ���� 5, �������� 2�� �ȴ�. 
--������ �� ���� ���� ������ �Ҵ�ȴ�. 


--RATIO_TO_REPORT 
--��Ƽ�� �� ��ü SUM(�÷�) ���� ���� �ະ �÷� ���� ������� �Ҽ������� ���� �� �ִ�. 
--������� 0���� ũ�� 1���� �� ������ ������. 
--���� ratio �� ���� ���ϸ� 1�� �ȴ�. 
--sql server ������ �������� ����.

--������� �������, ��ü �޿����� ������ �����ϴ� ������ ���ϴ� ����
SELECT  last_name, salary,
        ROUND (RATIO_TO_REPORT(salary) OVER (), 2) P_R
FROM    employees
WHERE   job_id LIKE  'SA%' ;

--��ü ����� �������, ��ü �޿����� ������ �����ϴ� ������ ���ϴ� ����
SELECT  last_name, salary,
        ROUND (RATIO_TO_REPORT(salary) OVER (), 2) P_R
FROM    employees;