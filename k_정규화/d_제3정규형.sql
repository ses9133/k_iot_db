/*
	제 3정규화(3NF)
    : 정규화의 세번쨰 단계
    - 2NF 를 만족하는 테이블에서, 모든 비기본 속성이 기본키에만! 함수적으로 종속
			> 이행적 종속을 제거해야함
            
	cf) 이행적 종속성
    : 어떤 속성 A가 다른 속성 B에 종속되고, B가 또 다른 속성 C에 종속된 경우 
    > A 가 C에 이행적으로 종속되었다.
    
    - 제 3정규형의 핵심조건
    : 이행적 종속성을 제거하는 것!!!
*/

/*
	학번(1) / 이름(정은혜) / 학과ID(101) / 학과명(코리아) / 학과위치(부산)
    
    PK: 학번
    비기본속성: 이름, 학과ID, 학과명, 학과 위치
    
    함수 종속 관계
    - 학번 > 학과 ID (학생은 특정 학과에 소속됨)
    - 학과 ID > 학과명, 학과 위치(학과ID 로 학과 정보 확인)
    
    이행적 종속
    - 학번 > 학과 ID > 학과명, 학과 위치 (학번에 따라 학과명, 학과위치가 결정되고 있음 => 학과ID 가 바껴도? 학과명,학과위치는 학번이 바뀌지 않으면 그대로임)
*/

-- 제3정규형 예시
drop database normal;
create database normal;
use normal;

create table department (
	department_id int primary key,
    department_name varchar(100),
    location varchar(100)
);

create table student (
	student_id int primary key,
    name varchar(50),
    department_id int, -- 학과ID만 저장(학과정보는 X)
    
    foreign key(department_id) references department(department_id)
);

insert into department 
values 
	(101, '컴공', '서울'),
	(102, '통계', '부산');
    
insert into student
values 
	(1, '최강섭', 101),
	(2, '손태경', 101),
	(3, '박현우', 102);

-- 학생 번호 > 강의ID, 강의 ID > 강의위치 로 이행정 종속성 분리함    
-- 학생 정보와 강의 위치를 한번에 파악 >> join

select
	student_id, name, department_name, location
from
	student S
    join department D
    on S.department_id = D.department_id;

/*
	-- 제 3정규화 장점
    1) 중복 제거로 저장 공간 절약
    2) 데이터 일관성 유지 가능
    3) 이상현상 방지
    4) 테이블 간 명확한 관계 형성
    
    * 제 3정규화 모범사례
    : 서로 다른 종류의 정보를 따로 담아야 안전
    : 무조건인 정규화는 오히려 효율성 저하됨(JOIN 증가)
    : 경우에 따라 반정규화 고려해야함
    >> 기본적인 정규화 원칙에 대한 이해 적용 필수
*/




