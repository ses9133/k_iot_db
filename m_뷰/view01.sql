-- 뷰
-- : 데이터 베이스 개체 중 하나
-- - 하나 이상의 테이블을 기반으로 생성된 '가상의 테이블'

-- 1) 뷰의 특정
-- > 실제 데이터를 저장하지 않음
-- > SELECT 문의 결과를 저장한 것 처럼 작동
-- > 일반 테이블 처럼 SELECT 로 조회 가능
-- > 뷰를 통해 데이터를 보호하거나 단순화 할 수 있음

-- 2) 뷰 vs 테이블
-- View
-- - 데이터 저장 
-- - 필요한 데이터만 보는 용도 (INSERT, UPDATE, DELETE 불가능)
-- - 기본 테이블 변경시 자동 반영
-- >> CREATE VIEW 뷰명 AS SELECT문 

-- Table
-- - 데이터 직접 저장 O
-- - 데이터 전체 저장/관리 용도
-- - DML 로 직접 조작해야함
-- >> CREATE TABLE 테이블명 (...);

-- 3) 뷰의 종류
-- - 단순 뷰: 하나의 테이블과 연간된 뷰
-- - 복합 뷰: 2개 이상의 테이블과 연관된 뷰(여러 테이블의 조인을 포함)

use market_db;

select * from member;
select * from buy;

select mem_id, mem_name, addr from member;

/*
	1) 뷰 생성 방법
    CREATE VIEW 뷰_이름
    AS
		SELECT문;
        
	2) 뷰 접근 방법
    : SELECT 문 사용(전체 접근 또는 테이블 조회처럼 조건식 사용 가능)
    SELECT 열이름나열 FROM 뷰_이름
    [WHERE 조건식];
    
    cf) 뷰 이름은 테이블과의 구분을 위해 'v_' 로 시작을 권장
*/

-- 뷰 생성
CREATE VIEW v_member
AS
	SELECT mem_id, mem_name, addr
    FROM
		member;
        
-- 뷰에 접근
SELECT * FROM v_member;
SELECT * FROM v_member
WHERE
	addr IN('서울', '경남');

-- 4) 뷰 작동 방식
-- 1. 사용자가 뷰에 SELECT 쿼리를 실행 (조회)
-- 2. DBMS 가 뷰 내부 SELECT 문을 실행
-- 3. 원본 테이블에서 데이터를 가져와 뷰 형태로 반환
-- >> 뷰는 테이블처럼 보여지지만, 내부적으로 SELECT 문으로 작동됨

-- 5) 뷰 사용 목적
-- 1. 보안성
-- : 민감한 정보를 직접 공개하지 않고, 필요한 정보만 선별하여 제공가능
-- - 주민등록번호, 연락처, 이메일 등을 제외한 고객 정보 뷰 제공

CREATE VIEW v_member_secure
AS
	SELECT mem_name, addr FROM member;
    
SELECT * FROM v_member_secure;

-- cf) DB 개체들은 생성과 삭제시 DDL 문법 사용
DROP VIEW v_member_secure;

-- 2. SQL 쿼리의 단순화
CREATE VIEW v_member_buy
AS
	SELECT 
		B.mem_id, M.mem_name, B.prod_name, M.addr,
        concat(M.phone1, M.phone2) '연락처'
    FROM 
		buy B
        JOIN member M
        ON B.mem_id = M.mem_id;
        
SELECT * FROM v_member_buy
WHERE
	mem_name = '블랙핑크';

-- 뷰 모범사례
-- : 통계용, 필터링, 보안용 뷰 등 다양하게 사용

-- cf) 뷰 (View) 와 스프링 부트 연동
-- SpringBoot 는 주로 JPA 또는 MyBatis 를 통해 DB 와 연동
-- - 이 때, 뷰는 일반 테이블처럼 인식

-- cf) 뷰 VS 반정규화
-- 뷰: 실제 데이터를 복제하지 않고 조인 결과를 미리 정의 ('마치 테이블 처럼')
-- 반정규화: 정규화된 테이블을 의도적으로 중복하거나 조인없이 바로 조회할 수 있도록 재구성한 것 - 성능 최적화를 위해














