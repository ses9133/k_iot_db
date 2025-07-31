
	/*
	요구 사항
	school_db 데이터베이스 생성

	학생(Students) 테이블: 학생 ID, 이름, 전공, 입학년도를 포함
	교수(Professors) 테이블: 교수 ID, 이름, 학과, 사무실 위치를 포함
	강의(Courses) 테이블: 강의 ID, 강의명, 담당 교수 ID, 학점 수를 포함
	수강(Enrollments) 테이블: 수강 ID, 학생 ID, 강의 ID, 수강년도, 학기를 포함

	각 테이블의 ID는 기본 키로 설정
	교수 ID는 강의 테이블에서 외래 키로 설정되어야 하며, 교수와 강의 사이의 관계 작성
	학생 ID와 강의 ID는 수강 테이블에서 외래 키로 설정되어야 하며, 학생, 강의, 수강 사이의 다대다 관계 작성.
    
    cf) 컬럼명 위의 한글 그대로 사용 (띄어쓰기 없이)
*/

create database school_db;
use school_db;

create table Students (
	학생ID int primary key, 
    이름 varchar(30),
    전공 varchar(30),
    입학년도 Year
);

create table Professors (
	교수ID int primary key, 
    이름 varchar(30),
    학과 varchar(30),
    사무실위치 varchar(100)
);

create table Courses (
	강의ID int primary key,
    강의명 varchar(30),
    담당교수ID int,
    학점수 int,
    
    foreign key(담당교수ID) references Professors(교수ID)
);

create table Enrollments (
	수강ID int primary key,
    학생ID int,
    강의ID int,
    수강년도 Year,
    학기 int,

    foreign key(학생ID) references Students(학생ID),
    foreign key(강의ID) references Courses(강의ID)
);

-- Students
INSERT INTO Students VALUES (1, 'Alice', 'Computer Science', 2020);
INSERT INTO Students VALUES (2, 'Bob', 'Mathematics', 2021);
INSERT INTO Students VALUES (3, 'Charlie', 'Physics', 2022);

-- Professors
INSERT INTO Professors VALUES (1, 'Dr. Smith', 'Computer Science', 'Room 101');
INSERT INTO Professors VALUES (2, 'Dr. Johnson', 'Mathematics', 'Room 102');
INSERT INTO Professors VALUES (3, 'Dr. Williams', 'Physics', 'Room 103');

-- Courses
INSERT INTO Courses VALUES (1, 'Introduction to Programming', 1, 3);
INSERT INTO Courses VALUES (2, 'Calculus I', 2, 4);
INSERT INTO Courses VALUES (3, 'Mechanics', 3, 4);

-- Enrollments
INSERT INTO Enrollments VALUES (1, 1, 1, 2023, 1);
INSERT INTO Enrollments VALUES (2, 2, 2, 2023, 1);
INSERT INTO Enrollments VALUES (3, 3, 3, 2023, 1);

select 
	이름, 입학년도
from
	`Students`
where
	전공 = 'Computer Science';
 --    
select
	강의명, 학점수
from
	`Courses`
where
	담당교수ID = 2;
 --    
select
	S.학생ID, S.이름
from
	`Students` S
	JOIN `Enrollments` E
    ON S.학생ID = E.학생ID
WHERE
	E.수강년도 = 2023 AND E.학기 = 1;
	
