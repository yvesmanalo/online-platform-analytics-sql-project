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
);

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
);

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
);

/*
Q3: Find students who:
- enrolled in at least one course
- BUT never completed any course
*/

SELECT students.student_id, students.name
FROM students,(SELECT student_id, COUNT(enrollment_date)
FROM enrollments
GROUP BY student_id
HAVING COUNT(enrollment_date) >= 1
EXCEPT
SELECT student_id, COUNT(enrollment_date)
FROM enrollments
WHERE completion_status = 'Completed'
GROUP BY student_id) AS sub
WHERE students.student_id = sub.student_id
ORDER BY students.student_id;
