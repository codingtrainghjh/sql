--대소문자 변환 문자함수
SELECT UPPER('Oracle Database'),
           LOWER('Oracle Database'),
           INITCAP('Oracle Database')
FROM dual;
SELECT employee_id last_name, UPPER(last_name),
       job_id, INITCAP(job_id)
FROM employees;      
SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = 'king';
SELECT employee_id, last_name, job_id
FROM employees
WHERE LOWER(last_name) = 'king';
SELECT employee_id, last_name, job_id
FROM employees
WHERE last_name = INITCAP('king');
--여러가지 문자 함수
SELECT CONCAT('Oracle','Database') 
FROM dual;
SELECT CONCAT(CONCAT('Oracle',' '), 'Database') 
FROM dual;
SELECT employee_id, CONCAT(first_name, last_name) AS full_name,
              job_id, email
FROM employees;
SELECT employee_id, CONCAT(CONCAT(first_name,' '), last_name) AS full_name,
               job_id, email
FROM employees;
SELECT SUBSTR('Oracle Database', 1,6), SUBSTR('Oracle Database', 8), 
              SUBSTR('Oracle Database', -8,4)
FROM dual;
SELECT * FROM employees
WHERE SUBSTR(last_name, -1,1) = 'n';
SELECT * FROM employees
WHERE last_name LIKE '%n';
SELECT LENGTH('Oracle Database'), LENGTH('오라클 데이터베이스')
FROM dual;
SELECT * FROM employees
WHERE LENGTH(last_name) > 6;
SELECT INSTR('Oracle Database','a') 
FROM dual;
SELECT INSTR('Oracle Database','a', 1,2),INSTR('Oracle Database','a', 1,3)  
FROM dual;
SELECT employee_id, last_name, INSTR(last_name, 'a')
FROM employees;
SELECT employee_id, last_name 
FROM employees
WHERE INSTR(last_name, 'a') = 0;
SELECT employee_id, last_name 
FROM employees
WHERE last_name NOT LIKE '%a%';
SELECT employee_id, RPAD(last_name, 15, '*') AS last_name,
              LPAD(salary, 10, '*') AS salary
FROM employees;
SELECT REPLACE('Jack and Jue','J','Bl') 
FROM dual;
SELECT employee_id, last_name, 
               REPLACE(last_name,SUBSTR(last_name, 2,2),'**') AS result
FROM employees;       
SELECT TRIM('H' FROM 'Hellowold'),  TRIM('d' FROM 'Hellowold') ,
              TRIM('h' FROM 'Hellowold')
FROM dual;
SELECT TRIM('w' FROM 'window'), TRIM(LEADING 'w' FROM 'window'),
               TRIM(TRAILING 'w' FROM 'window')
FROM dual;
SELECT TRIM(0 FROM 0000123456700), TRIM(LEADING 0 FROM 0000123456700)  
FROM dual;
SELECT TRIM('xy' FROM 'xyxyxykkkkxy') 
FROM dual;
--문자함수응용예제
SELECT employee_id, CONCAT(first_name, last_name) NAME, 
               job_id, LENGTH (last_name), 
               INSTR(last_name, 'a') "Contains 'a'?"
FROM   employees
WHERE  SUBSTR(job_id, 4) = 'REP';
--숫자함수
SELECT ROUND(45.923,2), ROUND(45.923), ROUND(45.923,-1)
FROM   DUAL;
SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM   DUAL;
SELECT last_name, salary, MOD(salary, 5000)
FROM   employees
WHERE  job_id = 'SA_REP';
--날짜연산
SELECT sysdate 
FROM dual;
SELECT sysdate, sysdate+10 
FROM dual;
SELECT employee_id, last_name, hire_date, sysdate-hire_date AS 근무일수
FROM employees;
SELECT employee_id, last_name, hire_date, 
              TRUNC(sysdate-hire_date) AS 근무일수
FROM employees;
SELECT last_name, ROUND((SYSDATE-hire_date)/7) AS WEEKS
FROM   employees
WHERE  department_id = 90;
--날짜함수
SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS 근무기간
FROM employees;
SELECT ADD_MONTHS(sysdate, 3), LAST_DAY(sysdate)
FROM dual;
SELECT NEXT_DAY(sysdate, '금요일'), NEXT_DAY(sysdate, '금'),
               NEXT_DAY(sysdate, 6)
FROM dual;      
SELECT NEXT_DAY(sysdate, 'FRIDAY') 
FROM dual;
SELECT sysdate, ROUND(sysdate, 'year'), ROUND(sysdate, 'month'), 
              ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;       
SELECT sysdate, TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'), 
       TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;