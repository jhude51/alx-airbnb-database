-- ======================================================
-- Airbnb Clone - Sample Data (seed.sql)
-- Author: Dayo Adeyemi
-- Version: v1.0
-- ======================================================

-- Enable UUID generation (if not already enabled)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ======================================================
-- 1. USERS
-- ======================================================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    (gen_random_uuid(), 'Dayo', 'Adeyemi', 'dayo.adeyemi@example.com', 'hashed_pw1', '08012345678', 'host', CURRENT_TIMESTAMP),
    (gen_random_uuid(), 'Aisha', 'Bello', 'aisha.bello@example.com', 'hashed_pw2', '08023456789', 'guest', CURRENT_TIMESTAMP),
    (gen_random_uuid(), 'Chinedu', 'Okafor', 'chinedu.okafor@example.com', 'hashed_pw3', '08034567890', 'guest', CURRENT_TIMESTAMP),
    (gen_random_uuid(), 'Ngozi', 'Umeh', 'ngozi.umeh@example.com', 'hashed_pw4', '08045678901', 'host', CURRENT_TIMESTAMP),
    (gen_random_uuid(), 'Ibrahim', 'Lawal', 'ibrahim.lawal@example.com', 'hashed_pw5', '08056789012', 'admin', CURRENT_TIMESTAMP);

-- ======================================================
-- 2. PROPERTIES
-- ======================================================
WITH host_ids AS (
    SELECT user_id, first_name FROM users WHERE role = 'host'
)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
SELECT
    gen_random_uuid(),
    user_id,
    CASE first_name
        WHEN 'Dayo' THEN 'Lekki Seaside Apartment'
        WHEN 'Ngozi' THEN 'Abuja City View Loft'
        ELSE 'Modern Studio in Surulere'
    END AS name,
    CASE first_name
        WHEN 'Dayo' THEN 'A cozy apartment in Lekki with ocean view and high-speed Wi-Fi.'
        WHEN 'Ngozi' THEN 'A stylish loft in Abuja near Jabi Lake Mall and major attractions.'
        ELSE 'A comfortable studio with modern facilities and 24/7 security.'
    END AS description,
    CASE first_name
        WHEN 'Dayo' THEN 'Lekki, Lagos'
        WHEN 'Ngozi' THEN 'Jabi, Abuja'
        ELSE 'Surulere, Lagos'
    END AS location,
    CASE first_name
        WHEN 'Dayo' THEN 45000
        WHEN 'Ngozi' THEN 60000
        ELSE 35000
    END AS pricepernight,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM host_ids;

-- ======================================================
-- 3. BOOKINGS
-- ======================================================
WITH guest_ids AS (
    SELECT user_id, first_name FROM users WHERE role = 'guest'
),
property_ids AS (
    SELECT property_id, name FROM properties
)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
SELECT
    gen_random_uuid(),
    p.property_id,
    g.user_id,
    CURRENT_DATE + (i * 5) AS start_date,
    CURRENT_DATE + (i * 5) + INTERVAL '3 days' AS end_date,
    (p.pricepernight * 3)::DECIMAL(10,2) AS total_price,
    CASE i
        WHEN 0 THEN 'confirmed'
        WHEN 1 THEN 'pending'
        ELSE 'confirmed'
    END AS status,
    CURRENT_TIMESTAMP
FROM property_ids p
CROSS JOIN guest_ids g
CROSS JOIN LATERAL (SELECT generate_series(0, 1) AS i) t
LIMIT 4;

-- ======================================================
-- 4. PAYMENTS
-- ======================================================
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
SELECT
    gen_random_uuid(),
    booking_id,
    total_price,
    CURRENT_TIMESTAMP,
    CASE (RANDOM() * 3)::INT
        WHEN 0 THEN 'credit_card'
        WHEN 1 THEN 'paypal'
        ELSE 'stripe'
    END AS payment_method
FROM bookings
WHERE status = 'confirmed';

-- ======================================================
-- 5. REVIEWS
-- ======================================================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
SELECT
    gen_random_uuid(),
    b.property_id,
    b.user_id,
    (RANDOM() * 4 + 1)::INT AS rating,
    CASE (RANDOM() * 3)::INT
        WHEN 0 THEN 'Wonderful stay! The host was very welcoming and the apartment was neat.'
        WHEN 1 THEN 'Smooth check-in process and a great location. Highly recommended.'
        ELSE 'Everything worked perfectly. I’ll definitely come back!'
    END AS comment,
    CURRENT_TIMESTAMP
FROM bookings b
WHERE b.status = 'confirmed';

-- ======================================================
-- 6. MESSAGES
-- ======================================================
WITH users_cte AS (
    SELECT user_id, first_name, role FROM users
)
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
SELECT
    gen_random_uuid(),
    g.user_id AS sender_id,
    h.user_id AS recipient_id,
    CASE g.first_name
        WHEN 'Aisha' THEN 'Hello Dayo, is your Lekki Seaside Apartment available this weekend?'
        WHEN 'Chinedu' THEN 'Hi Ngozi, please can I check in earlier on Friday?'
        ELSE 'Good day, I’m interested in booking your property next month.'
    END AS message_body,
    CURRENT_TIMESTAMP
FROM users_cte g
JOIN users_cte h ON g.role = 'guest' AND h.role = 'host'
LIMIT 3;