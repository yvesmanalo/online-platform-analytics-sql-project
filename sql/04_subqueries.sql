/*
Q6: Show each student with:
 - total number of courses enrolled
*/
SELECT DISTINCT(student_id), name,
  (SELECT COUNT(*)
  FROM enrollments
  WHERE students.student_id = enrollments.student_id) AS total_courses
FROM students
ORDER BY student_id;

/*
Q7: Find students who enrolled in more courses than the average enrollment count
*/
SELECT student_id, name
FROM students
WHERE
  (SELECT COUNT(*)
  FROM enrollments
  WHERE students.student_id = enrollments.student_id)
  >
  (SELECT AVG(sub.total_courses)
  FROM (
    SELECT student_id, COUNT(*) AS total_courses
    FROM enrollments
    GROUP BY student_id
  ) AS sub);
  
/*
Q8: Question:
Find the top 3 most enrolled courses
*/
SELECT courses.course_id, courses.title, sub.total_enrollments
FROM courses, (
  SELECT course_id, COUNT(*) AS total_enrollments
  FROM enrollments
  GROUP BY course_id
  ) as sub
WHERE courses.course_id = sub.course_id
ORDER BY sub.total_enrollments DESC
LIMIT 3;