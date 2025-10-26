## 🏗️ 1. Step-by-Step Normalization Process

### **Step 1 – First Normal Form (1NF)**
**Requirement:**  
- Eliminate repeating groups.  
- Ensure each field contains atomic values.  
- Each record must be unique.

**Implementation:**  
- All entities (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) use **atomic attributes** — e.g., `first_name`, `last_name`, `email`.  
- Each table has a **primary key** (`user_id`, `property_id`, etc.) ensuring uniqueness.  
- No multi-valued or repeating attributes (e.g., no multiple phone numbers or emails in one field).

✅ **Result:** All tables satisfy **1NF**.

---

### **Step 2 – Second Normal Form (2NF)**
**Requirement:**  
- The database must already be in 1NF.  
- Remove **partial dependencies** — no non-key attribute should depend on part of a composite key.

**Implementation:**  
- None of the tables use composite primary keys — each table uses a **single-column primary key (UUID)**.  
- All attributes fully depend on their respective primary key.

✅ **Result:** All tables satisfy **2NF**.

---

### **Step 3 – Third Normal Form (3NF)**
**Requirement:**  
- The database must be in 2NF.  
- Remove **transitive dependencies** — no non-key attribute should depend on another non-key attribute.

**Implementation & Validation:**

| Table | Check | Notes |
|--------|--------|-------|
| **User** | All non-key fields (`email`, `role`, `password_hash`) depend only on `user_id`. | No transitive dependency. |
| **Property** | Depends solely on `property_id`. The `host_id` is a foreign key to `User`, not a derived value. | No redundancy. |
| **Booking** | Fields like `total_price`, `status`, and `dates` depend only on `booking_id`. | Fully normalized. |
| **Payment** | `amount`, `payment_method`, etc., depend on `payment_id`. | Could optionally derive `amount` from `Booking`, but storing it here supports payment history and integrity. |
| **Review** | All fields depend on `review_id`. `rating` and `comment` have no dependency on other attributes. | Valid 3NF. |
| **Message** | Each attribute depends only on `message_id`; sender and recipient are self-referencing FKs. | Fully normalized. |

✅ **Result:** All tables satisfy **3NF** — no redundant or transitive dependencies remain.

---

## 🧠 2. Benefits of Achieving 3NF
- **Eliminates Redundancy:** No duplicated user or property data.  
- **Ensures Data Integrity:** Changes in one place automatically reflect system-wide.  
- **Improves Scalability:** Easier to extend schema (e.g., adding amenities, images).  
- **Enhances Query Performance:** Reduces storage waste and speeds up joins through smaller, cleaner tables.

---

## 💡 3. Example Adjustments (if Needed)
During review, a few minor adjustments reinforced 3NF compliance:

1. **Separated Concerns:**  
   - Payments are stored in a separate table rather than embedded within bookings.
2. **Removed Derived Data:**  
   - `total_price` remains stored for historical accuracy but could be calculated dynamically if performance permits.
3. **Maintained Referential Integrity:**  
   - All foreign keys reference primary keys; no circular or hidden dependencies.

---

## ✅ 4. Conclusion
The final database schema for the **Airbnb Clone** is **fully normalized up to Third Normal Form (3NF)**.  
Each entity is independent, relationships are well-defined, and the design ensures **data consistency**, **security**, and **efficiency** in production environments.

---
