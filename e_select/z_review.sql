/*
	1. DDL vs DML
    
    1) DDL
    : DB의 구조 정의
    - CREATE, ALTER, DROP, TRUNCATE
    
    2) DML
    : 데이터 조작(CRUD)
    - INSERT, SELECT, UPDATE, DELETE

	2. SELECT 문의 기본 구조 (작성 순서)
    
    SELECT 
		컬럼명1, 컬럼명2...
        1) 모든 컬럼 조회시 * (테이블 정의시 작성되는 컬럼순으로 표시)
        2) 조회시의 컬럼 별칭: AS 키워드로 작성 (+ 생략 가능)
	FROM
		테이블명
	WHERE
		조건식
	GROUP BY
		그룹기준 (그룹화하기위해서는 묶일 수 있는 데이터만 조회가능)
	HAVING
		그룹조건 (반드시 그룹화된 이후 사용)
	ORDER BY
		정렬 기준
		1) 기본 값(생략시) ASC
        2) DESC
	LIMIT
		개수 제한;
		+) OFFSET 으로 시작 열 지정 가능 (0부터 시작)
*/

/*
	SELECT 문 실행 순서 FWGHSO
    1) FROM 
    2) WHERE
    3) GROUP BY
    4) HAVING
    5) SELECT
    6) ORDER BY
    7) LIMIT
    
    +) DISTINCT: 중복되는 데이터를 제거하고 단 하나만 남김
    SELECT DISTINCT 컬럼명 FROM ~~
*/

/*
	WHERE 절 연산자 정리
    
	1) 비교 연산자: 부등호, =, !=
    
	2) 논리 연산자: AND, OR, NOT
    
    3) NULL 체크: IS NULL, IS NOT NULL
    
    4) 범위 연산자: BETWEEN A AND B (A이상 B이하) (숫자형, 날짜형)
    
    5) 목룍 연산자: IN(값1, 값2, ...)
    
    6) 패턴 연산자: 와일드카드(_, %) 로 문자열 검색
		>> LIKE '_a%'
        
	7) 집합 연산자: 결과 집합 병합 / 비교
		>> UNION, INTERSECT, EXCEPT(차집합)
        (MySQL 은 UNION 만 지원)
*/

-- 2024 년 회원 중에 이름에 'ji' 이 들어간 회원을 조회 (name, area_code 조회)
-- +) name, area_code 컬럼은 각각 '회원 이름', '지역코드'로 컬럼명 조회
SELECT 
	name AS '회원 이름', area_code AS '지역 코드'
FROM 
	`korea_db`.`members`
WHERE
	name LIKE '%ji%' AND
    YEAR(join_date) = '2024';
    













