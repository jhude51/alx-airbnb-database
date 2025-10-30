-- ============================================================
-- 🧩 Airbnb Clone Backend – SQL Aggregations & Window Functions
-- File: aggregations_and_window_functions.sql
-- Objective: Practice data analysis using aggregate functions and window functions
-- ============================================================


-- ============================================================
-- 1️⃣ AGGREGATION QUERY
-- Task: Find the total number of bookings made by each user.
-- Description:
--   - Uses COUNT() to count bookings per user.
--   - Uses GROUP BY to group results by user ID.
-- ============================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    users AS u
LEFT JOIN 
    bookings AS b
ON 
    u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- 🧠 EXPLANATION:
-- - COUNT() aggregates the total bookings for each user.
-- - LEFT JOIN ensures users with no bookings still appear with a count of 0.
-- - GROUP BY groups data by user to compute counts.
-- - The result shows how active each user is as a guest.
-- ============================================================


-- ============================================================
-- 2️⃣ WINDOW FUNCTION QUERY
-- Task: Rank properties based on the total number of bookings.
-- Description:
--   - Uses COUNT() with GROUP BY to find total bookings per property.
--   - Uses RANK() or ROW_NUMBER() as a window function to assign ranking.
-- ============================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM 
    properties AS p
LEFT JOIN 
    bookings AS b
ON 
    p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location
ORDER BY 
    total_bookings DESC;

-- 🧠 EXPLANATION:
-- - COUNT() aggregates total bookings for each property.
-- - RANK() OVER() assigns rank based on total_bookings (ties share the same rank).
-- - ROW_NUMBER() could be used instead if you want unique ranking with no ties.
-- - The result ranks all properties by popularity.
-- ============================================================