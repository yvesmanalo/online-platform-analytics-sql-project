-- DROP TABLES (for reset)
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS students;

-- STUDENTS
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50),
    signup_date DATE
);

INSERT INTO students (name, country, signup_date)
SELECT 
    'Student_' || g,
    (ARRAY['Philippines','USA','India','Canada','UK'])[floor(random()*5)+1],
    CURRENT_DATE - (random()*365)::int
FROM generate_series(1,100) g;

-- INSTRUCTORS
CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    experience_years INT
);

INSERT INTO instructors (name, experience_years)
SELECT 
    'Instructor_' || g,
    (random()*15)::int
FROM generate_series(1,20) g;

-- COURSES
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(50),
    instructor_id INT REFERENCES instructors(instructor_id)
);

INSERT INTO courses (title, category, instructor_id)
SELECT 
    'Course_' || g,
    (ARRAY['Data Science','Programming','Business','Design'])[floor(random()*4)+1],
    (random()*19 + 1)::int
FROM generate_series(1,30) g;

-- ENROLLMENTS
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE,
    completion_status VARCHAR(20)
);

INSERT INTO enrollments (student_id, course_id, enrollment_date, completion_status)
SELECT 
    (random()*99 + 1)::int,
    (random()*29 + 1)::int,
    CURRENT_DATE - (random()*200)::int,
    (ARRAY['Completed','In Progress','Dropped'])[floor(random()*3)+1]
FROM generate_series(1,250);

-- SUBSCRIPTIONS
CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    plan_type VARCHAR(20),
    start_date DATE,
    end_date DATE
);

INSERT INTO subscriptions (student_id, plan_type, start_date, end_date)
SELECT 
    (random()*99 + 1)::int,
    (ARRAY['Basic','Premium'])[floor(random()*2)+1],
    CURRENT_DATE - (random()*300)::int,
    CURRENT_DATE + (random()*300)::int
FROM generate_series(1,120);