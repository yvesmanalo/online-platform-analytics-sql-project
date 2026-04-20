-- =========================
-- RESET TABLES (optional if reseeding)
-- =========================
TRUNCATE TABLE students, instructors, courses, enrollments, subscriptions RESTART IDENTITY CASCADE;

-- =========================
-- STUDENTS (100 rows)
-- =========================
INSERT INTO students (name, country, signup_date)
SELECT 
    (ARRAY[
        'Juan','Maria','Jose','Ana','Carlos','Miguel','Luis','Elena','Sofia','Andres',
        'Daniel','Paolo','Mark','John','Kevin','Angela','Rica','Joy','Nathan','Leo',
        'James','Michael','David','Chris','Brian','Jason','Matthew','Anthony','Ryan','Joshua'
    ])[floor(random()*30)+1]
    || ' ' ||
    (ARRAY[
        'Santos','Reyes','Cruz','Bautista','Garcia','Mendoza','Torres','Flores','Ramos','Aquino',
        'Tan','Lim','Chua','Go','Lee','Kim','Smith','Johnson','Brown','Taylor',
        'Anderson','Thomas','Jackson','White','Harris','Martin','Thompson','Moore','Clark','Lewis'
    ])[floor(random()*30)+1] AS name,

    (ARRAY['Philippines','USA','India','Canada','UK'])[floor(random()*5)+1],

    CURRENT_DATE - (random()*365)::int

FROM generate_series(1,100);

-- =========================
-- INSTRUCTORS (20 rows - UNIQUE)
-- =========================
INSERT INTO instructors (name, experience_years)
SELECT name, (random()*15)::int
FROM (
    SELECT * FROM unnest(ARRAY[
        'David Anderson',
        'Sarah Thompson',
        'Michael Chen',
        'Jessica Lee',
        'Robert Garcia',
        'Emily Johnson',
        'James Wilson',
        'Anna Martinez',
        'Chris Brown',
        'Sophia Taylor',
        'Daniel Kim',
        'Olivia White',
        'Matthew Harris',
        'Chloe Clark',
        'Andrew Lewis',
        'Isabella Young',
        'Joshua Walker',
        'Mia Hall',
        'Ethan Allen',
        'Grace King'
    ]) AS name
) t;

-- =========================
-- COURSES (30 rows - REALISTIC TITLES)
-- =========================
INSERT INTO courses (title, category, instructor_id)
SELECT title, category, (random()*19 + 1)::int
FROM (
    SELECT * FROM unnest(
        ARRAY[
            'SQL for Data Analysis',
            'Python for Data Science',
            'Machine Learning Fundamentals',
            'Deep Learning with TensorFlow',
            'Data Engineering Basics',
            'Statistics for Data Science',
            'Data Visualization with Tableau',
            'Big Data with Spark',
            'ETL Pipeline Development',
            'Data Warehousing Concepts'
        ],
        ARRAY['Data Science','Data Science','Data Science','Data Science','Data Science',
              'Data Science','Data Science','Data Science','Data Science','Data Science']
    )

    UNION ALL

    SELECT * FROM unnest(
        ARRAY[
            'Python Programming for Beginners',
            'Advanced Python Programming',
            'JavaScript Fundamentals',
            'Backend Development with Node.js',
            'API Development and Integration',
            'Object-Oriented Programming',
            'Version Control with Git',
            'Docker for Developers'
        ],
        ARRAY['Programming','Programming','Programming','Programming','Programming',
              'Programming','Programming','Programming']
    )

    UNION ALL

    SELECT * FROM unnest(
        ARRAY[
            'Business Analytics Fundamentals',
            'Project Management for IT',
            'Agile and Scrum Essentials',
            'Digital Marketing Basics',
            'Entrepreneurship 101'
        ],
        ARRAY['Business','Business','Business','Business','Business']
    )

    UNION ALL

    SELECT * FROM unnest(
        ARRAY[
            'UI/UX Design Principles',
            'Graphic Design Basics',
            'Adobe Photoshop Essentials',
            'Figma for Beginners',
            'Design Thinking Fundamentals',
            'Mobile App UI Design',
            'Web Design with HTML and CSS'
        ],
        ARRAY['Design','Design','Design','Design','Design','Design','Design']
    )
) AS course_data(title, category);

-- =========================
-- ENROLLMENTS (250 rows)
-- =========================
INSERT INTO enrollments (student_id, course_id, enrollment_date, completion_status)
SELECT 
    (random()*99 + 1)::int,
    (random()*29 + 1)::int,
    CURRENT_DATE - (random()*200)::int,
    (ARRAY['Completed','In Progress','Dropped'])[floor(random()*3)+1]
FROM generate_series(1,250);

-- =========================
-- SUBSCRIPTIONS (120 rows)
-- =========================
INSERT INTO subscriptions (student_id, plan_type, start_date, end_date)
SELECT 
    (random()*99 + 1)::int,
    (ARRAY['Basic','Premium'])[floor(random()*2)+1],
    CURRENT_DATE - (random()*300)::int,
    CURRENT_DATE + (random()*300)::int
FROM generate_series(1,120);