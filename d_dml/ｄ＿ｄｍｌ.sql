-- cf) DDL - DB 정의 언어
-- : CREATE, ALTER, DROP, TRUNCATE

-- DML (Data Manipultaion Language)
-- : 데이터 조작(관리) 언어
-- - 데이터를 삽입, 조회, 수정, 삭제 (CRUD) 

CREATE DATABASE IF NOT EXISTS `company`;
USE `company`;

CREATE TABLE `example01` (
	name VARCHAR(100),
	age INT,
    major VARCHAR(100)
);

/*
	1. 데이터 삽입 (INSERT)
    : 테이블의 행 데이터(레코드)를 입력
    
    # 기본 형식 #
    INSERT INTO 테이블명 (열1, 열2, ...)
    VALUES (값1, 값2, ...);
    
    cf) 테이블명 뒤 열 이름의 나열을 생략할 경우 
		: values 뒤의 값 순서는 테이블 정의 시 작성한 열의 순서 & 개수와 동일
		>> name(문자), age(숫자), major(문자) 순
	
    cf) 전체 테이블의 컬럼 순서 & 개수와 차이가 나는 경우는 반드시!~ 원하고자하는 열 이름 나열
*/

-- 1) 컬럼명 지정 X
INSERT INTO `example01`
VALUES 
	('오신현', 20, 'IT');
    
INSERT INTO `example01`
VALUES 
	('박진영', 20); -- Error Code: 1136. Column count doesn't match value count at row  -- MAJOR 값 누락 오류
    
INSERT INTO `example01`
VALUES 
	('박진영', 'cooking', 30); -- Error Code: 1366. Incorrect integer value: 'cooking' for column 'age' at row -- 컬럼 정렬 순에 맞지 않는 오류
    
-- 2) 컬럼명 지정시
INSERT INTO `example01` 
	(major, name)
VALUES 
	('Health', '손태경'); 
-- 데이터 삽입시 NULL 허용 컬럼에 값 입력이 이루어지지 않은 경우 자동으로 NULL 값 지정됨
SELECT * FROM `example01`;

-- cf) "AUTO_INCREMENT"
-- : 열을 정의할 때 1부터 1씩 증가하는 값을 입력
-- : insert 에서는 해당 열이 없다고 가정하고 입력
-- : 해당 옵션이 지정된 컬럼은 반드시!! PK 값으로 지정 (하나의 테이블에 한 번만 지정 가능!)

CREATE TABLE `example02` (
	-- 컬럼명 데이터타입 [primary key] [AUTO_INCREMENT] // 옵션 순서는 상관 없음
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO `example02`(name)
VALUES 
	('최광섭'),
	('정은혜'),
	('정지훈');
    
SELECT * FROM `example02`;

INSERT INTO `example02`
VALUES
	(null, '김승민');
    
SELECT * FROM `example02`; -- id 는 1씩 자동으로 증가함

-- cf) AUTO_INCREMENT 최대값 확인
-- SELECT MAX(AUTO_INCREMENT컬럼명) FROM '테이블명';
SELECT MAX(id) FROM `example02`;

-- CF) 시작값 변경
ALTER TABLE `example02` AUTO_INCREMENT=100; -- 테이블 생성시에도 동일

INSERT INTO `example02`
VALUES
	(null, '박현우');
    
SELECT * FROM `example02`; -- id=100

-- cf) 다른 테이블의 데이터를 한 번에 삽입하는 구문 alter
-- INSERT INTO `삽입받을 테이블`
-- SELECT ~ (조회구문작성)

CREATE TABLE `example03`(
	id INT,
    name VARCHAR(100)
); 

INSERT INTO `example03`
SELECT * FROM `example02`; -- 컬럼의 순서, 개수, 자료형이 반드시 서로 일치해야함(옵션은 상관없음)

SELECT * FROM `example03`;














