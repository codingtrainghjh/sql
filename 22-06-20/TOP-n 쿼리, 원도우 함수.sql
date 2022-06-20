--TOP-n 쿼리
SELECT rownum AS rank, employee_id, last_name, salary
FROM (SELECT employee_id, last_name, salary
                    FROM employees
                    ORDER BY salary DESC) --보통 서브쿼리속 order by는 의미가 없음
WHERE rownum <= 5;

SELECT rownum AS rank, employee_id, last_name, salary
FROM (SELECT employee_id, last_name, salary
                    FROM employees
                    ORDER BY salary)
WHERE rownum <= 5;

--윈도우함수란? 
--행과 행 간의 관계를 쉽게 정의하기 위해 만든 함수가 윈도우 함수다. 
--윈도우 함수는 분석 함수나 순위 함수로도 알려져 있다. 
--윈도우 함수는 기존에 사용하던 집계 함수도 있고 전용 윈도우 함수도 있다.
--윈도우 함수는 다른 함수와 달리 중첩해서 사용은 못하지만, 서브쿼리에는 사용할 수 있다. 

--WINDOW FUNCTION 는 다음과 같이 분류할 수 있다. (벤더별로 지원하는 함수 차이가 있음)
--
--- 그룹 내 순위(RANK) 관련 함수: RANK, DENSE_RANK, ROW_NUMBER
--- 그룹 내 집계(AGGREGATE) 관련 함수 : SUM, MAX, MIN, AVG, COUNT (sql server는 OVER 절의 OREDER BY 지원 X)
--- 그룹 내 행 순서 관련 함수 : FIRST_VALUE, LAST_VALUE, LAG, LEAD (오라클에서만 지원)
--- 그룹 내 비율 관련 함수 : CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT
--
--WINDOW FUNCTION 문법
--윈도우 함수에는 OVER 문구가 키워드로 필수 포함된다.
--
--SELECT WINDOW_FUNCTION (ARGUMENTS) OVER --arguments는 들어갈수도, 안들어갈수도 있다.
--( [PARTITION BY 컬럼] [ORDER BY 컬럼] [WINDOWING 절] )
--FROM 테이블명 ; 
--
--
--WINDOW_FUNCTION : 윈도우 함수 
--ARGUMENTS(인수) : 함수에 따라 0 ~ N개 인수가 지정될 수 있다. 
--PARTITION BY 절 : 전체 집합을 기준에 의해 소그룹으로 나눌 수 있다.   
--ORDER BY 절 : 어떤 항목에 대해 순위를 지정할 지 order by 절을 기술한다.
--WINDOWING 절 : WINDOWING 절은 함수의 대상이 되는 행 기준의 범위를 강력하게 지정할 수 있다. (sql server 에서는 지원하지 않음)

--------------------------------------------------------------

--그룹 내 순위(RANK) 관련 함수
--RANK
-- 순위를 구하는 함수.
-- 특정 범위(PARTITION) 내에서 순위를 구할 수도 있고, 전체 데이터에 대한 순위를 구할 수도 있다. 
-- 동일한 값에 대해서는 동일한 순위를 부여하게 된다. 

--사원 데이터에서 급여가 높은 순서를 출력하는 예제
SELECT job_id, last_name, salary,
         RANK() OVER (ORDER BY salary DESC) ALL_RANK    
FROM     employees ;  
--동일한 급여가 있다면 같은 순위를 부여한다. 

--사원 데이터에서  업무별로 급여가 높은 순서를 출력하는 예제
SELECT job_id, last_name, salary,
         RANK() OVER (PARTITION BY job_id ORDER BY salary DESC) JOB_RANK -- job_id 별로 급여 높은 순
FROM     employees ;    
--동일한 급여가 있다면 같은 순위를 부여한다. 
--PARTITION 으로 구분한 JOB_RANK 는 같은 업무 범위 내에서만 순위를 부여한다. 
SELECT department_id, last_name, salary,
         RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) JOB_RANK -- department_id 별로 급여 높은 순
FROM     employees ;    
--부서별로 입사일이 빠른 순서대로 순위를 출력하시오
SELECT department_id, hire_date,
         RANK() OVER (PARTITION BY department_id ORDER BY hire_date) HIRED_RANK -- department_id 별로 입사가 빠른 순
FROM     employees ;    

--DENSE_RANK
-- RANK와 흡사하지만, 동일한 순위를 하나의 건수로 취급한다. 
-- RANK는 1, 1, 3 순위(1위가 두개 이니 2위 없이 3위 표시) 로 표기하지만, DENSE_RANK는1,1,2  순위를 부여한다. 

SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
         DENSE_RANK() OVER (ORDER BY salary DESC) DENSE_RANK 
FROM     employees ;          
 
--ROW_NUMBER
-- RANK, DENSE_RANK 가 동일한 값에 대해서는 동일한 순위를 부여하는데 반해, 
-- ROW_NUMBER 는 동일한 값이라도 고유한 순위를 부여한다. 

SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
         ROW_NUMBER() OVER (ORDER BY salary DESC) ROW_NUMBER
FROM     employees ;          
--ROW_NUMBER 는 동일한 순위를 배제하기 위해 유니크한 순위를 정한다. 
--동일한 순위에 대해서는 어떤 순서가 정해질지 알 수 없다. (Oracle의 경우 rowid가 적은 행이 먼저 나온다) 이 부분은 데이터베이스 별로 틀린 결과가 나올 수 있으므로, 만일 동일 값에 대한 순서까지 관리하고 싶으면 ROW_NUMBER( ) OVER (ORDER BY salary DESC, last_name) 같이 ORDER BY 절을 이용해 추가적인 정렬 기준을 정의해야 한다.

-- 추가 정렬 기준 정의 예제 
SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
          ROW_NUMBER( ) OVER (ORDER BY salary DESC, last_name)  ROW_NUMBER
FROM     employees ;  

SELECT  job_id, last_name, salary,
         RANK()       OVER (ORDER BY salary DESC) ALL_RANK,  
          ROW_NUMBER( ) OVER (ORDER BY salary DESC, last_name DESC)  ROW_NUMBER
FROM     employees ;  

------------------------------------------------------------------------------------------------------------------------
--그룹 내 집계(AGGREGATE) 관련 함수

--SUM
-- SUM 함수를 이용해서 파티션별 윈도우의 합을 구할 수 있다. 
-- 같은 매니저를 두고 있는 사원들의 급여 합을 구하는 예제

SELECT manager_id, employee_id, last_name, salary, 
       SUM(salary) OVER (PARTITION BY manager_id) MGR_SUM
FROM   employees ;

--OVER 절에 ORDER BY 절을 추가해서 파티션 내 데이터를 정렬하고 이전 급여 데이터까지의 누적값을 출력하는 예제

SELECT manager_id, employee_id, last_name, salary, 
       SUM(salary) OVER (PARTITION BY manager_id ORDER BY salary RANGE UNBOUNDED PRECEDING) MGR_SUM
FROM   employees ;

--RANGE UNBOUNDED PRECEDING ;
-- 현재 행을 기준으로 파티션 내의 첫 번째 행까지 범위를 지정한다.
 


--MAX
-- 파티션별 윈도우의 최대값을 구할 수 있다. 
-- 같은 매니저를 두고 있는 사원들의 급여 중 최대값을 구하는 예제

SELECT manager_id, last_name, salary, 
       MAX(salary) OVER (PARTITION BY manager_id) MGR_MAX
FROM   employees ;

--같은 부서내 사원들의 급여 중 최대값을 구하는 문제 
SELECT department_id, last_name, salary, --그룹데이터와 개인데이터를 같이 봄
       MAX(salary) OVER (PARTITION BY department_id) MGR_MAX
FROM   employees ;


--INLINE VIEW를 이용해서 파티션별 최대값을 가진 행만 추출할 수도 있다.

SELECT manager_id, last_name, salary
FROM   (SELECT manager_id, last_name, salary, 
               MAX(salary) OVER (PARTITION BY manager_id) IV_MAX_SAL
        FROM   employees )
WHERE  salary =  IV_MAX_SAL ;

SELECT department_id, last_name, salary
FROM   (SELECT department_id, last_name, salary, 
               MAX(salary) OVER (PARTITION BY department_id) IV_MAX_SAL
        FROM   employees )
WHERE  salary =  IV_MAX_SAL ;
 

--MIN
--파티션별 윈도우의 최소값을 구할 수 있다. 

--같은 부서에서 근무하는 사원들의  급여 최소값을 같이 구하는 예제

SELECT department_id, last_name, hire_date, salary, 
       MIN(salary) OVER (PARTITION BY department_id) DEPT_MIN
FROM   employees ;
 

--AVG
--소속부서의 평균을 각 사원의 급여와 함께 표시할 수 있다.
SELECT department_id, last_name, hire_date, salary, 
       TRUNC(AVG(salary) OVER (PARTITION BY department_id)) DEPT_MIN
FROM   employees ;

--AVG 함수를 활용하여 파티션별 통계값을 구할 수 있다.
 
--같은 부서에서 근무하는 사원들의 평균 급여를 구하되, 
--같은 부서 내에서 자기 바로 앞의 사번과 바로 뒤의 사번인 직원을 대상으로만 하는 예제 
--( 앞 줄 + 현재행 + 뒷 줄의 합을 3으로 나누는 형식. 
--만약 앞줄이 없다면 현재행 + 뒷 줄의 합을 2로 나누게 된다)

SELECT department_id, last_name, hire_date, salary, 
       ROUND (AVG(salary) OVER (PARTITION BY department_id ORDER BY hire_date
       ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) ) DEPT_AVG
FROM   employees ;

--COUNT
--사원들을 급여 기준으로 정렬하고, 본인 급여보다 50 이하 적거나, 100 이하로 많은 급여를 받는 인원수를 출력하는 예제

SELECT last_name, salary,
       COUNT(*) OVER (ORDER BY salary RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING) SIM_CNT
FROM   employees ;

--RANGE BETWEEN 50 PRECEDING AND 100 FOLLOWING ;
-- 현재 행의 급여값을 기준으로 금여가 -50 ~ +100 범위 내에 포함된 모든 행이 대상이 된다. 
-- range는 현재 행의 데이터 값을 기준으로 앞 뒤 데이터 값의 범위를 표시하는 것임.

