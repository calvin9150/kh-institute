SELECT * FROM DBA_USERS; --현재 데이터베이스에 등록된 계정들을 조회하는 명령어
--기본적인 명령어 실행하려면 명령어(쿼리문) 작성 라인에 커서를 두고 CTRL+ENTER
--오라클DB는 기본적으론 명령어를 1개씩 실행한다. 
SELECT*FROM TAB; --현재 계정에 들록된 테이블을 조회

--위에서 이용한 쿼리문은 오라클이 이용자에게 DB정보를 제공하기 위해 만든 가상의 테이블 -> DATA DICTIONARY
--오라클은 기본적으로 DB관리자 계정을 자동으로 부여함
--SYSTEM : 일반관리자 계정 -> DB를 생성 및 삭제할 관리는 없다. 사용자계정 등록 및 권한부여 역할
--SYS : 수퍼관리자 계정 -> DB 생성 및 삭제 가능, 사용자계정 등록 및 권한부여도 가능
--SYS AS SYSDBA : 수퍼관리자 계정으로 접속

--기본적으로 DB를 이용하는 사용자계정을 등록하고 이용해보기.
--사용자 계정은 SYSTEM/SYS AS SYSDBA 계정이 등록한다.
--DB를 이용하려면 반드시 계정이 있어야한다.
--CREATE USER 계정명 IDENTIFIED BY 비밀번호 -> 계정생성 쿼리문. 비번만 대소문자 구분함.
CREATE USER KH IDENTIFIED BY KH;
SELECT * FROM DBA_USERS;
--GRANT 권한||롤 TO 계정명;  -> 권한 부여하기
--CONNECT[ROLE] : 계정이 DB에 접속할 수 있는 권한 부여
GRANT CONNECT TO KH; -- 접속할 수 있는 권한 부여

--접속한 KH계정으로 조회해보기
--데이터를 확보활 공간 확보
SELECT * FROM TAB;
CREATE TABLE TEST1(
    NAME VARCHAR2(20)
); 

-- DROP TABLE TEST1 : 'TEST1' 테이블 삭제

--테이블을 생성하려면 생성할 수 있는 권한이 있어야함.
--RESOURCE (ROLE)를 부여 : 테이블을 생성하고 이용할 수 있는 권한이 있는 ROLE;
GRANT RESOURCE TO KH;

CREATE USER TEST IDENTIFIED BY TEST;
GRANT CONNECT, RESOURCE TO TEST;
CREATE TABLE TEST2(
    NAME VARCHAR2(20)
);

--DATA DICTIONARY
SELECT * FROM DICT; --관리자, 사용자 계정이 이용한다.
SELECT *
FROM EMPLOYEE; -- SELECT * FROM 테이블명 -> 테이블의 모든 데이터 조회
DESC EMPLOYEE; -- 특정 테이블에 어떤 컬럼이 있는지 조회
SELECT * FROM DEPARTMENT;

--기본 SELECT문 활용
--SELECT 컬럼명, 컬럼명 ....... 추가가능 
--FROM 테이블

SELECT EMP_ID, EMP_NAME, EMP_NO
FROM EMPLOYEE;

----------------------- 2021-02-26
 
 --RESULT SET에서 ROW 필터링 가져오려면 WHERE
SELECT *
FROM EMPLOYEE
WHERE SALARY<=3500000;

--DB에선 대부분 SELECT 문 안에서 이루어진다 -> 함수실행, 산술연산 등
--컬럼명이 들어가는 곳에서 산술연산 가능.
SELECT 10+20
FROM DUAL; --ORACLE이 제공하는 테스트용 테이블

SELECT SALARY, BONUS, SALARY+SALARY*BONUS
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 각 사원의 연봉 조회
--컬럼명 AS 변경할컬럼명 (AS 생략하고 띄워쓰기로가능) "변경할컬럼명" -> ""안에 넣으면 띄워쓰기나 특수기호 사용 가능
SELECT EMP_NAME 사원명, SALARY*12 연봉, (SALARY+SALARY*BONUS)*12 AS 성과금포함연봉
FROM EMPLOYEE;
--없는 컬럼명은 추가가 된다
SELECT EMP_NAME, '님', 100
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE --컬럼 중복값을 제거하고 출력
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE, JOB_CODE -- 여러 컬럼을 적으면 해당 컬럼들끼리 ROW에서 겹치는 거만 삭제
FROM EMPLOYEE;

SELECT EMP_NAME||'님', SALARY||'원' --컬럼을 연결
FROM EMPLOYEE;

--EMPLOYEE 테이블에서 사원명 송종기의 전체 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME='송종기';
--코드가 D5인 사원 조회
SELECT*
FROM EMPLOYEE
WHERE DEPT_CODE='D5';
--급여가 2백만원 이상인 사원 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY>2000000;

--코드가 D5 혹은 D6인 사원의 사원명,급여,코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR DEPT_CODE='D6';

--부서코드가 D5가 아닌 사원을 조회
SELECT *
FROM EMPLOYEE
WHERE NOT DEPT_CODE='D5';

--EMPLOYEE 테이블에서 급여 300~500만의 사원의 이름, 급여, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY>3000000 AND SALARY<5000000;
--WHERE 컬럼 BETWEEN 값 AND 값 사용
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 5000000;

DESC EMPLOYEE; --테이블에 어떤 컬럼이 있는지 조회
--고용일이 00/01/01 이전에 입사한 사원의 이름, 부서, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE<'00/01/01';

--고용일이 09/01/01~00/01/01 사이에 입사한 사원의 이름, 부서, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '00/01/01';


--LIKE : 특정 패턴의 문자값 조회
-- 와일드카드를 사용해서 조회 %, _
-- % : 0개 이상의 임의의 문자 표시
-- _ : 1개의 임의의 문자 표시

-- 1) 앞자리가 ze로 시작 : ze% (앞에는 ze로 시작하는걸 모조리 가져와라)
-- 2) 뒷자리가 com으로 끝남 : %com (com으로 끝나는걸 모조리 가져와라)
-- 3) 문장중에 a와 n을 포함 : %a%n% (어느 위치에 있는지는 모르지만 문장중에 a 와 n을 포함하는걸 모조리 가져와라)

--전씨 성을 가진 사언의 이름, 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전_%';

--이름에 이 가 포함된 사원 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%이%';

--특수기호를 조건으로 쓰려면 ESCAPE 사용
SELECT*
FROM EMPLOYEE
WHERE EMAIL LIKE '___A_%' ESCAPE 'A';

--이 씨가 아닌 사원 조회
SELECT *
FROM EMPLOYEE
WHERE NOT EMP_NAME LIKE '이%';

--NULL 은 연산처리가 안된다. 
--IS NULL : NULL 값인 것 찾음

--보너스 못받는 사람 조회......
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL;

--부서 미지정자 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

--IN/ NOT IN : 포함됐는지 안됐는지
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE='J7' OR JOB_CODE='J2') AND SALARY>2000000;

------------------ 2021-03-02

--ORDER BY : 데이터 순서 정렬
-- ASC : 오름차순, DESC : 내림차순
--ORDER BY 구문은 항상 맨 마지막에 작성
SELECT *
FROM EMPLOYEE
-- ORDER BY SALARY DESC; --내림차순
ORDER BY DEPT_CODE DESC NULLS LAST; -- NULLS LAST, NULLS FIRST 추가 가능
-- ORDER BY 3 DESC -- 3번째 COLUMN 선택, 별칭도 사용가능

--LENGTH(문자열||컬럼명) : 문자열 길이 반환
SELECT LENGTH(EMAIL)
FROM EMPLOYEE;
-- EMAIL 길이가 16이상인 사원의 전체 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE LENGTH(EMAIL)>=16;
-- LENGTHB(문자열||컬럼명) : 문자열 BYTE 크기

-- INSTR(대상 문자열||컬럼, 찾을 문자[, 시작위치, 횟수]) : 지정한 위치부터 지정한 횟수번째에 나타난 문자열 인덱스 반환
SELECT INSTR('KH정보교육원KH', 'KH',1,1) FROM DUAL; -- 1, 한번 찾으면 끝 // 지정위치가 음수면 뒤에서 부터 찾는다는 뜻
--EMAIL에서 @위치, 두번째 . 의 위치 찾기
SELECT INSTR(EMAIL,'@'), INSTR(EMAIL,'.',1,2)
FROM EMPLOYEE;

-- LPAD(왼) / RPAD(오른) : 특정 길이의 여백이 생기면 그 공간을 대체문자로 채움.
--LPAD(대상문자열, 지정길이[,대체문자])
SELECT '안녕', LPAD('안녕', 10) FROM DUAL; -- 대체문자 지정없으면 띄어쓰기로 대체

-- LTRIM/RTRIM(대상문자||컬럼[,문자) : 공백이나 특정 기호 제거 // TRIM 은 양쪽 제거
SELECT LTRIM('              무야호')
FROM DUAL;

-- SUBSTR('문자열', 시작인덱스[,길이]) : 지정한 위치를 제외한 문자열을 잘라내는 기능
SELECT SUBSTR('HELLO FUNCTION', 6)
FROM DUAL;
-- 이름에서 성만 출력
SELECT SUBSTR(EMP_NAME,1,1)
FROM EMPLOYEE;

--LOWER/UPPER/INICAP : 소문자로,대문자로, 띄어쓰기 다음을 대문자로 출력

--REPLACE(대상컬럼, 대상 문자열[, 대체문자열])
SELECT REPLACE(EMAIL, '@', '!!!!!!')
FROM EMPLOYEE;
--REVERSE : 문자열 거꾸로
SELECT REVERSE('MUYAHO~ HE IS GOING CRAZY')
FROM DUAL; --YZARC GNIOG SI EH ~OHAYUM

--TRANSLATE(대상문자열,치환대상,치환문자열)
SELECT TRANSLATE('무~야~호~','무야호','신난다')
FROM DUAL;

SELECT * FROM EMPLOYEE;
--EMPLOEE테이블에서 사원번호, 사원명, 주민번호, 연봉조회
-- 주민번호는 생년월일 제외한 나머지는 * 로 표시
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO, 1, 7)||'*******'
FROM EMPLOYEE;

--MOD(A, B) // A와B의 나머지 반환
SELECT MOD(10,3) FROM DUAL; -- 1

--ROUND(실수, 소수점 자리 수) : 실수의 소수점 자리수까지 남기고 그 뒤는 반올림 // 음수 가능
SELECT ROUND(1.12345, 2)
FROM DUAL; -- 1.12

--FLOOR : 소수점 삭제
SELECT FLOOR(1.2345) FROM DUAL; -- 소수점자리 삭제

--TRUC : 지정 위치 뒤 소수점 자리 버림
SELECT TRUNC(1.234, 2) FROM DUAL;

-- SYSDATE : 현재날짜 반환
SELECT SYSDATE FROM DUAL; -- +, - 로 하루더하고빼기 가능

--ADD_MONTHS : 개월수 증가
SELECT ADD_MONTHS(HIRE_DATE, 3) -- 3개월 증가
FROM EMPLOYEE;

--MONTHS_BETWEEN : 두 날짜의 개월 수 차이 반환
--EMPLOYEE 테이블에서 사원의 근무개월수를 구하시오
SELECT EMP_NAME, DEPT_CODE, SALARY, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 근무개월수
FROM EMPLOYEE;

-- NEXT_DAY : 지정 요일이 가장 가까운 날짜 반환
-- LAST_DAY : 그 달의 마지막 날 출력
-- EXTRACT : 년월일시분초 를 따로 숫자형으로 반환
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;
-- 시분초  
SELECT EXTRACT(HOUR FROM CAST(SYSDATE AS TIMESTAMP)) FROM DUAL;
-- 사원명, 입사날(요일) 출력
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY/MM/DD (DY)')
FROM EMPLOYEE;

SELECT SYSDATE+540, 
FROM DUAL;
