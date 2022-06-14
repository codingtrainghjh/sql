--��¥�����Ϳ� TO_CHAR �Լ� ���
SELECT
    employee_id,
    last_name,
    hire_date
FROM
    employees;

SELECT
    employee_id,
    last_name,
    to_char(hire_date, 'dd-mm-yyyy')
FROM
    employees;

SELECT
    employee_id,
    last_name,
    to_char(h.ire_date, 'yyyy')
FROM
    employees;

SELECT
    employee_id,
    last_name,
    to_char(hire_date, 'yyyy-mm-dd day') AS hire_date,
    to_char(hire_date, 'q')              AS �б�,
    to_char(hire_date, 'w')
    || '����'                              AS �ּ�
FROM
    employees;

SELECT
    employee_id,
    last_name,
    to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss')
FROM
    employees;
--��¥ ���꿡 ����
SELECT
    to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
    to_char(sysdate + 3 / 24, 'yyyy/mm/dd hh24:mi:ss'),
    to_char(sysdate + 40 /(24 * 60), 'yyyy/mm/dd hh24:mi:ss')
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy/mm/dd hh:mi:ss am') --�ð� ǥ��
FROM
    dual;

--���ڵ����Ϳ� TO_CHAR ����ϱ�
SELECT
    employee_id,
    last_name,
    salary,
    to_char(salary, '$999,999') --���� ǥ���� �ƴ� �ڸ��� ǥ��
FROM
    employees;

SELECT
    employee_id,
    last_name,
    salary,
    to_char(salary, '$999,999.99'),
    to_char(salary, '$099,999.99')
FROM
    employees;

SELECT
    employee_id,
    last_name,
    salary,
    to_char(salary, 'L999,999')
FROM
    employees;

ALTER SESSION SET nls_territory = germany;

SELECT
    employee_id,
    last_name,
    salary,
    to_char(salary, 'L999,999')
FROM
    employees;

ALTER SESSION SET nls_territory = korea;

SELECT
    employee_id,
    last_name,
    salary,
    to_char(salary, 'L999,999')
FROM
    employees;
--TO_DATE �Լ�
SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM
    employees
WHERE
    hire_date > '12/31/1999';

SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM
    employees
WHERE
    hire_date > TO_DATE('31/12/1999', 'dd/mm/yyyy');

SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM
    employees
WHERE
    hire_date > TO_DATE('31/12/99', 'dd/mm/yy');

SELECT
    employee_id,
    last_name,
    salary,
    hire_date
FROM
    employees
WHERE
    hire_date > TO_DATE('31/12/99', 'dd/mm/rr');
--TO_NUMBER �Լ�
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > $8,000;
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > '$8,000';
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000','$9,999');
--�Լ���ø
SELECT last_name,
              UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US'))
FROM   employees
WHERE  department_id = 60;
--�Ϲ��Լ� NVL
SELECT employee_id, last_name, salary, commission_pct
FROM employees;
SELECT employee_id, last_name, salary, NVL(commission_pct, 0) --null���� �μ��� �ٲ�
FROM employees;
SELECT employee_id, last_name, salary+salary*commission_pct as monthly_sal
FROM employees;
SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal
FROM employees;
--�Ϲ��Լ� NVL2
SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              NVL2(commission_pct, 'Y', 'N') AS comm_get--null�� �ƴϸ� 2��°, null�̸� 3��°
FROM employees;
SELECT last_name,  salary, commission_pct,
              NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM   employees 
WHERE department_id IN (50, 80);
--�Ϲ��Լ� NULL IF
SELECT employee_id, last_name, 
               salary+salary*NVL(commission_pct,0) as monthly_sal,
               NVL2(commission_pct, 'Y', 'N') AS comm_get,
               NULLIF(salary,  salary+salary*NVL(commission_pct,0)) AS result --�μ����� ������ null�� ������ �Լ�
FROM employees;
SELECT first_name, LENGTH(first_name) "expr1", 
              last_name,  LENGTH(last_name)  "expr2",
             NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM   employees;
--�Ϲ��Լ� COALESCE
SELECT employee_id, commission_pct, manager_id,
              COALESCE(commission_pct, manager_id, 1234) AS result --null���� ó������ ���� ��ȯ�ϴ� �Լ�
FROM employees;  
SELECT last_name, employee_id,
              COALESCE(TO_CHAR(commission_pct),TO_CHAR(manager_id), 'No commission and no manager') 
FROM employees;
--CASE ���� ���     
SELECT last_name, job_id, salary,
              CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                                    WHEN 'ST_CLERK' THEN  1.15*salary
                                    WHEN 'SA_REP'   THEN  1.20*salary
                                    ELSE      salary END     "REVISED_SALARY"
FROM   employees;
SELECT last_name, job_id, salary,
              CASE  WHEN job_id = 'IT_PROG'  THEN  1.10*salary
                          WHEN job_id = 'ST_CLERK' THEN  1.15*salary
                          WHEN job_id ='SA_REP'   THEN  1.20*salary
                          ELSE      salary END     "REVISED_SALARY"
FROM   employees;
SELECT employee_id, last_name, salary,
              CASE WHEN salary < 5000 THEN 'L'
                         WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
                         ELSE 'H' END AS salary_grade
FROM employees;       
--NVL2 �Լ� ����� CASE ������ ��ü 
SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              CASE WHEN commission_pct IS NOT NULL THEN 'Y'
                         ELSE 'N' END AS comm_get
FROM employees;
--DECODE �Լ� 
SELECT last_name, job_id, salary,
             DECODE(job_id, 'IT_PROG',  1.10*salary,
                                          'ST_CLERK', 1.15*salary,
                                          'SA_REP',   1.20*salary,
                                                                        salary)  AS  REVISED_SALARY
FROM   employees;
SELECT last_name, salary,
               DECODE (
    trunc(salary / 2000, 0),
    0,
    0.00,
    1,
    0.09,
    2,
    0.20,
    3,
    0.30,
    4,
    0.40,
    5,
    0.42,
    6,
    0.44,
    0.45
) TAX_RATE
FROM   employees
WHERE  department_id = 80;