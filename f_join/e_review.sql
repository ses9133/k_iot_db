-- korea_db 스키마의 members, purchases 테이블 사용
-- SELECT 구문 + JOIN

/*
	지역별로 -- GROUP BY
    남성 회원들의 -- WHERE
	총 구매 금액을 구하되, -- 집계함수 SUM 
    총 액이 30,000 원 이상인 지역만 추출 -- HAVING 
    총액 기준으로 내림 차순 정렬 -- ORDER BY
    해서 상위 3개의 지역을 조회 -- LIMIT 
*/
-- 쿼리 실행 순서 F J W G H S O L

USE `korea_db`;

-- 1) from + JOIN  : 회원 + 구매 내역이 합쳐진 하나의 가상테이블 작성(구매정보가 있는 회원만 조회)
SELECT 
	*
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id;

-- 2) from + join + where
SELECT 
	*
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
    
WHERE
	M.gender = 'Female';
    
-- 3) FROM + JOIN + WHERE + GROUP 

SELECT 
	*
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Female'
GROUP BY
	area_code;
-- 그룹화를 사용한 테이블의 모든 컬럼을 조회하려고 하니까, 그룹화 되지 않은 컬럼들에 대한 데이터 결합 오류가 남
-- 그룹화된 조건 내에서  SELECT 해야함
    
SELECT 
	area_code, SUM(P.amount) '총 구매금액', COUNT(DISTINCT M.member_id) '회원수' 
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Female'
GROUP BY
	area_code;
    
-- 4) FROM + JOIN + WHERE + GROUP + HAVING + S + O
SELECT 
	area_code, SUM(P.amount) '총 구매금액', COUNT(DISTINCT M.member_id) '회원수' 
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	M.gender = 'Male'
GROUP BY
	area_code
HAVING 
	SUM(P.amount) >= 30000
ORDER BY
	'총 구매금액' DESC
LIMIT 3;

