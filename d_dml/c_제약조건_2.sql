/*
	1. PK - 중복 X, NOT NULL
    2. FK - 다른 테이블의 PK 값을 참조하는 컬럼 (테이블 간의 연결담당)
    3. Unique 
    : 특정 열의 값이 중복되면 안됨, NULL 허용은 가능
    : 한 테이블에 여러 개 지정 가능
    ex) 이메일 등에 사용

*/
CREATE TABLE `users2` (
	user_id BIGINT PRIMARY KEY,
    user_name VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    resident_number VARCHAR(100) UNIQUE
);

INSERT INTO `users2` 
VALUES
	(1, 'qwe123', 'qwer123123', 'qwer123@naver.com', '123456');
    
INSERT INTO `users2` 
VALUES
	(2, 'qwe123', 'qdfasdg12312', 'qwer123@naver.com', '16541');
    -- Error Code: 1062. Duplicate entry 'qwe123' for key 'users2.user_name'
    
INSERT INTO `users2` 
VALUES
	(2, 'asdfa', 'qdfasdg12312', null, '16541'); -- 유니크는 null 가능
    
/*
	4. Check 제약 조건
    : 입력값이 특정 조건을 만족해야만 삽입
*/
CREATE TABLE `employees` (
	employee_id BIGINT PRIMARY KEY,
    name VARCHAR(100),
    age INT, -- 정수의 최대값 제약
    -- CHECK 제약 조건 사용방법
    -- CHECK(조건작성)
    CHECK(age >= 20)
);

INSERT INTO `employees` 
VALUES 
	(1, '이상은', 30),
	(2, '홍기수', 20), 
-- (3, '배혜진', 10), -- check constraint 'employees_chk_`' is violated
	(4, '김태양', 30); 
    
INSERT INTO `employees`
VALUES
	(5, '안미량', null); -- check 제약 조건은 null 여부 확인 X
	
/*
	5. NOT NULL 제약 조건
    : 특정 열에 NULL 값을 허용하지 X
    - 비워질 수 X
*/    
CREATE TABLE `contacts` (
	contact_id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL
);    

INSERT INTO `contacts` 
VALUES 
	(1, '권민현', '010-1111-2322'),
	-- (2, '김세훈', null); -- Error Code: 1048. Column 'phone' cannot be null
    (2, '김세훈', '010-1111-3157');
    

    

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    