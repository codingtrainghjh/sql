SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees;
--WHERE 절의 기본 사용법
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id = 50; --기준점으로 삼겠다
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id >= 50;
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id <> 50;
--문자데이터의 비교
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name = 'king';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name = 'King'; --작은따옴표 안의 문자는 대소문자 구별
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name <> 'King';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name >= 'King';
--날짜 데이터의 비교
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '97/09/17'; --날짜는 문자 같은 타입도 존재함
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '1997/09/17';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '1997-09-17';
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date = '17-09-1997'; --테이블에 저장 된 순서와 일치해야함
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE hire_date > '1997/09/17'; --연산자 이용해서 비교 가능
--SQL비교연산자(IN/LIKE//BETWEEN/IS NULL)
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE department_id IN (50,60,80); --기준을 여러개 삼을 때
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name IN('De Haan','Abel');
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE 'K%'; --'K'로 시작하는 사람을 찾아라
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE '%a%'; --위치 상관없이 'a'가 들어간 사람을 찾아라
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE '%s';  --'s'로 끝나는 사람을 찾아라
SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name LIKE '____'; --이름이 4글자인 사람을 찾아라, 다운슬래시를 칸수로 봄 
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE job_id LIKE 'IT\_%' ESCAPE '\'; --단순한 문자로 해석되도록 하는 명령어(역슬래시)
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE salary BETWEEN 9000 AND 6000 ; --이상과 이하
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE last_name BETWEEN 'Abel' AND 'King';
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE hire_date BETWEEN '99/01/01' AND'99/12/31';
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id is null;--NULL을 검색하는 유일한 연산자,NULL은 어떤 연산자와도 호응이 안됨
--논리 연산자(AND/OR/NOT)
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE department_id IN(50,60,80)
AND salary > 9000;

SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE department_id IN(50,60,80)
OR salary > 9000; --두 조건 중 하나를 만족시키면 나오라

SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE (department_id = 50
OR department_id = 60)
AND salary > 8000; --OR과 AND가 같이 있을 경우 AND를 먼저 연산

SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE last_name NOT LIKE 'K%';
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE salary NOT BETWEEN 9000 AND 6000 ;
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE department_id NOT IN(50,60,80);
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id IS NOT NULL;

--결과를 정렬하기(ORDER BY 절의 사용)
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY salary DESC; --DESC는 내림차순
SELECT employee_id, last_name, hire_date,salary, department_id, job_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY hire_date DESC;

SELECT employee_id, last_name, hire_date,salary, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY department_id DESC, salary DESC; --ASC가 기본이므로 모두 내림차순으로 정렬하고 싶다면 모든 column에 지정해주어야함

SELECT employee_id, last_name, hire_date,salary*12 AS 연봉, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY department_id, salary*12;
SELECT employee_id, last_name, hire_date,salary*12 AS 연봉, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY department_id, 연봉 DESC; --별칭으로 지정 가능

SELECT employee_id, last_name, hire_date,salary*12 AS 연봉, department_id
FROM employees
WHERE  department_id IS NOT NULL
ORDER BY 5,4 DESC; --포지션 번호로 지정 가능

SELECT employee_id, last_name, hire_date,salary*12 AS 연봉, department_id
FROM employees
WHERE 연봉 > 120000 --WHERE절에서는 별칭을 허용하지 않음
ORDER BY 5,4 DESC;