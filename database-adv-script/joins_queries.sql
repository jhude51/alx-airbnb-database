-- ============================================================
-- 🧩 Task 0: Write Complex Queries with Joins
-- Objective: Master SQL Joins by writing complex queries 
-- using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.
-- ============================================================

-- ============================================================
-- 1️⃣ INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings.
-- This will only show records where both booking and user exist.
-- ============================================================

SELECT 
    b.booking_id,
    b.property_id,
    b.user_id,
    u.first_name,
    u.last_name,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price
FROM 
    bookings AS b
INNER JOIN 
    users AS u 
ON 
    b.user_id = u.user_id
ORDER BY 
    b.created_at DESC;


-- ============================================================
-- 2️⃣ LEFT JOIN
-- Retrieve all properties and their reviews, including properties 
-- that have no reviews yet.
-- The LEFT JOIN ensures every property appears even if there’s no match in reviews.
-- ============================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM 
    properties AS p
LEFT JOIN 
    reviews AS r
ON 
    p.property_id = r.property_id
ORDER BY 
    p.created_at DESC;


-- ============================================================
-- 3️⃣ FULL OUTER JOIN
-- Retrieve all users and all bookings, even if:
--   - The user has no booking, OR
--   - The booking is not linked to any user.
-- ============================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    users AS u
FULL OUTER JOIN 
    bookings AS b
ON 
    u.user_id = b.user_id
ORDER BY 
    u.created_at NULLS LAST, 
    b.created_at NULLS LAST;

-- ============================================================
-- ✅ Notes:
-- - INNER JOIN returns only matching records.
-- - LEFT JOIN keeps all records from the left table (properties), even with no reviews.
-- - FULL OUTER JOIN returns everything from both tables, filling gaps with NULLs.
-- ============================================================