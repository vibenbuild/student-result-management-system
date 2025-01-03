-- Show Databses
show databases;

-- Create Database
CREATE DATABASE student_result_system;

-- Use Database
USE student_result_system;

-- Tables Creation
# students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    enrollment_number VARCHAR(20) UNIQUE NOT NULL,
    enrollment_date DATE NOT NULL
);

# courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_title VARCHAR(255) NOT NULL,
    credit_hours INT NOT NULL
);

# results Table
resultsCREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade CHAR(2) NOT NULL,
    marks INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

--  Inserting Sample Data
# Insert Data into students Table
INSERT INTO students (name, email, enrollment_number, enrollment_date) 
VALUES
('Alice Smith', 'alice@example.com', 'ENR001', '2023-01-15'),
('Bob Johnson', 'bob@example.com', 'ENR002', '2023-01-20'),
('Charlie Davis', 'charlie@example.com', 'ENR003', '2023-02-10');

# Insert Data into courses Table
INSERT INTO courses (course_code, course_title, credit_hours) 
VALUES
('CS101', 'Introduction to Programming', 3),
('CS102', 'Database Systems', 4),
('CS103', 'Data Structures', 3);

# Insert Data into results Table
INSERT INTO results (student_id, course_id, grade, marks) VALUES
(1, 1, 'A', 90),
(1, 2, 'B', 78),
(1, 3, 'A', 85),
(2, 1, 'B', 75),
(2, 2, 'A', 88),
(2, 3, 'C', 65),
(3, 1, 'A', 92),
(3, 2, 'B', 80),
(3, 3, 'A', 87);

-- Queries
# View All Students
SELECT * FROM students;

# View All Courses
SELECT * FROM courses;

# View All Results
SELECT * FROM results;

-- Get data for all student
select s.student_id, s.enrollment_number, s.name, c.course_code, c.course_title, r.marks, r.grade
from courses c
inner join results r
on  c.course_id = r.course_id
inner join students s on 
s.student_id = r.student_id
order by student_id;

-- Get grades for all student
select s.student_id, s.enrollment_number, s.name, c.course_code, c.course_title, r.marks, r.grade
from courses c
inner join results r
on  c.course_id = r.course_id
inner join students s on 
s.student_id = r.student_id
order by student_id;

-- Get Grades for a specific student
select s.student_id, s.enrollment_number, s.name, c.course_code, c.course_title, r.marks, r.grade
from courses c
inner join results r
on  c.course_id = r.course_id
inner join students s on 
s.student_id = r.student_id
where s.student_id = 1;

-- Calculate Average Marks of a Student
SELECT s.student_id, s.enrollment_number, s.name, AVG(r.marks) AS average_marks
FROM results r
JOIN students s ON r.student_id = s.student_id
WHERE s.student_id = 1; -- Replace with desired student_id

-- Identify Top-Performing Students
SELECT s.student_id, s.enrollment_number, s.name, AVG(r.marks) AS average_marks
FROM results r
JOIN students s ON r.student_id = s.student_id
group by s.student_id
order by average_marks desc;

-- List Students Who Scored Below 50 in Any Course
select s.student_id, s.enrollment_number, s.name, c.course_code, c.course_title, r.marks, r.grade
from courses c
inner join results r
on  c.course_id = r.course_id
inner join students s on 
s.student_id = r.student_id
where r.marks < 80
order by r.marks desc;

-- Courses Taken by students
select s.student_id, s.enrollment_number, s.name, c.course_code, c.course_title
from courses c
inner join results r
on  c.course_id = r.course_id
inner join students s on 
s.student_id = r.student_id
order by student_id;

-- Courses Taken by a Student
select s.student_id, s.enrollment_number, s.name, c.course_code, c.course_title
from courses c
inner join results r
on  c.course_id = r.course_id
inner join students s on 
s.student_id = r.student_id
where s.student_id = 1;
