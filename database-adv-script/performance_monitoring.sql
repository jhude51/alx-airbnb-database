-- ============================================================
-- ⚡ Airbnb Clone Backend – Continuous Database Performance Monitoring
-- File: performance_monitoring.sql
-- Objective: Continuously monitor and refine query performance
-- ============================================================


-- ============================================================
-- 1️⃣ ANALYZE FREQUENTLY USED QUERIES
-- Use EXPLAIN ANALYZE to understand query execution plans.
-- ============================================================

-- Example Query 1: Fetch confirmed bookings by user
EXPLAIN ANALYZE
SELECT 
    b.booking_id, b.start_date, b.status, p.name AS property_name
FROM 
    bookings AS b
JOIN 
    properties AS p ON b.property_id = p.property_id
WHERE 
    b.user_id = 'user-uuid-example'
    AND b.status = 'confirmed';

-- Example Query 2: Search properties by price and location
EXPLAIN ANALYZE
SELECT 
    name, location, pricepernight
FROM 
    properties
WHERE 
    location ILIKE '%Lagos%'
    AND pricepernight BETWEEN 40000 AND 80000;

-- Example Query 3: Get all reviews for a property
EXPLAIN ANALYZE
SELECT 
    r.rating, r.comment, u.first_name
FROM 
    reviews AS r
JOIN 
    users AS u ON r.user_id = u.user_id
WHERE 
    r.property_id = 'property-uuid-example';
    

-- ============================================================
-- 2️⃣ IDENTIFY BOTTLENECKS
-- Look for:
-- - "Seq Scan" instead of "Index Scan"
-- - High "Rows Removed by Filter"
-- - High total "Execution Time"
-- ============================================================

-- For large tables, consider VACUUM ANALYZE to refresh statistics
VACUUM ANALYZE;


-- ============================================================
-- 3️⃣ SCHEMA AND INDEX REFINEMENTS
-- Apply schema adjustments or new indexes based on findings.
-- ============================================================

-- Example: Index to optimize booking lookups by user_id and status
CREATE INDEX IF NOT EXISTS idx_bookings_user_status
ON bookings (user_id, status);

-- Example: Index to optimize property search by location and price
CREATE INDEX IF NOT EXISTS idx_properties_location_price
ON properties (location, pricepernight);

-- Example: Index for review lookups by property_id
CREATE INDEX IF NOT EXISTS idx_reviews_property_id
ON reviews (property_id);


-- ============================================================
-- 4️⃣ RE-TEST PERFORMANCE AFTER CHANGES
-- ============================================================

EXPLAIN ANALYZE
SELECT 
    b.booking_id, b.start_date, b.status, p.name AS property_name
FROM 
    bookings AS b
JOIN 
    properties AS p ON b.property_id = p.property_id
WHERE 
    b.user_id = 'user-uuid-example'
    AND b.status = 'confirmed';

-- ✅ Expected Improvements:
-- - "Index Scan" replaces "Seq Scan"
-- - Fewer rows filtered
-- - Execution time reduced
-- ============================================================


-- ============================================================
-- 🧠 NOTES:
-- - Repeat this monitoring periodically or after schema updates.
-- - Use PostgreSQL tools like pg_stat_statements to track query costs.
-- - Monitor slow queries in production with logs or pgBadger.
-- ============================================================
