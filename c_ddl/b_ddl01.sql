## c_ddl > b_ddl01

-- 데이터베이스 ---
-- 1. 생성(CREATE)
CREATE DATABASE database_name;
DROP DATABASE database_name;
-- > 위 두개의 실행문은 각각 여러 번 실행할 경우 Error 발생

-- cf) if [not] exists 옵션
-- : 데이터베이스의 유무를 확인하고 오류를 방지하는 SQL 문법
-- 	, 존재할 때 또는 존재하지 않을 때 실행

CREATE DATABASE IF NOT EXISTS database_name;
DROP DATABASE IF EXISTS database_name;

-- 2. 데이터베이스 선택(USE)
-- : DB 선택시 이후 모든 SQL 명령어가 선택된 DB 내에서 실행
-- GUI 로 Navigator > SCHEMAS > 스키마명 더블클릭과 동일한 명령어alter
USE database_name;

CREATE DATABASE IF NOT EXISTS example;
USE example;

-- 3. 데이터베이스 삭제(DROP)
-- : 데이터베이스 삭제, 해당 작업은 실행 후 되돌릴 수 없음!!!
DROP DATABASE database_name;
DROP DATABASE IF EXISTS database_name;

-- 4. 데이터베이스 목록 조회
-- : 해당 SQL 서버에 존재하는 모든 DB 목록을 확인할 수 있음
SHOW DATABASES;

-- ## 테이블 ##
-- : 1. 테이블 생성 CREATE
USE example;

CREATE TABLE students (
	-- 테이블 생성시 DB 명 필수 X
    -- USE 명령어를 통해 DB 지정이 되어 있는 경우 생략가능
    -- 하지만, 오류 방지를 위해 작성 권장
	studnet_id int primary key,
    name varchar(100) not null,
    age int not null,
    major varchar(100) 
);

-- 2. 테이블 구조 조회(DESCRIBE, DESC)
-- : 정의된 컬럼, 데이터 타입, 키, 정보(제약 조건)등을 조회
-- : DESCRIBE 테이블명; 또는 DESC 테이블명;

-- cf) 테이블 구조
-- Field : 각 컬럼의 이름 
-- Type: 각 컬럼의 데이터 타입
-- Null : Null(데이터 생략, 비워져있음) 허용 여부
-- Key: 각 컬럼의 제약 사항
-- Default: 기본값 지정
-- Extra: 제약 사항(추가옵션)

-- 테이블 수정 ---
-- ALTER TABLE
-- : 이미 존재하는 테이블의 구조를 변경하는데 사용
-- : 컬럼 또는 제약 조건을 추가, 수정, 삭제

-- 1) 컬럼
-- : 컬럼 추가(ADD)
-- ALTER TABLE 테이블명 ADD COLUMN 컬럼명 데이터타입 [기타사항(제약사항...)];
ALTER TABLE `students` ADD COLUMN email VARCHAR(225);

DESC students; -- cf) descending(desc) 내림차순과 다른 의미임

-- 컬럼 수정 (MODIFY)
-- ALTER TABLE 테이블명 MODIFY  COLUMN 컬럼명 새로운컬럼_데이터타입 [기타사항];
ALTER TABLE `students` 
MODIFY COLUMN email VARCHAR(100); 

-- 컬럼 삭제(DROP)
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE students
DROP COLUMN email;

-- cf) 테이블 수정시 COLUMN 키워드 생략 가능
-- ADD, MODIFY, DROP 만 작성해도 됨

-- 테이블 데이터 삭제(초기화)
-- TRUNCATE
-- : 테이블의 구조는 그대로 두고 내부의 모든 데이터를 삭제 (초기상태로 되돌림)
TRUNCATE TABLE students;
DESC students; -- -> 구조는 그대로 존재

-- IF EXISTS / IF NOT EXISTS
-- > 선택적 키워드지만, 오류방지에 대한 키워드로써 작성을 권장

















