-- ============================================================
-- ⚡ Airbnb Clone Backend – Database Index Optimization
-- File: database_index.sql
-- Objective: Improve query performance using indexes on high-usage columns
-- ============================================================

-- ============================================================
-- 1️⃣ USER TABLE INDEXES
-- Frequently filtered or joined columns:
-- - email (used for login)
-- - role (used for filtering by user type)
-- ============================================================

-- Index for quick lookups by email (e.g., during authentication)
CREATE INDEX idx_users_email ON users(email);

-- Index for filtering users by role (guest, host, admin)
CREATE INDEX idx_users_role ON users(role);


-- ============================================================
-- 2️⃣ PROPERTY TABLE INDEXES
-- Frequently used in searches and joins:
-- - host_id (foreign key to users)
-- - location (search by city or region)
-- - pricepernight (range filtering)
-- ============================================================

-- Join optimization (properties ↔ users)
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- Speeds up location-based searches
CREATE INDEX idx_properties_location ON properties(location);

-- Helps with sorting and filtering by price
CREATE INDEX idx_properties_pricepernight ON properties(pricepernight);


-- ============================================================
-- 3️⃣ BOOKING TABLE INDEXES
-- Frequently joined and filtered columns:
-- - property_id (foreign key)
-- - user_id (foreign key)
-- - start_date, end_date (for date range queries)
-- - status (filtering booking state)
-- ============================================================

-- Optimize joins with properties
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Optimize joins with users
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Optimize range queries on booking dates
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);

-- Optimize filtering on booking status (pending, confirmed, canceled)
CREATE INDEX idx_bookings_status ON bookings(status);


-- ============================================================
-- 🧪 PERFORMANCE TESTING
-- Measure query performance before and after indexing.
-- ============================================================

-- Example: Without Index
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'aisha.bello@example.com';

-- Example: After Creating Index
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'aisha.bello@example.com';