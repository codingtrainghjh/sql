--MERGE 문 테스트
--실습을 위한 emp13 테이블 생성
@C:\DB\db_test\sql_labs\cre_emp13.sql
--정보확인(4명의 사원, 200번 부서, commission_pct가 모두 0.4)
SELECT * FROM emp13;
SELECT * FROM employees;
SELECT employee_id, commission_pct, department_id
FROM employees
WHERE employee_id IN (200,149,174, 176);
--MERGE 문 실행
MERGE INTO emp13 c
     USING employees e
     ON (c.employee_id = e.employee_id)
   WHEN MATCHED THEN --두 정보가 동일하다면
     UPDATE SET
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
      DELETE WHERE (e.commission_pct IS NULL) --employees에서 commission_pct가 null인 행은 제외됨
   WHEN NOT MATCHED THEN
     INSERT VALUES(e.employee_id, e.last_name,e.job_id, --테이블을 한번만 읽고 여러일을 해줌
          e.salary, e.commission_pct, e.department_id);
COMMIT;
SELECT * FROM emp13;