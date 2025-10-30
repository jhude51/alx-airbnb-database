# 🧩 Airbnb Clone Backend – Advanced Querying Power
## 🎯 Writing Complex Queries with Joins
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

## 🧠Practicing Subqueries

The next stage in SQL mastery focuses on **subqueries** — queries nested inside other queries.  
They allow you to filter, compare, or aggregate data dynamically, making your backend data logic more powerful and flexible.

### 📂 File: `subqueries.sql`
This script demonstrates both **non-correlated** and **correlated subqueries** in the context of the Airbnb Clone database.

---

### 1️⃣ Non-Correlated Subquery – Properties with Average Rating > 4.0
Retrieves all properties whose average review rating exceeds 4.0.

**Logic:**  
- The inner query calculates average ratings for each property.  
- The outer query filters only properties with an average above 4.0.

**Example Tables:**  
`properties`, `reviews`

**Key Concept:**  
The inner query runs **independently** of the outer query.

---

### 2️⃣ Correlated Subquery – Users with More Than 3 Bookings
Finds users who have made **more than three bookings**.

**Logic:**  
- The subquery counts the number of bookings for each user.  
- It references the outer query’s current `user_id`.  
- Only users meeting the condition are returned.

**Example Tables:**  
`users`, `bookings`

**Key Concept:**  
The inner query is **correlated** with the outer query and executes **once per user**.

---

### ⚙️ How to Run
Execute in PostgreSQL or your preferred SQL client:

```bash
psql -U postgres -d airbnb_clone -f subqueries.sql
```
### 🧠 Summary of Subquery Types

| Subquery Type | Description | Example Use Case |
|----------------|--------------|------------------|
| **Non-Correlated** | Executes once and passes a static result to the main query. | Find properties with avg rating > 4.0 |
| **Correlated** | Executes once for each row of the outer query. | Find users with more than 3 bookings |

---

### 💡 Why Subqueries Matter
Subqueries allow for:
- Filtering results based on **aggregated or dynamic conditions**  
- Avoiding multiple JOINs for performance efficiency  
- Simplifying complex logic into **nested, readable layers**  

They are especially useful for **analytics, reporting, and conditional filtering** in backend applications.

---