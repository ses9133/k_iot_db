/*
	인덱스
    : select 문으로 데이터조회시, 원하는 데이터를 더 빠르게 찾아주는 도구
    - 데이터 검색 속도 향상 >> 전ㅊ ㅔ시스템 성능을 높임
    
    ex) 책에서 원하는 단어를 찾을 쌔 사용하는 '찾아보기(색인)'
    
    1. 인덱스의 종류
    1) 클러스터형 인덱스
		: 기본키(PK) 설정시 자동 생성
        - 테이블 당 단 하나만 생성 가능!
        - 자동 정렬 기능 포함: 지정된 열 (기본키 컬럼)을 기준으로 자동 정렬
 */
 select * from `A`;
 -- 위의 쿼리문 처럼 order by 문이 없으면 클러스터형 인덱스를 기준으로 정렬
 -- ex) 사전: 내용이 미리 정렬
 
 /*
    2) 보조 인덱스 
    : 고유키(Unique key) 설정시 자동 생성
    - 테이블 당 여러개 생성 가능
    - 자동 정렬 기능 포함 X
    ex) 일반 서적: 색인(찾아보기 같은 기능) 등의 페이지 번호를 보고 해당 위치로 이동해야 내용 확인 가능
*/

-- 인덱스 사용 예시
create database idx_db;
use idx_db;

create table table1 (
	col1 int primary key,
    col2 int,
    col3 int
);

-- 인덱스 정보 확인 :show index from 테이블명
show index from table1;
-- Non_unique: 중복 가능 여부
-- >> 0 (False) : 중복 허용이 되지 않는 인덱스 (유일한 값들로만 구성되어야함) (PK 나 Unique 로 설정되어있는가)
-- >> 1 (True): 중복 가능한 인덱스

-- Key_name : PRIMARY(기본키로, 자동 생성된 인덱스 임을 명시)
-- Column_name: 인덱스가 부여된 컬럼명

-- Seq_in_index: 인덱스 안에서의 컬럼 순서
-- >> 복합키를 인덱스로 사용하는 복합 인덱스에서 두 개의 컬럼의 순서를 의미 (우선순위)

create table table2 (
	col1 int primary key,
    col2 int unique,
    col3 int unique
);

show index from table2;
-- Key_name: 열 이름 지정시 - 보조 인덱스
--  		>> PRIMARY 라고 적혀있으면 클러스터형 인덱스
-- Non_unique: 고유키 중복 허용 X
-- Null: YES(NULL 허용)

-- 인덱스 활용
create database 인덱스;
use 인덱스;

drop table if exists members, purchases;

create table members (
	mem_id char(8),
    mem_nmae varchar(10),
    mem_number int,
    addr char(2)
);

insert into members 
values 
	('IVE', '아이브', 6, '서울'),
	('BLK', '블핑', 4, '부산'),
	('LSF', '르세라핌', 5, '경기'),
	('ASF', '에스파', 4, '경남');

select * from members;
-- 멤버 테이블은 PK 값이 없음(클러스터형 인덱스X)
-- -> 데이터 삽입 순서대로 출력

show index from members;

-- PK 설정(클러스터형 인덱스 생성)
alter table members 
add constraint primary key (mem_id);

select * from members; -- mem_id 기준으로 오름차순 정렬되어 조회됨
show index from members;

insert into members
values 
	('H2H', '하츠투하츠', 7, '대전');
    
select * from members; -- 인덱스 저장후(PK 설정후) 추가 데이터 삽입시, 정렬 기준(mem_id , 즉 PK)에 따라 자동정렬되어 조회됨

-- 정렬되지 않는 보조 인덱스
-- : 고유키 지정시 생성/ 테이블당 여러 개 가능/ 정렬X
drop table members;

create table members (
	mem_id char(8),
    mem_nmae varchar(10),
    mem_number int,
    addr char(2)
);

insert into members 
values 
	('IVE', '아이브', 6, '서울'),
	('BLK', '블핑', 4, '부산'),
	('LSF', '르세라핌', 5, '경기'),
	('ASF', '에스파', 4, '경남');
    
alter table members 
add constraint unique(mem_id);

select * from members; -- unique 설정해도 정렬 순서 그대로임 

show index from members;

insert into members
values 
	('H2H', '하츠투하츠', 7, '대전');
    
select * from members; -- 데이터 삽입한 순서대로 조회됨

-- 보조인덱스의 경우 정렬되지는 않지만 성능적인 향상이 이루어짐
    
