# 🇳🇬 Airbnb Clone – Sample Data (`seed.sql`)

## 📘 Overview
This `seed.sql` file populates the **Airbnb Clone PostgreSQL database** with sample data.  
It includes sample **users, properties, bookings, payments, reviews, and messages** — simulating real-world activity on a booking platform.

---

## 🧩 Entities and Example Data

| Entity | Example Records | Description |
|---------|------------------|-------------|
| **User** | Dayo Adeyemi (Host), Aisha Bello (Guest), Ngozi Umeh (Host), Chinedu Okafor (Guest), Ibrahim Lawal (Admin) | Stores user accounts and roles. |
| **Property** | Lekki Seaside Apartment, Abuja City View Loft | Properties listed by hosts. |
| **Booking** | Reservations made by guests | Linked to users and properties. |
| **Payment** | Credit card, PayPal, or Stripe payments | Associated with confirmed bookings. |
| **Review** | Guest feedback with ratings (1–5) | Created after completed stays. |
| **Message** | Direct chat between guests and hosts | Facilitates pre-booking communication. |

---

## ⚙️ Prerequisites

Before running this script, ensure:
- PostgreSQL **v14+** is installed  
- The database schema (`schema.sql`) has already been executed  
- The **UUID** extension is enabled using:

```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```
🧠 pgcrypto provides gen_random_uuid() for globally unique IDs.

