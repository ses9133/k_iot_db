/*
	==== JOIN ====
    : 두 개 이상의 테이블을 연결하여 하나의 결과 집합을 만들어내는 SQL 기능
    - 테이블 간의 관계를 활용하여 관련 데이터를 결합
    - 공통된 열(COLUMN)을 기준으로 연결됨
    
    1. 조인의 종류
    1) 내부 조인 (INNER JOIN)
		: 조건에 일치하는 데이터만 결합 (교집합)
        - 정확히 일치하는 데이터만 보고 싶을때 사용
        
    2) 외부 조인 (OUTER JOIN)
		: 조건이 불일치해도 포함 (합집합, null 포함)
        - 빠진 데이터를 확인하거나 전체 조회시 사용
        
	3) 상호 조인(CROSS JOIN)
		: 모든 조합 반환 (곱집합 - A 테이블 * B 테이블)
        - 두 테이블의 모든 조합
    
    4) 자체 조인(SELF JOIN)
		: 자기 자신과의 조인 (자신과 비교)
        - 상위/하위 관계, 이전/다음 비교

*/

-- 1. 내부조인 (INNER JOIN)
-- : 두 개 이상의 테이블에서 공통된 컬럼의 값이 일치하는 행만 조회
-- : 일치하는 데이터가 없으면 해당 행은 결과에 포함되지 않음
-- - 일대다(1:N) 관계에서 주로 사용

-- CF) members 테이블 - purchases 테이블 (1명의 회원이 여러 구매기록을 가질 수 있음)
-- 		employees 	-  salaries 		(1명의 직원이 여러 급여 기록을 가질 수 있음)

-- 내부조인의 형태
/*
	SELECT 열 목록
    FROM 기준 테이블 AS 별칭1
		INNER JOIN 조인 테이블 AS 별칭2
        ON 조인될 조건 (결합 조건)
    [WHERE 조건식...];
    
    CF) INNER 키워드 생략 가능
    => JOIN : 자동으로 내부 조인으로 인식됨
*/

-- 내부 조인 예제 1
-- : 특정 회원이 구매한 상품 확인
SELECT * from `purchases` 
WHERE member_id = 1;

-- +) 해당 특정 회원의 정보까지 포함해서 조회 --> 하려면 INNER JOIN 이 필요함
SELECT
	P.purchase_id, P.member_id, M.name, M.area_code
FROM 
	`purchases` AS P -- 별칭은 주로 첫 문자를 대문자로 사용
    INNER JOIN `members` AS M
    ON P.member_id = M.member_id
WHERE
	P.member_id = 1;
    
-- 조인시 두개 이상의 테이블에서 동일한 열 이름이 존재하는 경우, 별칭.열이름 형식으로 표기. (어떤 테이블의 속성을 쓸 지 ambiguos 하기 때문)

-- 내부 조인 예제 2
-- : 금액일 20000원 이상인 모든 구매 내역 조회
SELECT * from `purchases` 
WHERE
	amount >= 20000;
    
-- +) 회원이름, 구매날짜, 금액 조회
SELECT 
	M.member_id, P.purchase_date, P.amount
from 
	`purchases` AS P
    JOIN `members` AS M
    ON P.member_id = M.member_id
WHERE
	amount >= 20000;
    
-- 내부 조인 예제 3
-- 회원별 총 구매 금액을 내림차순 정렬
SELECT 
	M.name, SUM(P.amount) total_purchases
FROM
	`members` M
	JOIN `purchases` P
    ON M.member_id = P.member_id
GROUP BY
	M.name
ORDER BY
	total_purchases DESC;

-- 내부 조인 예제 4
-- : 구매이력이 있는 회원만 조회
SELECT
	DISTINCT M.name, M.contact -- 조인한 테이블의 테이블의 데이터가 반드시 조회될 필요는 없음
FROM
	`members` M
	JOIN `purchases` P
    ON M.member_id = P.member_id;

-- cf) 구매이력이 있는 회원 조회 (서브쿼리)
-- : 위의 조인과 결과는 동일하지만 서브쿼리 테이블의 데이터 조회는 불가능함
SELECT
	name, contact
FROM 
	`members`
WHERE
	member_id IN(
		SELECT 
			DISTINCT member_id
		FROM 
			`purchases` P
    );
    

-- 내부 조인 사용시 주의점
-- 1) 동일한 컬럼 이름: 반드시 별칭.컬럼명 형태로 구분하여 작성
-- 2) 기준 테이블 선택: 주로 1(일) 테이블을 기준으로 조인
-- 3) 조인 순서 FROM A JOIN B != FROM B JOIN A (결과는 같지만 기준이 다름)
-- 4) 조건이 일치하지 않는 행은 결과에서 누락됨

-- 예시
-- 1) 회원 + 구매: 회원이 무엇을 삿는지 분석
-- 2) 직원 + 부서: 직원이 어떤 부서에 소속되어있는지
-- 3) 학생 + 성적: 학생의 성적 관리
-- 4) 주문 + 상품: 어떤 상품이 주문되었는지 확인





















































































