SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = &�μ���ȣ; --ġȯ����(���ڷ� �ִٰ� ���� �Է��ϸ� ��ȯ�Ǵ� ����)

SELECT employee_id, last_name, salary
FROM employees
WHERE last_name = '&����̸�'; --��¥�� ���ڿ� ���� ġȯ������ ''�� ������� ��

SELECT employee_id, last_name, salary, &column_name --�� �̸����� ã��
FROM employees;

SELECT employee_id, last_name, salary, &column_name
FROM employees
ORDER BY &column_name; --���� �̸��̶� �ٸ� ������ ��� ����

SELECT employee_id, last_name, salary, &&column_name --���� �̸��� ������ �ӱݰ� �ִٰ� �Ѱ���
FROM employees
ORDER BY &column_name;

DEFINE column_name --���� ġȯ
UNDEFINE column_name --���� ����
DEFINE column_name