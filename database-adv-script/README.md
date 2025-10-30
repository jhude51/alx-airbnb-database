# 🧩 Airbnb Clone Backend – SQL Joins Practice

## 🎯 Objective
This script (`joins_queries.sql`) demonstrates the use of different **SQL JOIN types** in the context of the Airbnb Clone backend database.  
It focuses on **retrieving relational data** between users, bookings, properties, and reviews — while following best practices for clarity and performance.

---

## 🗂️ File Overview
**File name:** `joins_queries.sql`  
**Purpose:** To master SQL joins through real-world queries on the Airbnb Clone schema.  
**Tables involved:** `users`, `bookings`, `properties`, `reviews`

---

## 🧠 Queries Included

### 1️⃣ INNER JOIN – Bookings with Users
Retrieves all **bookings** along with the **user** who made each booking.  
Only rows with matching `user_id` values in both tables are returned.

**Tables:** `bookings` + `users`  
**Join condition:** `b.user_id = u.user_id`  
**Result:** Shows confirmed relationships between users and their bookings.

---

### 2️⃣ LEFT JOIN – Properties with Reviews
Retrieves all **properties** and their **reviews**, including properties that have no reviews.  
Ensures that every property is listed even if no matching review exists.

**Tables:** `properties` + `reviews`  
**Join condition:** `p.property_id = r.property_id`  
**Result:** Includes properties with `NULL` values for review fields.

---

### 3️⃣ FULL OUTER JOIN – Users with Bookings
Retrieves all **users** and **bookings**, even if:
- A user has no booking, or  
- A booking is not linked to a user.  

**Tables:** `users` + `bookings`  
**Join condition:** `u.user_id = b.user_id`  
**Result:** Combines all user and booking records, filling unmatched data with `NULL`.

---

## ⚙️ How to Run
Execute the script in PostgreSQL or any SQL client connected to your database:

```bash
psql -U postgres -d airbnb_clone -f joins_queries.sql
```

Alternatively, copy and run each query individually in a query editor such as **pgAdmin**, **DBeaver**, or **DataGrip** to view results interactively.

---

## 🚫 Why Wildcards (SELECT *) Are Not Used

While `SELECT *` is valid SQL, it is **not used** in this script for the following reasons:

| Reason | Explanation |
|--------|--------------|
| **Clarity** | Explicitly listing columns shows exactly what data is being returned. |
| **Avoid Duplicates** | Prevents repeated columns (e.g., `user_id` appearing twice from both tables). |
| **Performance** | Fetches only required data, reducing memory and network usage. |
| **Stability** | Protects against schema changes — adding a new column won’t unexpectedly alter query results. |
| **Best Practice** | Used in production-grade systems for clean, predictable API and reporting output. |

Using specific columns ensures your SQL is **readable, maintainable, and scalable**, especially when multiple joins are combined.

---

## 🧩 Summary of Join Types

| Join Type | Returns | Common Use Case |
|------------|----------|-----------------|
| **INNER JOIN** | Matching records only | View bookings tied to existing users |
| **LEFT JOIN** | All left records + matching right ones | List all properties, even those not reviewed |
| **FULL OUTER JOIN** | All records from both tables | Audit users and bookings for completeness |

---
