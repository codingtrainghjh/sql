--집합
--         -UNION[ALL]- 합집합
-- select -INTERSECT-   교집합 select
--         -MINUS-   빼기

--         -UNION[ALL]- 
SELECT employee_id, department_id FROM employees
UNION --중복 값 제거
SELECT employee_id, department_id FROM job_history;

SELECT employee_id, department_id FROM employees
UNION 
SELECT employee_id, department_id FROM job_history
ORDER BY 1; --정렬을  두 번함, 낭비하게 되므로 좋지 않음

SELECT employee_id 사원번호, department_id FROM employees -- 첫번째 문장에 별칭을 주어야만 적용이 된다.
UNION 
SELECT employee_id, department_id 부서번호 FROM job_history;

SELECT employee_id 사원번호, department_id 부서번호 FROM employees 
UNION ALL
SELECT employee_id, department_id FROM job_history;

--     -INTERSECT-
SELECT employee_id, department_id FROM employees
INTERSECT --입사 후 업무 혹은 부서의 변경이 있었다가 돌아온 직원
SELECT employee_id, department_id FROM job_history;

--         -MINUS-
SELECT employee_id, department_id FROM employees
MINUS --입사 후 업무변경이나 부서변경이 없었던 직원
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
MINUS --퇴사한 직원
SELECT employee_id FROM employees;

--컬럼 강제로 맞추기
SELECT employee_id, job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

--column수와 