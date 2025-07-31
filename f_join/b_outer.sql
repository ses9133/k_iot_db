-- 2. 외부 조인(OUTER JOIN)
-- : 한 쪽 테이블에만 존재하는 데이터까지도 결과로 포함하는 조인 방식
-- : 조건에 일치하지 않아도 기준 테이블의 행은 모두 조회됨
-- : 일치하지 않는 열은 NULL 로 채워짐

-- CF) 외부 조인 종류
-- 1) LEFT OUTER JOIN
--    - 기준 테이블의 위치가 왼쪽 (FROM 뒤의 테이블을 의미)
-- 	  - 포함범위가 <왼쪽 테이블의 모든 행 + 매칭된 오른쪽 테이블>
-- 2) RIGHT OUTER JOIN
--    - 기준 테이블 위치가 오른쪽임 (JOIN 키워드 뒤의 테이블을 의미)
--    - 포함범위가 <오른쪽 테이블의 모든 행 + 매칭된 왼쪽 테이블>
-- 3) FULL OUTER JOIN
-- 	  - 양쪽 모두, 두 테이블의 모든 행이 조회됨
--    - MySQL 지원 XX

/*
	## 외부 조인 형태
    SELECT
		열목록
	FROM 	
		기준 테이블 AS 별칭
        LEFT OUTER JOIN 조인할 테이블
		ON 조인될 조건
	[WHERE 조건식 ...];
    
    CF) OUTER 키워드 생략 가능 - LEFT JOIN, RIGHT JOIN 가능
*/

-- 외부 조인 예제1
-- : 왼쪽 테이블의 모든 레코드와 오른쪽 테이블의 매칭되는 레코드만 포함
SELECT
	M.member_id, M.name, P.product_code, M.area_code
FROM
	`members` M -- M 테이블의 모든 컬럼 출력됨. 일치하지 않는 값은 null
    LEFT OUTER JOIN `purchases` P
    ON M.member_id = P.member_id;
    
-- 외부 조인 예제2
-- : 오른쪽 테이블의 내용을 모두 출력
SELECT 
	M.member_id, M.name, P.product_code, M.area_code
FROM
	`purchases` P
	RIGHT OUTER JOIN `members` M -- M 테이블의 모든 컬럼이 출력됨
    ON M.member_id = P.member_id;

-- 외부 조인 예제3
-- 구매이력이 없는 회원만 출력
SELECT
	M.member_id, P.product_code, M.name, M.contact
FROM
	`members` M  -- 기준 테이블
	LEFT OUTER JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE 
	P.product_code IS NULL;

-- MySQL 은 FULL OUTER JOIN 지원 X -> UNION 으로 대체

-- 외부 조인 사용시 주의점
-- 1) 기준 테이블 위치: LEFT OUTER JOIN 경우, 왼쪽 테이블이 기준 (FROM 뒤의 ㅌ ㅔ이블)
-- 2) OUTER 키워드 생략 가능
-- 3) IS NULL : 외부 조인후 일치하지 않는 데이터를 찾을 떄 사용(차집합)


















