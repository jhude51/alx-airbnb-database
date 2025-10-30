# ⚡ Database Index Optimization – Airbnb Clone Backend

## 🎯 Objective
Identify and create indexes to improve query performance across frequently used tables such as **Users**, **Properties**, and **Bookings**.

Indexes make data retrieval significantly faster, especially for queries using `WHERE`, `JOIN`, and `ORDER BY` clauses.  
This document outlines how to create and evaluate these indexes effectively.

---

## 🧩 1️⃣ Identify High-Usage Columns

Before adding indexes, identify **columns most frequently used** in queries:

| Table | Column | Usage | Reason |
|--------|---------|--------|--------|
| **users** | `email` | WHERE / Authentication | Speed up login and lookups |
| **users** | `role` | WHERE / Filtering | Filter by user type (guest, host, admin) |
| **properties** | `host_id` | JOIN | Optimize joins with `users` |
| **properties** | `location` | WHERE / Search | Improve property searches by city |
| **properties** | `pricepernight` | ORDER BY | Sorting or filtering by price |
| **bookings** | `user_id` | JOIN | Link bookings to users efficiently |
| **bookings** | `property_id` | JOIN | Link bookings to properties |
| **bookings** | `start_date, end_date` | WHERE | Search for available dates |
| **bookings** | `status` | WHERE | Filter bookings by status |

---

## ⚙️ 2️⃣ Create Indexes

Indexes are created for the high-usage columns listed above to improve the speed of lookups, joins, and filtering operations.  
Refer to the **`database_index.sql`** script for the actual `CREATE INDEX` commands.

💡 **Tip:** Avoid creating excessive indexes — while they speed up reads, they can slow down `INSERT`, `UPDATE`, and `DELETE` operations.

---

## 🧪 3️⃣ Measure Query Performance

Use **PostgreSQL EXPLAIN** or **EXPLAIN ANALYZE** to measure query performance before and after applying indexes.  
Run these commands to visualize the query execution plan and confirm that the database is using **Index Scans** instead of **Sequential Scans**.

You should observe:
- **Lower execution time**
- **Reduced row filtering**
- **Use of Index Scan** in place of Sequential Scan

✅ The query performance improvements can be verified using the examples provided in your SQL script.

---

## 🧠 Best Practices

- Index **foreign keys** and frequently filtered columns.  
- Use **composite indexes** for multi-column queries (e.g., `start_date, end_date`).  
- Drop unused indexes with `DROP INDEX index_name;`.  
- Regularly monitor performance with tools like `pg_stat_statements` or `EXPLAIN`.

---

## 🚀 How to Run

```bash
psql -U postgres -d airbnb_clone -f database_index.sql
