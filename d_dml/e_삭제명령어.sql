# DELETE VS DROP VS TRUNCATE 

/*
	1) 공통점: 삭제를 담당
    
    2) 차이점
    - DELETE (DML)
    : 테이블의 틀은 남기면서 데이터를 삭제 - 주로 적은 용량의 데이터나 조건이 필요한 데이터에 사용 (WHERE 조건절과 함께)
    
    - DROP (DDL)
    : 테이블 자체를 삭제 (틀 + 데이터)
    
    - TRUNCATE(DDL)
    : 테이블의 틀은 남기면서 데이터를 삭제 - 대용량의 데이터처리
*/

-- 대용량 테이블 생성
CREATE TABLE `big1`(SELECT * FROM `world`.`city`, `sakila`.`actor`);
CREATE TABLE `big2`(SELECT * FROM `world`.`city`, `sakila`.`actor`);
CREATE TABLE `big3`(SELECT * FROM `world`.`city`, `sakila`.`actor`);

SET SQL_SAFE_UPDATES=0;

-- 삭제 명령어 비교
DELETE FROM `big1`; -- 5.062 sec (** TRUNCATE 보다 느림)
SELECT * FROM `big1`;

DROP TABLE `big2`; -- 0.016 sec
SELECT * FROM `big2`; -- Error Code: 1146. Table 'company.big2' doesn't exist	0.000 sec

TRUNCATE TABLE `big3`; -- 0.031 sec -- 테이블 형식은 남지만, 조건 없이 삭제됨
SELECT * FROM `big3`;

SET SQL_SAFE_UPDATES=1;




