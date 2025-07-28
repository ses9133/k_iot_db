## c_ddl > c_datatype
-- DataType --

-- SQL 의 데이터 형식(정수형, 문자형, 실수형, 논리형, 날짜형) 

/*
	1. 정수형
    : 숫자 데이터 저장, 데이터 종류에 따라 메모리 사용 공간이 다름
    
    1) tinyint (1byte: 8bit)
    : -128 ~ 127
    ex) 나이, 성별코드, 성적 등
    
    2) smallint (2byte: 16bit)
    : -32,768 ~ 32,767
    ex) 우편번호, 사원번호 등
    
    3) int(4byte: 32bit)
    : 약 -21억 ~ 약 21억
    : 일반적인 용도로 가장 많이 사용되는 정수형 타입
    ex) 주문번호, 고객 ID 등
    
    4) bigint (8byte: 64 bit)
    : 약 -900 경 ~ 약 900 경
    ex) 금융권, 천문학에서 주로 사용 / 각 테이블의 식별값
    
    +) 대구모 서비스에서는 사용자, 게시글, 주문등 각종 데이터가 수억 ~ 수십억 건 이상 가능
		>> int 범위의 초과가 늘고 있다.
        >> 안전설계를 위해 bigint 값 사용량이 증가하고 있음
*/

CREATE DATABASE IF NOT EXISTS `example`;
USE `example`;

CREATE TABLE `integer` (
	t_col tinyint, 
    s_col smallint,
    i_col int,
    b_col bigint
);

-- INSERT : 데이터 삽입
-- INSERT INTO 테이블명 value (레코드값을 컬럼순으로 콤마로 구분하여 나열);
INSERT INTO `integer`
VALUE(127, 32767, 200000000, 90000000000000);
    
-- INSERT INTO `integer`
-- VALUE(128, 32767, 200000000, 90000000000000); -- Error Code: 1264. Out of range value for column 't_col' at row 1 => 해당 데이터 타입을 벗어나는 경우 발생

-- cf) unsigned: 부호가 없는 정수
-- : 각 숫자형 데이터 타입의 시작을 0 부터 가지는 옵션
-- : 범위는 그대로 인식(ex. tinyint: 0 ~ 255 까지)
-- ex) 키, 나이, 가격, 점수 등 음수값이 없는 데이터 설정시 사용
CREATE TABLE person(
	age tinyint unsigned, 	-- 나이 0 ~ 255
    height smallint unsigned -- 키 0 ~ 65535
);

DESC person;

INSERT INTO person 
VALUE(128, 32768);

/*
	2. 문자형 
    : 텍스트 데이터 저장
    - char(개수), varchar(개수)
    
    cf) char: character 문자열
		varchar: variable character field 가변 길이 문자열
        
	1) char(개수)
    : 고정 길이 문자열, 1 ~ 255 바이트
    - 길이가 항상 일정하기 때문에 검색 속도가 빠름
    - 선언된 길이내에서 필요한 만큼만 데이터를 저장
    ex) 성별, 국가코드(KOR, CHI, USA 등)
    
    2) varchar(개수)
    : 가변 길이 문자열, 1 ~ 1638 바이트 (255 바이트 까지만 개수작성 가능)
    - 길이가 일정하지 않아 검색 속도가 느림
    - 선언된 길이 내에서 필요한 만큼만 데이터를 저장
    - 비워진 메모리는 사라짐 (메모리 누수를 방지)
    ex) 주소, 상품명 등
    
    cf) 문자 수와 바이트 수의 차이
    - 영어: 1바이트에 1개의 알파벳
    char(3): KOR 
    - 한글: utf-8 인코딩 기준 한 글자당 약 3바이트를 사용
	varchar(255): 255 / 3 = 약 85자의 한글 가능
    
    +) 다량의 텍스트 데이터 형식
		- text 형식: 1 ~ 약 65000 바이트 (blob)
        - longtext 형식 : 1 ~ 약 42 억 바이트 (longblob)
        
        cf) blob: binary long object(이미지, 동영상 등의 데이터)
*/

CREATE TABLE `character` (
	name varchar(100), -- 제품명
    category char(10),
    description text, 
    image blob 			-- 제품의 이미지(대용량 파일)
);

DESC `character`;

INSERT INTO `character`
	VALUES (
    'Laptop Samsung Book 3 Pro', 
    '전자제품', 
    '삼성 갤럭시 북 3 노트북 프로입니다ㅏ아아ㅏ', 
    'example'
);

/*
	3. 실수형
    : 소수점이 있는 숫자를 저장시 사용
    - float, double, decimal
    
    1) float 
		: 소수점 이하 표현 (총 7자리 표현)
        - 소수점 이하는 2자리까지만 가능(정수 5자리)
        ex) 시력, 가격(달러) 등에 사용
        
	2) double
		: 소수점 이하 표현 (총 10자리 표현)
        - 소수점 이하는 4자리까지 (정수 6자리)
        - 구체적인 값을 표현할 수 있음(float 에 비해)
        ex) 정밀 측정값, GPS 좌표, 복잡한 공학 계산 등에 사용
        
	3) decimal (또는 numeric)
		: 고정 소수점 타입, 정밀한 소수점 계산에 사용
        - 금융, 회계, 세금 계산 등에 적합 (반올림 X, 손실 X)
*/

CREATE TABLE product(
-- 실수형 데이터는 함수 형태로 사용
-- 데이터타입(전체자리수, 소수점이하 자리수)
    price1 float(7, 2),	-- float,  double 의 형태로만 사용 권장
    -- price1 float (자리수를 지정할 수도 있지만, 왼쪽과 같이 쓰는 것을 권장)
    price2 double(10, 4),
    -- price double (권장)
    price3 decimal(15, 2) -- decimal 은 실제 자리수 사용을 권장
);


INSERT INTO product
VALUES (
	12345.67,
    123456.7890,
    999999999999.99
);

/*
	4. 논리형
    : boolean 값을 저장하기 위한 데이터 타입
    - 논리적으로 true, false 값을 나타냄
    cf) 비워 둘 경우 null (알 수 없음, 부재한 값) 으로 인식
    cf) MySQL 에서는 Boolean 타입이 존재하지만, 실제 (내부적으로) 로는 tinyint(1) 로 처리
		>> true 는 1로 저장, False 는 0 으로 저장됨
	cf) Boolean 값에 대소문자 구분 X
*/

CREATE TABLE employee(
	is_senior Boolean
);

INSERT INTO employee
VALUES (true);

SELECT * FROM employee; -- true 값이 1로 변환되어 저장됨
DESC employee;
















