-- ============================================================
-- ⚡ Airbnb Clone Backend – Table Partitioning
-- File: partitioning.sql
-- Objective: Optimize performance for large datasets by partitioning
-- the "bookings" table based on start_date.
-- ============================================================

-- ============================================================
-- 1️⃣ DROP EXISTING TABLE (for demonstration)
-- WARNING: Only run this in a test or development environment.
-- ============================================================
DROP TABLE IF EXISTS bookings CASCADE;

-- ============================================================
-- 2️⃣ CREATE PARTITIONED TABLE
-- Description:
-- - The bookings table is partitioned by RANGE on start_date.
-- - This improves query performance when filtering by date.
-- ============================================================

CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- ============================================================
-- 3️⃣ CREATE PARTITIONS
-- Description:
-- Create partitions for different time ranges.
-- Adjust years as needed for your dataset.
-- ============================================================

-- Partition for past bookings (2023)
CREATE TABLE bookings_2023 PARTITION OF bookings
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Partition for current bookings (2024)
CREATE TABLE bookings_2024 PARTITION OF bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for future bookings (2025)
CREATE TABLE bookings_2025 PARTITION OF bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Default partition (for out-of-range dates)
CREATE TABLE bookings_default PARTITION OF bookings
DEFAULT;

-- ============================================================
-- 4️⃣ INDEXING EACH PARTITION
-- Add indexes to frequently queried columns in each partition.
-- ============================================================

CREATE INDEX idx_bookings_2023_user_id ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);

CREATE INDEX idx_bookings_2023_property_id ON bookings_2023(property_id);
CREATE INDEX idx_bookings_2024_property_id ON bookings_2024(property_id);
CREATE INDEX idx_bookings_2025_property_id ON bookings_2025(property_id);

-- ============================================================
-- 5️⃣ TESTING QUERY PERFORMANCE
-- Compare query execution times before and after partitioning.
-- ============================================================

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30'
  AND status = 'confirmed';

-- ✅ Expected result:
-- - Query planner uses only the relevant partition(s).
-- - “Partition Pruning” occurs → fewer rows scanned.
-- - Faster execution time compared to scanning full table.

-- ============================================================
-- 🧠 BENEFITS:
-- - Reduces I/O by querying only relevant partitions.
-- - Simplifies maintenance (e.g., drop old year partitions).
-- - Enables better parallel query execution.
-- ============================================================
