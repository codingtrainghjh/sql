SELECT last_name, email, job_id
FROM employees;

--UPPER 입력되는 값을 전부 대문자로 전환
--LOWER 입력되는 값을 전부 소문자로 전환
--INITCAP 첫글자만 대문자로 출력하고 나머지는 소문자로 전환
SELECT UPPER (last_name),  LOWER (email), INITCAP(job_id) 
FROM employees;

SELECT UPPER ('oracle database'),  LOWER ('ORACLE DATABASE'), INITCAP('ORACLE DATABASE')
FROM dual;

SELECT 12324+32123
FROM dual;

SELECT employee_id, CONCAT(first_name, last_name) AS fullname, salary --앞뒤 연결
FROM employees;
SELECT employee_id, CONCAT(CONCAT(first_name, ' '), last_name) AS fullname, salary
FROM employees;
SELECT employee_id, last_name, CONCAT(email, '@yd.com') AS email_addr
FROM employees;

--앞 인수번째 숫자에서 뒷 인수 문자만큼 출력, 
--뒷 항이 없을 경우 앞 항에서 지정한 위치부터 모두 출력, 
--음수로 지정 가능
SELECT SUBSTR('oracle database', 1,6), SUBSTR('oracle database', 8,4), SUBSTR('oracle database', 8),
            SUBSTR('oracle database', -4,4)
FROM dual;

SELECT employee_id, last_name, SUBSTR(last_name, 1,3)
FROM employees
WHERE SUBSTR(last_name, -1,1)='s';

SELECT employee_id, last_name, SUBSTR(last_name, 1,3)
FROM employees
WHERE last_name LIKE '%s';

SELECT employee_id, last_name, LENGTH(last_name) --글자 수
FROM employees;

SELECT LENGTH('oracle database'), LENGTH('오라클 데이터베이스')--어느 문자든 갯수만 비교
FROM dual;
SELECT LENGTHB('oracle database'), LENGTHB('오라클 데이터베이스') --데이터 크기 비교
FROM dual;

SELECT employee_id, last_name, INSTR(last_name,'a') --지정 인수가 앞 항의 인수에서 몇번째에서 나오는지 셀 때 쓰임
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name,'a')=0; --특정 글자의 위치를 찾아 반환
SELECT *
FROM employees
WHERE last_name NOT LIKE '%a%';

SELECT employee_id, RPAD(last_name,9,'*'), LPAD(salary, 15, '*') --좌 혹은 우에서부터/지정 열을 /2번째 인수만큼 크기를 지정하고/ 남는 크기만큼 3번째 인수로 채워라
FROM employees;

SELECT TRIM('o' FROM 'oracle database') --지정 단어로 부터 ' '를 잘라내라(접미어 혹은 접두어만 가능, 중간에 있는것 불가능)
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
SELECT TRIM ('01' FROM '01010101010000123001122') --한 문자만 지정 가능
FROM dual;
SELECT LTRIM ('01010101010000123001122', '01') --왼쪽부터 복수의 문자 지정 후 삭제
FROM dual;
SELECT RTRIM(LTRIM ('01010101010000123001122', '01'), '01') --오른쪽부터..
FROM dual;

SELECT REPLACE('Jack and Jue', 'J', 'Bl') --지정 문자 혹은 열의/두번째 인수를/세번째 인수로 변환하여라
FROM dual;

SELECT employee_id, last_name,
           REPLACE (last_name, SUBSTR(last_name, 2, 2), '**')
FROM employees;

SELECT *
FROM employees
WHERE LOWER (last_name) = 'king';
