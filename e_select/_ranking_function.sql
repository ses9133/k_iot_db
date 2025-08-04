-- # 순위 함수 (Ranking Function)
-- : 특정 그룹내에서 정렬된 순서를 매기는 함수
-- : row_number(), rank(), dense_rank() 함수
-- - over() 구문과 함께 사용

-- 1. ROW_NUMBER()
-- : 중복을 무시 (항상 1, 2, 3 ... 차례대로)
-- - 건너뀜 없음
-- - 고유한 번호를 순서대로 부여

-- 2. RANK()
-- : 중복 순위 허용
-- : 중복 이후 순위 건너뜀
-- ex) 1, 2, 2, 4 ...( 3 건너뜀)

-- 3. DENSE_RANK()
-- : 중복 순위 허용
-- - 순서 건너뜀 없음
-- ex) 1, 2, 2, 3 ... (연속 순위)

use korea_db;

select * from members;
select * from purchases;

UPDATE `korea_db`.`purchases`
SET amount = 45000
WHERE purchase_id = 6;

-- "가장 많은 총 구매 금액을 기록한 회원"을 기준으로 순위 매김

-- 예제 1) ROW_NUMBER()
-- : 동점이 있어도 중복없이 고유한 순위를 가짐
select 
	ROW_NUMBER() OVER (ORDER BY SUM(P.amount) DESC) AS `row_num`,
    M.name,
    SUM(P.amount) AS total_amout
from
	members M
    JOIN purchases P
    ON M.member_id = P.member_id
GROUP BY
	M.member_id;

-- cf) OVER()
-- 		: 윈도우함수, 분석함수와 함께 사용됨
-- 		- 전체 결과 집합이나 파티션 (부분집합) 에 대해 행별로 추가적인 계산을 수행

/*
	<윈도함수> OVER(
		[PARTITION BY 열]
        ORDER BY 열
    )
    
    - 윈도 함수: ROW_NUMBER(), RANK(), DENSE_RANK(), SUM(), AVG(), PARTITION BY등
		>> DB 의 행 단위 계산시, 그룹 전체가 아닌 윈도(Window)라고 불리는 범위 내에서의 집계나 순위 연산
        
	- PARTITION BY (선택)
    : 그룹으로 나눠서 각 그룹 내에서 순위나 집계 수행
    - order by
    :  정렬 기준(순위 계산시 필수)
*/

-- 예제 2) RANK()
-- : 총 구매금액 기준 동점 순위 허용 - 순서 건너뜀 발생
select 
	RANK() OVER (ORDER BY SUM(P.amount) DESC) AS `rank`,
    M.name,
    SUM(P.amount) AS total_amout
from
	members M
    JOIN purchases P
    ON M.member_id = P.member_id
GROUP BY
	M.member_id;
    
-- 예제 3) DENSE_RANK
-- : 총 구매 금액 기준 동점 순위 허용 - 순위 건너뛰기 X
select 
	DENSE_RANK() OVER (ORDER BY SUM(P.amount) DESC) AS `dense_rank`,
    M.name,
    SUM(P.amount) AS total_amout
from
	members M
    JOIN purchases P
    ON M.member_id = P.member_id
GROUP BY
	M.member_id;




















