--Regular Expression Test
--�ǽ��� �ʿ��� T1 ���̺� ����
@c:\db_test\sql_labs\regexp_tab.sql
SELECT * FROM t1;
--REGEXP_LIKE �ǽ�
--fname�� Ste�� �����ϰ� �߰��� v�� ph�� �����ϰ� en���� ������ ������ �˻��ϱ�
SELECT fname, lname
FROM t1
WHERE REGEXP_LIKE (fname, '^Ste(v|ph)en$');
--��ȭ��ȣ�� ������ XXX.XX.XXXX.XXXXXX ������ ������ �˻�
SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '...\...\.....\.......') ;
--���� ������ ���ڸ� �˻��ϵ��� �����ϱ� 
SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '[0-9]{3}\.[0-9]{2}\.[0-9]{4}\.[0-9]{6}');
--��ȭ��ȣ�� "." ���� ���� �� ���ڸ� "-" ���� ����
SELECT fname, phone, REGEXP_REPLACE ( phone , '\.' , '-' ) new_format
FROM t1 ;
--��ȭ��ȣ�� ������ ���� 3-3-4 �� �����͸� ������ȣ�� ��ȣ�� �ϰ� ���� ���ڸ� "-"�� ����
SELECT fname, phone,
REGEXP_REPLACE (phone, '(\d{3})\.(\d{3})\.(\d{4})','(\1)-\2-\3') new_phone
FROM t1;
--REGEXP_INSTR �Լ��� ����Ͽ� �ּҿ� ��ȭ��ȣ���� ���ĺ��� ���� ù ��ġ���� ��ȯ
SELECT fname, addr, REGEXP_INSTR ( addr, '[[:alpha:]]' ) pos ,
       phone, REGEXP_INSTR ( phone, '[[:alpha:]]') pos
FROM t1;
--REGEXP_SUBSTR �Լ��� ����Ͽ� �Ÿ��̸��� ��ȯ(����� ���� ���� ������ �ƴ�~)
SELECT fname, addr, REGEXP_SUBSTR ( addr, ' [^ ]+ ') road
FROM t1;
--RETEXP_SUBSTR �Լ��� �Ϲ��Լ� REPLACE�� ��ø�Ͽ� ��ȭ��ȣ ��� ������ ���
SELECT fname, phone,
       REPLACE(REGEXP_SUBSTR(phone,'\.(\d{3})\.'),'.') code
FROM t1;
--�� �������� REPLACE �Լ��� ���� ���� ����� ����� ��
SELECT fname, phone,
      REGEXP_SUBSTR(phone,'\.(\d{3})\.') code
FROM t1;
--REGEXP_COUNT �Լ��� ����Ͽ� �ּҿ� ���Ե� a�� ���� ǥ��
SELECT fname, addr, REGEXP_COUNT(addr,'a') cnt
FROM t1;
--REGEXP_SUBSTR �Լ� ������� ����ǥ������ ���� �˾ƺ���
--�μ��� �ǹ�(������� ������ġ-�߻�Ƚ��,��ҹ��� �ĺ�����, �����Ĺ�ȣ)
SELECT REGEXP_SUBSTR ('0123456789',
                      '(123)(4(56)(78))', 1, 1, 'i', 1 ) "Exp1" ,
       REGEXP_SUBSTR ('0123456789',
                      '(123)(4(56)(78))', 1, 1, 'i', 2 ) "Exp2" ,
       REGEXP_SUBSTR ('0123456789',
                      '(123)(4(56)(78))', 1, 1, 'i', 3 ) "Exp3" ,
       REGEXP_SUBSTR ('0123456789',
                      '(123)(4(56)(78))', 1, 1, 'i', 4 ) "Exp4"
FROM dual;
--REGEXP__INSTR �Լ� ������� ����ǥ������ ������ġ ��ȯ�ϱ�
--������ ������ �μ� "2"�� 1~5�� �ٲ㰡�� �����ϰ� ������ϱ�
--�μ��� �ǹ�(������� ������ġ-�߻�Ƚ��,��ҹ��� �ĺ�����,��ȯ�ɼ�(0 �Ǵ� 1)  �����Ĺ�ȣ)
SELECT REGEXP_INSTR ('0123456789',
                     '(123)(4(56)(78))', 1, 1, 0, 'i', 2 ) "Position"
FROM dual;
--REGEXP_INSTR �Լ��� �� ��° �μ��� ��ȯ�ɼ�(0 �Ǵ�1) �ǽ�
--�ι�° ����ǥ���� 45678�� ������ 9�� ��ġ ��ȯ
SELECT REGEXP_INSTR ('0123456789',
                     '(123)(4(56)(78))', 1, 1, 1, 'i', 2 ) "Position"
FROM dual;
--����° ����ǥ���� 56�� ������ 7�� ��ġ ��ȯ
SELECT REGEXP_INSTR ('0123456789',
                     '(123)(4(56)(78))', 1, 1, 1, 'i', 3 ) "Position"
FROM dual;
--DNA ������ ��� gtctcacaaag�迭�� gtc �迭 ã��
SELECT REGEXP_INSTR('ccacctttccctccactcctcacgttctcacctgtaaagcgtccctc
cctcatccccatgcccccttaccctgcagggtagagtaggctagaaaccagagagctccaagc
tccatctgtggagaggtgccatccttgggctgcagagagaggagaatttgccccaaagctgcc
tgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagttttca
ccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagag
gctcttgggtctgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggc
atgtaggggcgtggggatgcgctctgctctgctctcctctcctgaacccctgaaccctctggc
taccccagagcacttagagccag',
'(gtc(tcac)(aaag))',
1, 1, 0, 'i',
1) "Position"
FROM dual;
--DNA ������ ��� ccacctttccct�迭�� ccct �迭 ã��
SELECT REGEXP_INSTR('ccacctttccctccactcctcacgttctcacctgtaaagcgtccctc
cctcatccccatgcccccttaccctgcagggtagagtaggctagaaaccagagagctccaagc
tccatctgtggagaggtgccatccttgggctgcagagagaggagaatttgccccaaagctgcc
tgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagttttca
ccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagag
gctcttgggtctgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggc
atgtaggggcgtggggatgcgctctgctctgctctcctctcctgaacccctgaaccctctggc
taccccagagcacttagagccag',
'(ccac(cttt)(ccct))',
1, 1, 0, 'i',
3) "Position"
FROM dual;
--REGEXP_COUNT �Լ��� ������� �ҽ����� 123 ������ �߻� Ƚ�� ���ϱ�
SELECT REGEXP_COUNT
('1234567812312378945123', '123') As Count
FROM dual;
--REGEXP_COUNT �Լ��� ������� DNA �迭���� gtc ������ �߻� Ƚ�� ���ϱ�
SELECT REGEXP_COUNT(
'ccacctttccctccactcctcacgttctcacctgtaaagcgtccctccctcatccccatgcccccttaccctgcag
ggtagagtaggctagaaaccagagagctccaagctccatctgtggagaggtgccatccttgggctgcagagagaggag
aatttgccccaaagctgcctgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagtt
ttcaccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagaggctcttgggtc
tgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggcatgtaggggcgtggggatgcgctctg
ctctgctctcctctcctgaacccctgaaccctctggctaccccagagcacttagagccag',
'gtc') AS Count
FROM dual;

--Clear Test
DROP TABLE t1 PURGE;
