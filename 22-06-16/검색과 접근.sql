SELECT COUNT(*) FROM user_tables;
SELECT COUNT(*) FROM all_tables;
SELECT COUNT(*) FROM dba_tables;
CREATE TABLE testemp
as
SELECT * FROM employees;
drop table testemp purge;
--SQL Developer 실행 후 인사관리로 접속
--Creating Objects For Test
create table emp3_tab
as
select * from employees;
create index emp3_empid_ix on emp3_tab(employee_id);
create view emp3_list_vu
as
select employee_id, last_name, department_id
from emp3_tab
where department_id not in (10,90);
create synonym emp3  for emp3_list_vu;
create sequence emp3_seq
increment by 1
start with 250
nocache
nocycle;
--Dictionary로 부터 사용자 소유 Object 관련 정보 탐색하기
select view_name, text from user_views
where view_name like 'EMP3%';
select synonym_name, table_owner, table_name
from user_synonyms
where synonym_name = 'EMP3%';
select sequence_name, increment_by, max_value, cache_size
from user_sequences
where sequence_name like 'EMP3%';
select index_name, status from user_indexes
where index_name like 'EMP3%';
select object_name, object_type, status from user_objects
where object_name like 'EMP3%';
--Table 삭제 후 연관객체의 상태 알아보기
drop table emp3_tab;
select index_name, status from user_indexes
where index_name like 'EMP3%';
select object_name, object_type, status from user_objects
where object_name like 'EMP3%';
--Clear Test
drop view emp3_list_vu;
drop synonym emp3;
drop sequence emp3_seq;