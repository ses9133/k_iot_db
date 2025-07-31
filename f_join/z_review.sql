--  문제1
/*
	모든 회원의 이름, 등급, 구매한 상품 코드, 구매일, 구매 금액(amount)을 조회하세요.
	구매 기록이 없는 회원도 모두 포함되도록 하세요. 2 5 6 7 9 10
	단, 구매일이 오래된 순으로 정렬하세요.
*/
SELECT
	M.name, M.grade, P.product_code, P.purchase_date, P.amount
FROM
	`members` M
    LEFT OUTER JOIN `purchases` P
    ON M.member_id = P.member_id
ORDER BY
	P.purchase_date ASC;

/*
	문제 2
	2023년 이후 가입한 회원 중 구매 총액이 30000원 이상인 
    회원의 이름, 지역코드, 총 구매금액을 조회하세요.
*/
SELECT * FROM korea_db.purchases;
SELECT * FROM korea_db.members;

SELECT
	M.name,
    M.area_code, 
    SUM(amount) AS '총 구매금액'
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
WHERE
	YEAR(P.purchase_date) >= 2023 
GROUP BY
	M.member_id
HAVING
	SUM(amount) >= 30000;
-- 
SELECT
	M.name,
    M.area_code, 
    SUM(amount) AS '총 구매금액'
FROM
	`purchases` P
    JOIN `members` M
    ON M.member_id = P.member_id
WHERE
	YEAR(P.purchase_date) >= 2023 
GROUP BY
	M.member_id
HAVING
	SUM(amount) >= 30000;
    
/*
	문제 3
	회원 등급별로 구매 총액 평균을 구하고,
	회원 등급(grade), 구매건수(COUNT), 구매총액합계(SUM), 구매평균(AVG)을 모두 출력하세요.
	단, 구매가 한 건도 없는 등급은 제외하세요.
*/
SELECT
	grade, COUNT(P.purchase_id) '구매건수', SUM(amount) '구매총액합계', AVG(amount) '구매평균'
FROM
	`members` M
    JOIN `purchases` P
    ON M.member_id = P.member_id
GROUP BY
	M.grade;


