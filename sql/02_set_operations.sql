/*
Q1: Get a combined list of students who:
- enrolled in a Data Science course
- OR subscribed to Premium
*/

-- UNION
SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM subscriptions
  WHERE plan_type='Premium'
)
UNION
SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM enrollments
  WHERE course_id IN (
    SELECT course_id
    FROM courses
    WHERE category = 'Data Science'
  )
)
ORDER BY student_id;

-- UNION ALL
SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM subscriptions
  WHERE plan_type='Premium'
)
UNION ALL
SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM enrollments
  WHERE course_id IN (
    SELECT course_id
    FROM courses
    WHERE category = 'Data Science'
  )
)
ORDER BY student_id;

/*
Q2:Find students who:
- enrolled in Programming courses
- AND have Premium subscription
*/

SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM enrollments
  WHERE course_id IN (
    SELECT course_id
    FROM courses
    WHERE category = 'Programming'
  )
)
INTERSECT
SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT student_id
  FROM subscriptions
  WHERE plan_type='Premium'
)
ORDER BY student_id;

/*
Q3: Find students who:
- enrolled in at least one course
- BUT never completed any course
*/
SELECT student_id, name
FROM students
WHERE student_id IN (
  SELECT DISTINCT(student_id)
  FROM enrollments
  EXCEPT
  SELECT DISTINCT(student_id)
  FROM enrollments
  WHERE completion_status = 'Completed'
)
ORDER BY student_id;


