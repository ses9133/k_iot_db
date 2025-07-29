/*
	SELECT A
    FROM B
    WHERE C
    GROUP BY D
    HAVING E
    ORDER BY F
    LIMIT G
*/

/*
	4. GROUP BY
    : 그룹으로 묶어주는 역할
    - 여러 행을 그룹화하여 집계함수를 적용해 데이터 단일화에 주로 사용
    
    CF) 집계함수: 그룹화 된 데이터에 대한 계산
		- MAX(), MIN(), AVG(), SUM()...
        - COUNT(): 행의 수를 반환
        - COUNT(DISTINCT): 행의 수를 반환 + 중복은 1개만 인정
*/
-- SELECT * FROM `members`
-- GROUP BY grade;
-- 오류 > 등급별로 데이터를 그룹화할 때 결합되지 않는 데이터까지 조회하는 경우 오류발생

SELECT name, grade FROM `members`
GROUP BY
	grade;
-- 오류 > 등급별로 데이터를 그룹화할 때 결합되지 않는 데이터까지 조회하는 경우 오류발생

SELECT grade FROM `members`
GROUP BY
	grade;

-- cf) 집계함수는 그룹화된 영역내에서 각각 계산해줌
-- 1) 등급별 회원수 계산
SELECT grade, count(*) FROM `members`
GROUP BY
	grade;

-- 2) 지역별 평균 포인트 계싼
SELECT area_code, AVG(points) -- 평균값은 실수 반환
FROM `members`
GROUP BY
	area_code;
    
/*
	5. HAVING
    : GROUP BY 와 함께 사용, 그룹화 된 결과에 대한 조건 지정
    - WHERE 조건과 식은 유사하지만, 그룹화된 데이터에 대한 조건 지정해야함
*/

-- 1) 총 인원이 2명 이상인 등급 조회
SELECT grade, count(*) 
FROM 
	`members`
GROUP BY
	grade
HAVING 
	count(*) >= 2;
    
-- 2) 지역 평균 포인트가 200 이 넘는 지역 조회
SELECT area_code, AVG(points) 
FROM 
	`members`
GROUP BY
	area_code
HAVING
	AVG(points) > 200;
    
/*
	6. ORDER BY
    : 데이터 정렬
    - 결과의 값이나 개수에 영향 X
    - 기본값 ASC, 내림차순 DESC
*/

SELECT * FROM `members`; -- 데이터 삽입 순서대로 정렬 (AUTO_INCREMENT PK값에 따라 정렬됨)

SELECT * FROM `members`
ORDER BY
	join_date; -- 과거 순 정렬
    
SELECT * FROM `members`
ORDER BY
	name DESC;
    
-- 정렬된 데이터를 기반으로 추가 정렬(콤마로 정렬 상태 나열)
SELECT * FROM `members`
ORDER BY
	grade DESC, points DESC; -- grade (enum) 은 데이터 입력순서대로 순서 부여됨
    
/*
	7. LIMIT
    : 출력하는 개수를 제한(반환되는 행의 수를 제한)
    
    LIMIT 행수 (offset 시작행)
    - 첫 번째 행이  0
*/
SELECT * FROM `members`
LIMIT 5;

SELECT * FROM `members`
LIMIT 5 OFFSET 2; -- 세번째 행부터 출력

SELECT * FROM `members`
ORDER BY
	grade DESC
LIMIT 5;

/*
	cf) DISTINCT
    : 중복된 결과를 제거
    - 조회된 결과에서 중복된 데이터가 존재하면 1개만 남기고 생략
    
    조회할 열 이름 앞에 DISTINCT 키워드만 붙이면 됨
*/
SELECT DISTINCT area_code FROM `members`;
SELECT DISTINCT grade FROM `members`;
