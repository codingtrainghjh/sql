--MERGE �� �׽�Ʈ
--�ǽ��� ���� emp13 ���̺� ����
@C:\DB\db_test\sql_labs\cre_emp13.sql
--����Ȯ��(4���� ���, 200�� �μ�, commission_pct�� ��� 0.4)
SELECT * FROM emp13;
SELECT * FROM employees;
SELECT employee_id, commission_pct, department_id
FROM employees
WHERE employee_id IN (200,149,174, 176);
--MERGE �� ����
MERGE INTO emp13 c
     USING employees e
     ON (c.employee_id = e.employee_id)
   WHEN MATCHED THEN --�� ������ �����ϴٸ�
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
      DELETE WHERE (e.commission_pct IS NULL) --employees���� commission_pct�� null�� ���� ���ܵ�
   WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id, --���̺��� �ѹ��� �а� �������� ����
          e.salary, e.commission_pct, e.department_id);
COMMIT;
SELECT * FROM emp13;