## 제약조건(Constraint) ##
-- : 데이터의 정확성, 일관성, 신뢰성, 무결성을 유지하기 위해
--  	, DB 시스템을 활용하여 강제하는 규칙

-- 1. 제약 조건 사용 목적
-- 무결성 유지: 잘못된 데이터 삽입 방지
-- 오류 방지: 잘못된 입력, 삭제, 변경 등을 방지
-- 관계 유지: 테이블 간의 연결을 확실하게 유지

-- 2. 제약 조건의 종류
-- 1) PK(기본키)
-- 2) FK(외래키, 참조키)
-- 3) Unique
-- 4) Check
-- 5) NOT NULL
-- 6) Default

/*
	1. PK (Primary Key)
    : 기본 키, 각 행을 고유하게 구분하는 역할(레코드 구분의 식별자)
    - 중복될 수 없음(고유성), null 허용이 안됨(반드시 유효한 데이터를 포함)
    cf) 유일성 제약
		- 하나의 테이블 당 하나의 기본 키만 지정 가능!
        > 테이블의 특성을 반영한 열 선택을 권장 || PK 컬럼 따로 생성 권장
        ex) members(member_id), books(book_id)
*/
DROP DATABASE IF EXISTS `example`;
CREATE DATABASE `example`;

USE `example`;

# 기본 키 지정 방법
# 1) 테이블 생성시 PK 컬럼에 명시: 컬럼명 데이터타입 PRIMIART KEY, -- 2번보다 더 많이 사용함.
CREATE TABLE `students` (
	student_id BIGINT PRIMARY KEY,
    name VARCHAR(100)
);

# 2) 테이블 생성시 마지막 열에 제약 조건 명시: PRIMARY KEY (설정할 컬럼명)
CREATE TABLE `students` (
    student_id BIGINT,
    name VARCHAR(100),
    PRIMARY KEY(student_id)
);

DESC `students`; -- 테이블의 구조 확인 (값들은 확인 X) (PK 는 NOT NULL 명시하지 않아도 PK 이기 때문에 NOT NULL 설정됨)

INSERT INTO `students`
VALUES 
	(1, '이승아'),
	(2, '이도경'),
	(3, '조승범');

SELECT * FROM `students`; -- 테이블 내부의 실질적인 데이터 확인 가능 (DESC 와의 차이)

INSERT INTO `students`
VALUES
	(1, '김명진'); -- Error Code: 1062. Duplicate entry '1' for key 'students.PRIMARY' // PK 는 값의 중복이 불가능함
    
-- * DDL 의 수정 ALTER
-- : 테이블 구조의 제약 조건 수정
ALTER TABLE `students` 
	DROP PRIMARY KEY;
    
-- 기존 테이블의 기본키 제약 조건 삭제시 NOT NULL 에 대한 조건을 사라지지 않음
DESC `students`;

ALTER TABLE `students`
	MODIFY `student_id` BIGINT NULL; -- NOT NULL 조건을 NULL 로 수정
    
DESC `students`;

-- 기존 테이블에 제약 조건 추가
ALTER TABLE `students`
ADD PRIMARY KEY (student_id);

/*
	2. FK : 외래, 참조 키
    - 두 테이블 사이의 관계를 연결, 데이터의 무결성 유지
    - 다른 테이블의 기본키를 참조하여 관계를 표현
    - 두 테이블 간 연결(RDBMS)
    
    +) 기본 테이블(기본 키가 있는 테이블)
    +) 참조 테이블(외래 키가 있는 테이블)
    
    회원(members) - 주문(orders)
    > 고객이 실제로 존재하는지 확인, 고객과 주문 간의 관계 명시
*/

CREATE TABLE `members` (
	member_id BIGINT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE `orders` (
	order_id BIGINT PRIMARY KEY,
    order_date DATE,
    member_id BIGINT,
    -- 외래키 지정 방법
    -- FOREIGN KEY (현 테이블의 컬럼명) REFERENCES 기본테이블명(pk 컬럼)
	FOREIGN KEY(member_id) REFERENCES `members`(member_id)
);

INSERT INTO `orders`
VALUES 
	(1, '2025-07-29', 123);  -- Cannot add or update a child row: a foreign key constraint fails (`example`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`))	
    
INSERT INTO `members`
VALUES 
	(123, '김보민'); -- memebers 에 데이터를 넣고 나면 위의 orders 테이블에 값을 넣을 수 있음
    
-- 외래키 제약 조건 수정(삭제 / 추가)
-- cf) 외래키 제약조건 삭제시, 해당 데이터를 참조하는 데이터가 있을 경우 삭제 불가!
ALTER TABLE `orders` DROP FOREIGN KEY member_id; -- Error Code: 1091. Can't DROP 'member_id'; check that column/key exists

TRUNCATE TABLE `orders`; 

-- 1) 제약 조건 이름 검색 필수
-- where 조건 내에서 테이블명과 컬럼명을 데이터 처럼 사용 (따옴표 사용)
SELECT CONSTRAINT_NAME
FROM information_schema.key_column_usage
WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'memeber_id';

-- 2) 참조 테이블의 외래 키 삭제
ALTER TABLE `orders`
DROP FOREIGN KEY orders_ibfk_1;

DESC `orders`; -- MUL 남아있음
-- MUL : 외래 키 지정시 MySQL 이 자동으로 인덱스 생성
-- 	- 외래키 삭제후에도 존재

-- 기존 테이블의 외래키 제약 조건 다시 추가
ALTER TABLE `orders` 
ADD CONSTRAINT
	FOREIGN KEY (member_id)
    REFERENCES `members`(member_id);
    
DESC `orders`;
-- FK 설정은 DESC 에서 MUL 로 표시
DESC `members`;

CREATE TABLE `users` (
	user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

CREATE TABLE `boards`(
	board_id INT PRIMARY KEY
);

ALTER TABLE `boards`
ADD COLUMN user_id INT;

SELECT * FROM `boards`;

ALTER TABLE `boards`
ADD CONSTRAINT
	FOREIGN KEY(user_id)
	REFERENCES `users`(user_id);
    
DESC `boards`;

ALTER TABLE `boards` DROP FOREIGN KEY `user_id`;

SELECT CONSTRAINT_NAME
FROM information_schema.key_column_usage
WHERE TABLE_NAME = 'boards' AND COLUMN_NAME = 'user_id';

-- boards_ibfk_1
ALTER TABLE `boards` DROP FOREIGN KEY boards_ibfk_1;

DESC `boards`;






























