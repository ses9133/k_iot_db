/*
	== SELECT (선택하다, 조회하다) ===
    : DB 는 '어떻게' 보다 '무엇을' 가지고 오는지가 중요함
    >> '무엇을' 선택할 것인지 결정하는 키워드 - SELECT
    
    ## SELECT 문의 기본 구조 ('작성 순서': 순서는 1번부터 7번까지 차례대로 써야함) SF WGHOL
    1. SELECT 컬럼명(열 목록): 원하는 컬럼(열) 지정
    2. FROM 테이블명: 어떤 테이블에서 데이터를 가져올 지 결정
    --- 
    3. WHERE 조건식: 특정 조건에 맞는 데이터만 선택(필터링)
    4. GROUP BY 그룹화할컬럼명: 특정 열을 기준으로 그룹화
	5. HAVING 그룹조건: 그룹화 된 데이터에 대한 조건 지정
    6. ORDER BY 정렬할컬럼명: 결과를 특정 컬럼의 순서로 정렬
    7. LIMIT 컬럼수제한: 반환할 행의 수를 제한
    
    CF) DB 내부 실제 실행 순서
    FROM -> JOIN -> WHERE(필터링) -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
    FWGHSO
*/
USE korea_db;

-- 1. 기본조회
-- : SELECT 컬럼명 FROM `DB명`.`테이블명`; 
SELECT `name` FROM `korea_db`.`members`;
-- > 정렬하지 않고 조회시 데이터 입력 순서대로 출력됨

-- cf) 전체 컬럼 조회
-- 컬럼명 작성에 * (전체)를 사용하여 조회
SELECT * FROM `korea_db`.`members`;
SELECT * FROM `korea_db`.`purchases`;

-- cf) 두개 이상의 컬럼 조회시 , (콤마) 로 구분하여 나열
SELECT
	`member_id`, `name`, `contact`
FROM 
	`members`;

-- cf) alias 별칭 부여 조회(AS 키워드)
-- : 별칭을 부여하지 않을 경우 테이블 생성시 지정한 컬럼명으로 조회됨
-- - 컬럼명이 변경되는 것이 아니라, 조회 당시에만 사용됨
-- - 공백 사용시 따옴표로 반드시 지정
SELECT
	`member_id` AS 고유번호, `name` AS '회원 이름', `contact` AS '회원 연 락 처'
FROM 
	`members`;

# 2. 특정 조건에 부합하는 데이터 조회
-- : SELECT A FROM B WHERE C(A: 컬럼명, B: 테이블명, C: 조건식-연산자)
SELECT
	`member_id`, `name`, `points`
FROM
	`members`
WHERE
	-- 조건절에는 true/false(논리값)을 반환하는 연산자를 사용
	points > 200;

-- 1) 관계 연산자
-- : 이상, 이하, 초과, 미만, 일치(=), 불일치(!=)
SELECT * FROM `members`
	WHERE name='Minji';
    
-- 2) 논리 연산자
-- and, or, not
-- : 여러 조건을 조합하여 데이터 조회

-- and
SELECT * FROM `members`
WHERE 
	area_code='Jeju' AND points >= 400;
	

-- OR
SELECT * FROM `members`
WHERE 
	area_code='Busan' OR area_code='Seoul';
    
-- NOT
SELECT * FROM `members`
WHERE 
	NOT area_code = 'Busan';
    
-- 3) NULl 값 연산
-- : 직접적인 연산 불가능
SELECT * FROM `members`
WHERE
	points != NULL;  -- XXXX
    
SELECT * FROM `members`
WHERE
	points = NULL; -- XXX
 
-- cf) NULL 은 그 어던 값과도 비교하거나 연산이 불가능
-- IS NULL, IS NOT NULL 만 사용 가능 - NULL 여부 확인 가능(TRUE/FLASE 반환)
SELECT * FROM `members`
WHERE
	points IS NULL;
    
SELECT * FROM `members`
WHERE
	points IS NULL;
    
-- 4) BETWEEN A AND B
-- : 숫자형 데이터, 날짜형 데이터에 주로 사용
SELECT * FROM `members`
WHERE
	points BETWEEN 200 AND 400; -- 이상, 이하 
    
SELECT * FROM `members`
WHERE 
	join_date BETWEEN '2021-12-31' AND '2022-01-04';

-- 5) IN 연산자
-- : 지정할 범위의 문자 데이터를 나열
-- : 지정된 리스트 중에서 일치하는 값이 있으면 참
SELECT * FROM `members`
WHERE
	area_code IN ('Seoul', 'Busan', 'Jeju');
-- 문자열 데이터에 대한 OR 식 간소화

-- 6) LIKE 연산자
-- : 문자열 일부를 검색
-- : 와일드 카드 문자
-- _(언더스코어), %(퍼센트)
# _: 하나의 기호가 한 글자를 허용 (정확하게 하나의 임의의 문자 공간을 나타냄)
# %: 무엇이든지 허용 (0개 이상의 임의의 문자 공간을 나타냄)

-- 시작이 J 이고 뒤는 0개 이상의 문자를 허용하는 단어 검색
SELECT * FROM `members`
WHERE
	name LIKE 'J%'; -- Jin, Joon
    
-- 시작이 J 이고 뒤는 3개의 임의의 문자를 허용하는 검색
SELECT * FROM `members`
WHERE
	name LIKE 'J___';	-- Joon
    
-- 어떤 문자열 내에서든 'un' 이 포함만 되면 허용하는 검색
SELECT * FROM `members`
WHERE
	name LIKE '%un%';

-- 1개의 임의의 문자 + u + 0개이상의 임의의 문자 허용하는 검색 (이름의 두번째 글자가 u인 모든 회원조회)
SELECT * FROM `members`
WHERE
	name LIKE '_u%';

-- 이름이 4글자인 모든 회원 조회 
SELECT * FROM `members`
WHERE
	name LIKE '____';
    
-- 날짜와 시간 조회
-- DATE: 'YYYY-MM-DD'
-- TIME: 'HH:mm:SS'

-- 일치, 불일치 ( =, !=)
-- 기간값 조회(BETWEEN A AND B)

-- cf) 특정시간 기준 그 이후의 데이터 조회
SELECT * FROM `members`
WHERE
	join_date > '2022-01-02';
    
-- cf) 날짜나 시간의 특정 부분과 일치하는 데이터 조회
-- 날짜: year(컬럼명), month(컬럼명), day(컬럼명)
-- 시간: hour(컬럼명), minute(컬럼명), second(컬럼명)

SELECT * FROM `members`
WHERE
	YEAR(join_date) = '2024';
    
-- CF) 현재 날짜나 시간을 기준으로 조회
-- CURDATE(): 현재 날짜만 반환 (시간 x)
-- NOW(): 현재 날짜 + 시간 

SELECT * FROM `members`
WHERE
	join_date < CURDATE();
    
SELECT CURDATE();
SELECT NOW();




















































