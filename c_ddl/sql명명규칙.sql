/*
	MySQL 명명 규칙
    : DB, 테이블, 컬럼 명명 규칙

	1. 대소문자 구분 X
	: 일관성 있는 작성 권장
    - 소문자로 작성 후, ctrl + shift + u (대문자 변환)
    
    2. 길이 제한 
    : 최대 64자까지 사용 가능
    
    3. 문자 제한
    : 문자, 숫자, _ 만 사용 가능 (공백, 기타 특수 기호 사용X)
    
    4. 숫자로 시작 X
    
    5. MySQL 예약어는 사용 X
    : 부득이하게 사용하는 경우 ``(백틱)으로 묶어서 사용가능
    
*/
-- ----------------------------------
/*
	* SQL 내 명명시 반드시 의미있는 이름 사용 권장
    > 데이터를 정확하게 설명할 수 있는 식별자로 명명
    
    * 테이블 몀명 규칙
    > 복수형 명사 사용 권장
    Ex) students, lectures, products, memebers 등...
    
    +) 복수형 vs 단수형
    - 테이블명 복수형
		: 한 테이블에 여러 개의 레코드(행)가 저장
		: 의미가 직관적
	- 테이블명 단수형
		: 객체지향적인 관점에서 클래스이름과 일치시킬 수 있음 (자바의 User 클래스 - user 테이블)
        - 테이블 하나가 하나의 엔티티 구조를 표현
	
    * lower_camel_case 사용 권장
    ex) student_id, lecture_code, product_price, memeber_grade...
    
    * SQL 문법(대문자 사용 권장) vs 네이밍 방식(소문자 사용 권장)
    ex) CREATE DATABASE example;

*/

-- --------------------------------
/*
	** 백틱 vs 따옴표
    1) 백틱
		: 키워드 충돌 방지 - 예약어로 설정되어있는 단어를 명명하기 위한 목적
        ex) order, group, select 등의 예약어를 컬럼명이나 명명규칙에 사용
			SELECT `order`, `group` FROM `example`;
			SELECT order, group FROM `example`; --  예약어 이므로 오류남
            
		: 대소문자 구분 필요 - 설정에 따라 민감한 시스템에서 사용
            SELECT student from school;
			SELECT STUDENT FROM SCHOOL;
		
        : 공백이나 특수문자가 포함된 이름 사용시
        SELECT `student name` FROM `busan high school`;
        
        >> 혹시 모를 예약어와의 충돌이나 외부 시스템 연동시 문제 방지를 위해 백틱을 사용하는 것이 안정적임
        
	2) 따옴표
		: 문자열 데이터를 저장하는데 사용 (문자열 리터럴 표현)
        - DB, 테이블, 컬럼명으로는 사용하지 않는 것을 권장
        - 실제 데이터임을 명시!
        
        SELECT 'price' FORM `products`; -- 가격 컬럼이 아니라 실제 price 문자열(글자)로 인식
*/


