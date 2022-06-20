--조직도 같은 쿼리를 만들어내는 쿼리 "계층쿼리"
--계층쿼리
--하향식(Top-Down)
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id; --connect by prior(이전행의 사원번호가 현재행의 매니저번호와 연결된다) 방향결정
--CONNECT BY manager_id = PRIOR employee_id; -- prior가 붙은쪽이 이전행(현재는 하향식)

--102번을 시작점으로 하향식 검색
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 102
CONNECT BY PRIOR employee_id = manager_id;

--상향식(Bottom-Up) 검색
SELECT LEVEL, employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 144
CONNECT BY  employee_id = PRIOR manager_id;

--LEVEL열의 표시
SELECT LEVEL, employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id;

SELECT LEVEL, employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 102
CONNECT BY PRIOR employee_id = manager_id;

--결과를 입체적으로 출력하는 방법
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'-')
       AS org_chart
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--계층쿼리 관련 함수
--CONNECT_BY_ISLEAF : 해당 행이 LEAF 이면 1을 반환
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart, CONNECT_BY_ISLEAF AS isleaf
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--상향식 검색에서의 LEAF
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart, CONNECT_BY_ISLEAF AS isleaf
FROM   employees 
START WITH employee_id = 144
CONNECT BY   employee_id= PRIOR manager_id ;

--SYS_CONNECT_BY_PATH : Root에서 현재 행까지의 경로 표시
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart,  SYS_CONNECT_BY_PATH(employee_id,'/') path
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--CONNECT_BY_ROOT : 현재 결과에서의 ROOT 행 표시
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'_') 
       AS org_chart,  CONNECT_BY_ROOT(last_name) isroot
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--결과에서 특정 가지를 제거하는 법
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'-')
       AS org_chart
FROM   employees 
WHERE employee_id <> 101 --해당 행만 제거
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id ;

--결과에서 특정 가지를 제거하는 법2
SELECT LPAD(employee_id||last_name, LENGTH(employee_id||last_name)+(LEVEL*2)-2,'-')
       AS org_chart
FROM   employees 
START WITH employee_id = 100
CONNECT BY  PRIOR employee_id= manager_id
AND employee_id <> 101; --해당 행만 제거