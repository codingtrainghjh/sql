--����
--         -UNION[ALL]- ������
-- select -INTERSECT-   ������ select
--         -MINUS-   ����

--         -UNION[ALL]- 
SELECT employee_id, department_id FROM employees
UNION --�ߺ� �� ����
SELECT employee_id, department_id FROM job_history;

SELECT employee_id, department_id FROM employees
UNION 
SELECT employee_id, department_id FROM job_history
ORDER BY 1; --������  �� ����, �����ϰ� �ǹǷ� ���� ����

SELECT employee_id �����ȣ, department_id FROM employees -- ù��° ���忡 ��Ī�� �־�߸� ������ �ȴ�.
UNION 
SELECT employee_id, department_id �μ���ȣ FROM job_history;

SELECT employee_id �����ȣ, department_id �μ���ȣ FROM employees 
UNION ALL
SELECT employee_id, department_id FROM job_history;

--     -INTERSECT-
SELECT employee_id, department_id FROM employees
INTERSECT --�Ի� �� ���� Ȥ�� �μ��� ������ �־��ٰ� ���ƿ� ����
SELECT employee_id, department_id FROM job_history;

--         -MINUS-
SELECT employee_id, department_id FROM employees
MINUS --�Ի� �� ���������̳� �μ������� ������ ����
SELECT employee_id, department_id FROM job_history;

SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;

SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN
                                (SELECT employee_id FROM employees
                                 MINUS
                                 SELECT employee_id FROM job_history);
                                 
SELECT employee_id FROM job_history
MINUS --����� ����
SELECT employee_id FROM employees;

--�÷� ������ ���߱�
SELECT employee_id, job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

--column���� 