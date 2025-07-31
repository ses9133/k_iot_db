drop database if exists market_db;
create database market_db;

-- 데이터 베이스 선택 SQL문
use market_db;

-- 회원 테이블 (member)
-- create table 테이블명(컬럼명, 데이터타입, 옵션);
-- 아이디, 이름(아이돌), 인원, 주소, 국번, 전화번호, 평균 키, 데뷔 일자

create table member 
(
	mem_id char(8) not null primary key, -- 회원 아이디
    mem_name varchar(10) not null, -- 회원 이름
    mem_number int not null, -- 인원수
    addr char(2) not null, -- 주소(경기, 서울, 경남 - 2글자만 입력)
    phone1 char(3), -- 연락처의 국번(02, 051, 042 등)
    phone2 char(8), -- 연락처의 나머지 전화번호 (하이픈 제외)
    height smallint, -- 평균 키
    debut_date date -- 데뷔 일자
);

-- 구매 테이블 (buy)
-- 순번, 아이디, 물품명, 분류, 단가, 수량

create table buy 
(
	num int auto_increment not null primary key, -- 순번
    mem_id char(8) not null, -- 아이디(FK)
    prod_name char(6) not null, -- 제품명
    group_name char(4), -- 분류
    price int not null, -- 단가
    amount smallint not null, -- 수량
    foreign key (mem_id) references member(mem_id)
);

-- 각 테이블에 데이터 삽입
-- 회원 테이블 데이터 삽입
insert into member 
values('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015-10-19');
insert into member 
values('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016-08-08');
insert into member 
values('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
insert into member 
values('OMY', '오마이걸', 7, '서울', null, null, 160, '2015.04.21');
insert into member 
VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
insert into member 
VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
insert into member 
VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
insert into member 
VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
insert into member 
VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
insert into member 
VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

-- 구매 테이블
INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '갤럭시버즈', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '갤럭시버즈', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '갤럭시버즈', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

-- ----------------------------------------------------

SELECT * FROM `member`;
SELECT * FROM `buy`;

-- 1. 변수
-- : 데이터를 저장할 수 있는 임시 저장 공간
-- - SQL 에서는 간단한 데이터 연산, 조건 비교, 동적 쿼리 등에 사용

-- 1) 변수 선언 규칙
-- : = (등호)를 기준으로 우항의 데이터를 좌항의 변수에 저장
-- >> set @변수명 = 데이터;

-- 2) 변수 값 출력
-- SELECT @변수명;

-- cf) SQL 변수 특징
-- 1) MySQL 워크벤치 시작시 유지, 종료할 경우 사라짐(임시 저장 공간)
-- 2) SQL 비절차적언어: 원하는 구문을 따로따로 실행해야함

-- SQL 변수 사용 예제 --
-- 변수 선언
set @myVar1 = 5;
set @myVar2 = 3.14; -- @ + lowerCamelCase

select @myVar1;
select @myVar2; -- 변수 초기화문을 실행하지 않으면 null 값 출력

-- 테이블 조회시 변수 사용
SELECT * FROM `member`;

-- 166 이상인 그룹명 출력
set @txt = '가수 이름';
set @height = 166;
set @limitNumber = 1;

SELECT 
	@txt, mem_name, height
FROM
	`member`
WHERE
	height > @height;
-- LIMIT @limitNumber;
-- >> LIMIT 키워에드에는 제한 수의 값을 변수로 사용할 수 없음

-- 동적 프로그래밍을 사용한 변수 사용 --
-- prepare(준비하다), execute(실행하다)
-- cf) prepare: sql 문을 실행하지 않고 준비
-- 	>> ? 키워드를 사용하여 코드 작성시 값이 채워지지 않지만 실행시에는 채워지는 코드 작성 가능

-- cf) execute: prepare 코드 실행

-- prepare 실행시킬문장명(코드블럭명)
-- 		FROM '실제 sql 문';
prepare mySQL
	FROM 'select * from `member` order by height limit ?';

-- execute 실행시킬문장명 using 변수명;
-- >> using 뒤의 변수값이 prepare 문의 ? (물음펴)에 대입됨
set @count = 3;
execute mySQL using @count;

-- set: 변수 선언 (+ 변수명 앞에 @ 기호 사용)
-- SELECT 변수명: 변수값 출력 
-- prepare: 쿼리준비(실행X)
-- execute: 준비된 쿼리 실행
-- ?: 실행시 채워질 자리(플레이스 홀더)
-- using: 플레이스 홀더에 넣을 값 지정



























