/*
	BCNF
    : 3.5 정규화(제 3정규형을 강화한 정규형)
    - 모든 결정자가 후보키가 되어야함
    - 3NF 조건을 만족하면서 모든 결정자가 후보키가 되어야함
    > 테이블에 존재하는 모든 함수 종속 관계의 결정자가 반드시 후보키!
    
    ==== Key 개념 정리 ===
    1) 후보키(Candidate)
    : 테이블의 각 행을 유일하게 식별할 수 있는 최소 속성 집합
    - 유일성(중복X), 최소성(최소한의 속성들로만 키 구성)
    - 하나의 테이블에서 여러개의 후보키가 존재할 수 있음
    ex) 학생 테이블 - 학번, 이름, 나이, 성별, 주민번호, 이메일 있다 칠때 
		> 학번, 주민번호, 이메일 (후보키)
        
	2) 기본키(PK)
    : 후보키 중 대표로 선택된 키
    - 반드시 NULL 이 아니고, 중복되지 않아야함
    - 하나의 테이블에 반드시 한 개만 존재
    > ex) 학번
    
    3) 대체키(Alternate)
    : 후보키 중 기본키로 선택되지 않은 키
    > ex) 주민번호, 이메일
    
    4) 결정자(Determinant)
    : 어떤 속성 집합이 다른 속성을 결정(함수종속)할 수 있다면 , 해당 속성 집합은 '결정자' 라고 불림
    >> 학번, 주민번호가 (이름과 학과)를 지정할 수 있음 - 결정자: 학번, 주민번호 => 대부분의 후보키가 결정자가 "될 수" 있음.
    
    ** 3NF 는 비주요 속성이 후보키가 아니어도 허용
    ** BCNF 는 모든 결정자가 반드시 후보키여야함

*/

--  ex) 3NF 만족을 하는데 BCNF 는 만족하지 않는 정규화
use normal;
create table wrong_bcnf (
	student_id int,
    student_name varchar(50),
    course_id int,
    score int,
    course_name varchar(50),
    primary key (student_id, course_id) -- 복합키
);
select * from wrong_bcnf;
-- 함수 종속 관계
-- student_id + course_id 로 score, course_name 이 결정됨
-- course_id(결정자) 가 course_name 결정할 수 있으므로 course_id 가 결정자이긴 하지만 후보키가 아님
-- >> BCNF 위반

-- 해결방법
create table 과목 (
	과목코드 int primary key, -- 결정자를 후보키로 정의
    과목명 varchar(50)
);

create table 성적 (
	학번 int,
    과목코드 int,
    점수 int,
    
    primary key(학번, 과목코드),
	foreign key(과목코드) references 과목(과목코드)
);

-- 1NF(원자값)
-- 2NF(완전함수종속) - 기본키 일부에만 종속된 속성 제거
-- 3NF(이행종속제거) - A -> B -> C 형태 제거
-- BCNF(모든 결정자가 반드시 후보키)



