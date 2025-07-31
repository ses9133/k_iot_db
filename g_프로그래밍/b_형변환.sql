-- 형변환: 데이터타입의 변환

-- 1) 명시적 형 변환
-- cast(값 as 데이터형식)
-- convert(값, 데이터형식) 
-- >> 두 문법은 형식만 다르고 기능은 동일

SELECT * FROM buy;

SELECT 
	AVG(price) '평균 가격'
FROM 
	buy; -- 142.9167
    
-- cf) 형 변환시 정수형 데이터 타입 
-- 		>> signed(부호있는 정수, 즉 양수/음수 모두 가능), unsigned 만 사용 가능  (tinyint, int 등 사용 불가)

SELECT 
	AVG(price) '평균 가격',
    cast(AVG(price) as unsigned) '정수 평균 가격',
    convert(AVG(price), unsigned) '정수 평균 가격'
FROM 
	buy;
    
-- 날짜 형 변환(포맷 지정)
-- DATE 타입: YYYY-MM-DD
-- >> MySQL 은 문자형식을 자동으로 분석하여 YYYY-MM-DD 형식으로 변환
-- cf) 형식이 너무 벗어나는 경우 오류 발생(변환 X)

SELECT cast('2025$07$31' AS DATE);
SELECT cast('2025@07!31' AS DATE);
SELECT cast('2025_07_31' AS DATE);
SELECT cast('07/31/2025' AS DATE); -- 변환 안됨. NULL (형식을 너무 벗어났기 때문)

-- cast: SQL 표준
-- convert: MySQL 고유문법

-- 2) 묵시적 형 변환
-- : 자동으로 데이터를 변환하는 것
SELECT '100' + '200'; -- 100200 이 아니라 자동으로 숫자로 변환하여 300으로 계산해줌

-- cf) 문자열을 이어서 작성하고 싶다면 
-- concat('a', 'b') 함수를 사용
SELECT concat('100', '200'); -- 100200





















	
    
