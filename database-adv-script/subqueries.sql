-- ============================================================
-- 🧩 Airbnb Clone Backend – SQL Subqueries Practice
-- File: subqueries.sql
-- Objective: Learn and practice correlated and non-correlated subqueries
-- ============================================================

-- ============================================================
-- 1️⃣ NON-CORRELATED SUBQUERY
-- Task: Find all properties where the average rating is greater than 4.0.
-- Description:
--   - The subquery calculates the average rating for each property.
--   - The outer query retrieves property details where the average > 4.0.
-- ============================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM 
    properties AS p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            reviews AS r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.name;

-- ============================================================
-- - The inner query runs independently of the outer query (non-correlated).
-- - It first groups reviews by property_id and filters those with average > 4.
-- - The outer query then retrieves property details matching those property IDs.
-- ============================================================


-- ============================================================
-- 2️⃣ CORRELATED SUBQUERY
-- Task: Find users who have made more than 3 bookings.
-- Description:
--   - The subquery is evaluated once per user in the outer query.
--   - It counts the number of bookings each user has made.
-- ============================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    users AS u
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            bookings AS b
        WHERE 
            b.user_id = u.user_id
    ) > 3
ORDER BY 
    u.first_name, u.last_name;

-- ============================================================
-- - The inner query depends on the outer query (correlated).
-- - For each user, it counts how many bookings exist in the `bookings` table.
-- - Only users with more than 3 bookings are returned.
-- ============================================================


-- ============================================================
-- ✅ NOTES:
-- - A NON-CORRELATED subquery executes once and passes results to the main query.
-- - A CORRELATED subquery executes once per row of the outer query.
-- - Both types are useful for filtering data based on dynamic relationships.
-- ============================================================