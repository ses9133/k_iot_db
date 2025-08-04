/*
	* 제 2 정규화
    - 1NF 를 만족하면서 '모든 비기본속성(일반컬럼)' 이 기본키에 완전히 종속되어야함
		>> 완전 함수적 종속 상태
        
	cf) 함수적 종속
    - 비기본 속성: 기본키를 제외한 나머지 컬럼들
    - 완전 함수적 종속
		: 비기본 속성이 기본키 전체에 종속
		> 기본키의 일부만으로 결정할 수 없는 경우
        ex) 복합키가 있을때는 - 기본키가 (A, B) 일때 C(비기본속성)가 A나 B 하나만으로 결정되지 않고,
			A와 B 모두 알아야 C 가 정해짐
            
	- 부분 함수적 종속 => 2NF 위반
		: 비기본 속성이 기본키의 일부에만 종속
        ex) 기본키가 (A, B) 일때 D(비기본속성)가 A만으로 결정 >>  부분 종속
   
*/
/*
	# 2NF 예시
    1) 1NF 만족
    2) 기본키가 복합키일때, 모든 비기본이 PK 전체에 의존해야함(완전 함수 종속)
*/
create table departments (
	department_id bigint primary key, 
    # PK 를 제외한 나머지 속성들이 PK에 완전 종속 되어있음
    # 만약 직원연봉을 넣게 되면 2NF 를 위반하게 됨
    location varchar(50),
    supervisor_id bigint -- 부서장 ID
);

create table employees (
	employee_id bigint primary key,
    department_id bigint,
    department_id bigint,
    
    foreign key(department_id) references departments(department_id)
);

insert into departments
values 
	(1, 'seoul', 101),
	(2, 'seoul', 102),
	(3, 'busan', 103),
	(4, 'ulsan', 104);
    
insert into employees
values 
	(1, 1),
    (2, 3),
    (3, 4);

-- 제 2정규형을 위반한 테이블
-- 직원과 부서의 결합 테이블
create table wrong_2nf (
	employee_id int,
    department_id int,
    location varchar(50), -- 부서위치가 2NF 를 위반
    primary key(employee_id, department_id)
);

-- 부분 종속이 발생하면 테이블을 분리하여 해결하는 것이 2NF 를 지키는 방법
-- >> 테이블을 나누어 각각 비기본 속성이 완전 종속 되도록 설계

-- 제2 정규형 모범 사례
-- 1) 1NF 는 모든 테이블의 기본 요건
-- 2) 2NF 는 복합키가 있는 경우에만 고려 >> 단일 기본키는 대부분 2NF가 만족됨



























