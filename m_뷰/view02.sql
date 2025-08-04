-- 뷰의 실제 생성, 수정, 삭제 
USE market_db;

CREATE VIEW v_view_test01
AS
	SELECT 
		B.mem_id "Member ID", M.mem_name "Member Name"
        , B.prod_name "Prouct Name"
        , concat(M.phone1, M.phone2) AS 'Office Phone'
    FROM
		buy B
        JOIN member M
        ON B.mem_id = M.mem_id;
        
SELECT * FROM v_view_test01;

-- 조회시 컬럼 이름에 공백이 있을경우 백틱으로 지정
SELECT DISTINCT `Member ID`, `Member Name` FROM v_view_test01;

-- 뷰의 수정 : SELECT 문으로 전체 새로 만들어야함
ALTER VIEW v_view_test01
AS
	SELECT 
    B.mem_id "회원 아이디", M.mem_name "회원 이름"
        , B.prod_name "제품 이름"
        , concat(M.phone1, M.phone2) AS '연락처'
    FROM
		buy B
        JOIN member M
        ON B.mem_id = M.mem_id;
        
SELECT * FROM v_view_test01;

-- cf) 테이블 생성시 ' 존재 여부에 대한 옵션 '
-- 			IF EXISTS, IF NOT EXISTS

-- >> 뷰는 존재여부에 관계없이 생성
-- 	: CREATE OR REPLACE (생성 또는 대체)
-- 	- 기존에 뷰가 있으면 덮어쓰고, 없으면 새로 생성
CREATE OR REPLACE VIEW v_view_test02
AS
	SELECT mem_id, mem_name FROM member;
 
 -- cf) 뷰 정보 확인
-- : DESC - 열(컬럼) 정보 확인 (PK, 제약조건은 확인 불가능함)
DESC v_view_test02;

-- cf) show create view 뷰이름;
-- : 생성된 뷰의  SQL 쿼리 확인
SHOW CREATE VIEW v_view_test02;
-- VIEW `v_view_test02` AS select `member`.`mem_id` AS `mem_id`,`member`.`mem_name` AS `mem_name` from `member`'

-- cf) 뷰를 통한 데이터 수정/삭제 가능
-- : 뷰를 통해 원본 테이블의 데이터 수정 가능
-- - 단! 뷰에 포함되지 않은 컬럼에 대한 제약조건이 있을 경우, 제한될 수 있음 (권장 X)

-- member 테이블 - mem_id, mem_name(NOT NULL), addr 
-- > member 테이블로 생성한 v_member 뷰는 mem_id, addr 만 존재한다고 가정했을 때,
-- > 뷰에서 데이터 삽입시 mem_name 데이터에 대한 무결성 위반으로 삽입 불가!

















