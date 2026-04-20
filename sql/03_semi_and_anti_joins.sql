/*
Q4: Get instructors who have at least one completed course enrollment
*/
SELECT instructor_id, name
FROM instructors
WHERE instructor_id IN (
  SELECT instructor_id
  FROM courses
  WHERE course_id IN (
    SELECT DISTINCT(course_id)
    FROM enrollments
    WHERE completion_status = 'Completed'
  )
)
ORDER BY instructor_id;

/*
Q5: Find courses that no student has completed
*/
SELECT course_id, title
FROM courses
WHERE course_id NOT IN (
  SELECT DISTINCT(course_id)
  FROM enrollments
  WHERE completion_status IN ('Completed')
)
ORDER BY course_id;