SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = &부서번호; --치환변수(문자로 있다가 값을 입력하면 변환되는 변수)

SELECT employee_id, last_name, salary
FROM employees
WHERE last_name = '&사원이름'; --날짜나 문자에 대한 치환변수는 ''를 씌워줘야 함

SELECT employee_id, last_name, salary, &column_name --열 이름으로 찾기
FROM employees;

SELECT employee_id, last_name, salary, &column_name
FROM employees
ORDER BY &column_name; --같은 이름이라도 다른 변수로 취급 가능

SELECT employee_id, last_name, salary, &&column_name --같은 이름의 변수를 머금고 있다가 넘겨줌
FROM employees
ORDER BY &column_name;

DEFINE column_name --변수 치환
UNDEFINE column_name --변수 제거
DEFINE column_name