--TOP-n ����
SELECT rownum AS rank, employee_id, last_name, salary
FROM (SELECT employee_id, last_name, salary
                    FROM employees
                    ORDER BY salary DESC) --���� ���������� order by�� �ǹ̰� ����
WHERE rownum <= 5;

SELECT rownum AS rank, employee_id, last_name, salary
FROM (SELECT employee_id, last_name, salary
                    FROM employees
                    ORDER BY salary)
WHERE rownum <= 5;

--�������Լ���? 
--��� �� ���� ���踦 ���� �����ϱ� ���� ���� �Լ��� ������ �Լ���. 
--������ �Լ��� �м� �Լ��� ���� �Լ��ε� �˷��� �ִ�. 
--������ �Լ��� ������ ����ϴ� ���� �Լ��� �ְ� ���� ������ �Լ��� �ִ�.
--������ �Լ��� �ٸ� �Լ��� �޸� ��ø�ؼ� ����� ��������, ������������ ����� �� �ִ�. 

--WINDOW FUNCTION �� ������ ���� �з��� �� �ִ�. (�������� �����ϴ� �Լ� ���̰� ����)
--
--- �׷� �� ����(RANK) ���� �Լ�: RANK, DENSE_RANK, ROW_NUMBER
--- �׷� �� ����(AGGREGATE) ���� �Լ� : SUM, MAX, MIN, AVG, COUNT (sql server�� OVER ���� OREDER BY ���� X)
--- �׷� �� �� ���� ���� �Լ� : FIRST_VALUE, LAST_VALUE, LAG, LEAD (����Ŭ������ ����)
--- �׷� �� ���� ���� �Լ� : CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT
--
--WINDOW FUNCTION ����
--������ �Լ����� OVER ������ Ű����� �ʼ� ���Եȴ�.
--
--SELECT WINDOW_FUNCTION (ARGUMENTS) OVER --arguments�� ������, �ȵ����� �ִ�.
--( [PARTITION BY �÷�] [ORDER BY �÷�] [WINDOWING ��] )
--FROM ���̺�� ; 
--
--
--WINDOW_FUNCTION : ������ �Լ� 
--ARGUMENTS(�μ�) : �Լ��� ���� 0 ~ N�� �μ��� ������ �� �ִ�. 
--PARTITION BY �� : ��ü ������ ���ؿ� ���� �ұ׷����� ���� �� �ִ�.   
--ORDER BY �� : � �׸� ���� ������ ������ �� order by ���� ����Ѵ�.
--WINDOWING �� : WINDOWING ���� �Լ��� ����� �Ǵ� �� ������ ������ �����ϰ� ������ �� �ִ�. (sql server ������ �������� ����)

--------------------------------------------------------------

--�׷� �� ����(RANK) ���� �Լ�
--RANK
-- ������ ���ϴ� �Լ�.
-- Ư�� ����(PARTITION) ������ ������ ���� ���� �ְ�, ��ü �����Ϳ� ���� ������ ���� ���� �ִ�. 
-- ������ ���� ���ؼ��� ������ ������ �ο��ϰ� �ȴ�. 

--��� �����Ϳ��� �޿��� ���� ������ ����ϴ� ����
SELECT job_id, last_name, salary,
         RANK() OVER (ORDER BY salary DESC) ALL_RANK    
FROM     employees ;  
--������ �޿��� �ִٸ� ���� ������ �ο��Ѵ�. 

--��� �����Ϳ���  �������� �޿��� ���� ������ ����ϴ� ����
SELECT job_id, last_name, salary,
         RANK() OVER (PARTITION BY job_id ORDER BY salary DESC) JOB_RANK -- job_id ���� �޿� ���� ��
FROM     employees ;    
--������ �޿��� �ִٸ� ���� ������ �ο��Ѵ�. 
--PARTITION ���� ������ JOB_RANK �� ���� ���� ���� �������� ������ �ο��Ѵ�. 
SELECT department_id, last_name, salary,
         RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) JOB_RANK -- department_id ���� �޿� ���� ��
FROM     employees ;    
--�μ����� �Ի����� ���� ������� ������ ����Ͻÿ�
SELECT department_id, hire_date,
         RANK() OVER (PARTITION BY department_id ORDER BY hire_date) HIRED_RANK -- department_id ���� �Ի簡 ���� ��
FROM     employees ;    

--DENSE_RANK
-- RANK�� ���������, ������ ������ �ϳ��� �Ǽ��� ����Ѵ�. 
-- RANK�� 1, 1, 3 ����(1���� �ΰ� �̴� 2�� ���� 3�� ǥ��) �� ǥ��������, DENSE_RANK��1,1,2  ������ �ο��Ѵ�. 

SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
         DENSE_RANK() OVER (ORDER BY salary DESC) DENSE_RANK 
FROM     employees ;          
 
--ROW_NUMBER
-- RANK, DENSE_RANK �� ������ ���� ���ؼ��� ������ ������ �ο��ϴµ� ����, 
-- ROW_NUMBER �� ������ ���̶� ������ ������ �ο��Ѵ�. 

SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
         ROW_NUMBER() OVER (ORDER BY salary DESC) ROW_NUMBER
FROM     employees ;          
--ROW_NUMBER �� ������ ������ �����ϱ� ���� ����ũ�� ������ ���Ѵ�. 
--������ ������ ���ؼ��� � ������ �������� �� �� ����. (Oracle�� ��� rowid�� ���� ���� ���� ���´�) �� �κ��� �����ͺ��̽� ���� Ʋ�� ����� ���� �� �����Ƿ�, ���� ���� ���� ���� �������� �����ϰ� ������ ROW_NUMBER( ) OVER (ORDER BY salary DESC, last_name) ���� ORDER BY ���� �̿��� �߰����� ���� ������ �����ؾ� �Ѵ�.

-- �߰� ���� ���� ���� ���� 
SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
          ROW_NUMBER( ) OVER (ORDER BY salary DESC, last_name)  ROW_NUMBER
FROM     employees ;  

SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
          ROW_NUMBER( ) OVER (ORDER BY salary DESC, last_name DESC)  ROW_NUMBER
FROM     employees ;  

------------------------------------------------------------------------------------------------------------------------
--�׷� �� ����(AGGREGATE) ���� �Լ�

--SUM
-- SUM �Լ��� �̿��ؼ� ��Ƽ�Ǻ� �������� ���� ���� �� �ִ�. 
-- ���� �Ŵ����� �ΰ� �ִ� ������� �޿� ���� ���ϴ� ����

SELECT manager_id, employee_id, last_name, salary, 
       SUM(salary) OVER (PARTITION BY manager_id) MGR_SUM
FROM   employees ;

--OVER ���� ORDER BY ���� �߰��ؼ� ��Ƽ�� �� �����͸� �����ϰ� ���� �޿� �����ͱ����� �������� ����ϴ� ����

SELECT manager_id, employee_id, last_name, salary, 
       SUM(salary) OVER (PARTITION BY manager_id ORDER BY salary RANGE UNBOUNDED PRECEDING) MGR_SUM
FROM   employees ;

--RANGE UNBOUNDED PRECEDING ;
-- ���� ���� �������� ��Ƽ�� ���� ù ��° ����� ������ �����Ѵ�.
 


--MAX
-- ��Ƽ�Ǻ� �������� �ִ밪�� ���� �� �ִ�. 
-- ���� �Ŵ����� �ΰ� �ִ� ������� �޿� �� �ִ밪�� ���ϴ� ����

SELECT manager_id, last_name, salary, 
       MAX(salary) OVER (PARTITION BY manager_id) MGR_MAX
FROM   employees ;

--���� �μ��� ������� �޿� �� �ִ밪�� ���ϴ� ���� 
SELECT department_id, last_name, salary, --�׷쵥���Ϳ� ���ε����͸� ���� ��
       MAX(salary) OVER (PARTITION BY department_id) MGR_MAX
FROM   employees ;


--INLINE VIEW�� �̿��ؼ� ��Ƽ�Ǻ� �ִ밪�� ���� �ุ ������ ���� �ִ�.

SELECT manager_id, last_name, salary
FROM   (SELECT manager_id, last_name, salary, 
               MAX(salary) OVER (PARTITION BY manager_id) IV_MAX_SAL
        FROM   employees )
WHERE  salary =  IV_MAX_SAL ;

SELECT department_id, last_name, salary
FROM   (SELECT department_id, last_name, salary, 
               MAX(salary) OVER (PARTITION BY department_id) IV_MAX_SAL
        FROM   employees )
WHERE  salary =  IV_MAX_SAL ;
 

--MIN
--��Ƽ�Ǻ� �������� �ּҰ��� ���� �� �ִ�. 

--���� �μ����� �ٹ��ϴ� �������  �޿� �ּҰ��� ���� ���ϴ� ����

SELECT department_id, last_name, hire_date, salary, 
       MIN(salary) OVER (PARTITION BY department_id) DEPT_MIN
FROM   employees ;
 

--AVG
--�ҼӺμ��� ����� �� ����� �޿��� �Բ� ǥ���� �� �ִ�.
SELECT department_id, last_name, hire_date, salary, 
       TRUNC(AVG(salary) OVER (PARTITION BY department_id)) DEPT_MIN
FROM   employees ;

--AVG �Լ��� Ȱ���Ͽ� ��Ƽ�Ǻ� ��谪�� ���� �� �ִ�.
 
--���� �μ����� �ٹ��ϴ� ������� ��� �޿��� ���ϵ�, 
--���� �μ� ������ �ڱ� �ٷ� ���� ����� �ٷ� ���� ����� ������ ������θ� �ϴ� ���� 
--( �� �� + ������ + �� ���� ���� 3���� ������ ����. 
--���� ������ ���ٸ� ������ + �� ���� ���� 2�� ������ �ȴ�)

SELECT department_id, last_name, hire_date, salary, 
       ROUND (AVG(salary) OVER (PARTITION BY department_id ORDER BY hire_date
       ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) ) DEPT_AVG
FROM   employees ;

--COUNT
--������� �޿� �������� �����ϰ�, ���� �޿����� 50 ���� ���ų�, 100 ���Ϸ� ���� �޿��� �޴� �ο����� ����ϴ� ����

SELECT last_name, salary,
       COUNT(*) OVER (ORDER BY salary RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING) SIM_CNT
FROM   employees ;

--RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING ;
-- ���� ���� �޿����� �������� �ݿ��� -50 ~ +100 ���� ���� ���Ե� ��� ���� ����� �ȴ�. 
-- range�� ���� ���� ������ ���� �������� �� �� ������ ���� ������ ǥ���ϴ� ����.

