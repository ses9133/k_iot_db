## c_ddl > a_ddl01 ##

/*
	## DDL (Data Definition Language) 문법 정리
	: CREATE, ALTER, DROP, TRUNCATE
  */
  
  /*
	-- DB(= 스키마) 생성-
    CREATE: 데이터베이스 생성, 데이터를 저장하고 관리하는 첫 단계
    기본 형태 
    CREATE DATABASE 데이터베이스명;
*/
CREATE DATABASE example1; -- 문장과 문장사이에 세미콜론으로 반드시 끝나야함
CREATE DATABASE example2;
-- CREATE DATABASE example2; -- 같은 DB 명을 써도 오류는 안남. (실행을 아직 안했기 떄문에). 실행하면 동일한 이름 쓰면 안됨 -> Error Code: 1007. Can't create database 'example2'; database exists

# 데이터베이스 이름은 중복될 수 없음
# >> 같은 이름의 DB 두번 생성 불가

## 테이블 생성 ##
-- CREATE : 테이블 생성, 테이블에 저장될 데이터의 형태와 특성을 정의
-- 데이터타입, 제약조건, 기본값등의 설정 가능
-- 기본 형태 
/*
	CREATE TABLE 데이터베이스명.테이블명 (
		컬럼1 데이터타입 [선택적옵션],
		컬럼2 데이터타입 [선택적옵션],
		컬럼3 데이터타입 [선택적옵션],
        ...
        컬럼 N 데이터타입 [선택적옵션]
    );
*/
CREATE DATABASE school;

			-- db명.컬럼명
CREATE TABLE `school`.`student` ( -- 백틱(`) 사용
		student_id int,
        student_name char(8),	-- 학생이름 (문자, 최대 8자리)
        student_gender char(8)	-- 학생 성별(문자, 최대 8자리)
);

-- cf) 문자 인코딩 추가 테이블
-- : UTF-8 문자 인코딩을 사용하여 한글 등의 문자 정보를 올바르게 저장할 수 있도록 설정
CREATE TABLE `student_encoding`(
		student_id int,
        student_name char(8),	
        student_gender char(8)
)
default CHARACTER set = utf8mb4
COLLATE = utf8mb4_unicode_ci; -- 정렬 방식 (문자열끼리 비교하고 정렬할 때 어떤 기준으로 할지 정하는 설정) 
							  -- cf) ci (case-insensitive): 대소문자 구분하지 않음 ('abc' == 'ABC')
-- utf8mb4_general_ci: 속도가 빠르다, 정확도가 낮다

# utf8(문자까지만 인코딩) VS utf8mb4 (모든 유니코드 문자 저장 - 이모지 & 한자 포함)

 -- Error Code: 1046. No database selected Select the default DB to be used by double-clicking its name in the SCHEMAS list in the sidebar.
 -- >> DB 를 지정하지 않으면 테이블 생성 불가!!(어느 스키마에서 활성화할 건지 선택해야함)
 -- 1) 테이블명 앞에 'DB명.' 첨부
 -- 2) 위의 오류 설명처럼 원하는 스키마 더블클릭
 
 -- +) 테이블명 또한 중복될 수 없다
 
 -- 데이터베이스 & 테이블 삭제
 # DROP: DB 와 테이블의 구조와 데이터 전체를 삭제
 # 기본형태
 -- DROP DATABASE `db명`;
 -- DTOP TABLE `db명`.`테이블명`;
 DROP TABLE `school`.`student`; -- school 테이블의 student 컬럼 삭제
 DROP DATABASE `school`;	-- school DB 삭제
 DROP DATABASE `example1`;
 DROP DATABASE `example2`;
-- DROP DATABASE `example3`; -- DROP DATABASE `example3`	Error Code: 1008. Can't drop database 'example3'; database doesn't exist
















