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

INSERT INTO students (student_id, first_name, last_name, age, major)
VALUES (1, 'John', 'Doe', 20, 'Computer Science'),
       (2, 'Jane', 'Smith', 22, 'Mathematics'),
       (3, 'Alice', 'Johnson', 19, 'Biology'),
       (4, 'Bob', 'Brown', 21, 'History');
       
INSERT INTO courses (course_id, course_name, instructor, credit_hours)
VALUES (101, 'Introduction to Programming', 'Prof. Smith', 3),
       (102, 'Calculus I', 'Prof. Johnson', 4),
       (103, 'Biology 101', 'Prof. Davis', 3),
       (104, 'World History', 'Prof. Wilson', 3);
       
INSERT INTO student_courses (student_id, course_id)
VALUES (1, 101),
       (2, 102),
       (3, 103),
       (4, 104);
       
SELECT * FROM student_courses;
SELECT * FROM students;
SELECT * FROM courses;


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
