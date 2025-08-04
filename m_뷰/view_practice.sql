-- 뷰 연습 문제
CREATE DATABASE IF NOT EXISTS school;
USE school;

CREATE TABLE students 
	(student_id INT PRIMARY KEY, 
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    major VARCHAR(50)
    );
    
CREATE TABLE courses (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(100),
    instructor VARCHAR(100),
    credit_hours INT
);

CREATE TABLE student_courses (
	student_id INT,
    course_id INT,
    
    PRIMARY KEY(student_id, course_id),
    
    FOREIGN KEY(student_id) REFERENCES students(student_id),
	FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

SELECT * FROM student_courses;
DESC student_courses;

CREATE VIEW student_course_view 
AS
	SELECT 
		concat(first_name, last_name)  AS '학생의 이름',
		course_name AS '수강 과목 이름',
		instructor AS '담당 강사 이름'
		FROM 
			student_courses SC
			JOIN students S
				ON S.student_id = SC.student_id
            JOIN courses C
				ON SC.course_id = C.course_id;

SELECT * FROM student_course_view;
