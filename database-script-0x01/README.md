# 🏡 Airbnb Clone – Design Database Schema (DDL)

## 📘 Overview
This repository contains the **PostgreSQL database schema** for an **Airbnb Clone project**, designed to simulate the backend data structure of a real-world booking platform.

The schema defines the core entities, relationships, and constraints required to manage users, properties, bookings, payments, reviews, and messages — ensuring data integrity, scalability, and performance.

---

## 🎯 Objective
To create a **production-level relational database** for an Airbnb-style platform that supports:
- User registration and role management  
- Property listings and hosting  
- Booking and payment processing  
- Review and rating systems  
- Direct messaging between users  

---

## 🧱 Database Design Overview

### **Entities**
The database includes six main entities:

| Entity | Description |
|---------|--------------|
| **User** | Stores guest, host, and admin information. |
| **Property** | Represents listed accommodations managed by hosts. |
| **Booking** | Manages reservation details between guests and hosts. |
| **Payment** | Handles booking payments and payment methods. |
| **Review** | Contains user feedback and ratings for properties. |
| **Message** | Enables communication between users. |

---

### **Relationships**
| Relationship | Type | Description |
|---------------|------|-------------|
| User → Property | 1 → Many | A host can list multiple properties. |
| User → Booking | 1 → Many | A guest can make multiple bookings. |
| Property → Booking | 1 → Many | A property can have multiple bookings. |
| Booking → Payment | 1 → 1 | Each booking can have one payment record. |
| User → Review | 1 → Many | A user can write multiple reviews. |
| Property → Review | 1 → Many | A property can have multiple reviews. |
| User → Message | 1 → Many | A user can send or receive many messages. |

---

## 🗄️ Schema Overview

### **File:** `schema.sql`

Defines all database tables, primary keys, foreign keys, constraints, and indexes.

#### **Tables Created**
1. `users`  
2. `properties`  
3. `bookings`  
4. `payments`  
5. `reviews`  
6. `messages`

---

### **Key Features**
- **UUID Primary Keys:** Ensures globally unique identifiers for distributed scalability.  
- **CHECK Constraints:** Enforces logical data rules (e.g., valid ratings, booking dates).  
- **Foreign Keys:** Maintains referential integrity across entities.  
- **ENUM Simulation:** Roles and statuses defined using `CHECK` constraints for portability.  
- **Indexes:** Added on frequently queried columns to enhance performance.  
- **ON DELETE CASCADE:** Ensures dependent records are automatically cleaned up.  

---

## ⚙️ Installation & Setup

### **1️⃣ Prerequisites**
Make sure you have:
- [PostgreSQL 14+](https://www.postgresql.org/download/)
- `psql` command-line tool or a GUI client like **pgAdmin**
- UUID extension enabled (`pgcrypto`)

### **2️⃣ Clone the Repository**
```bash
git clone https://github.com/<your-username>/airbnb-clone-db.git
cd airbnb-clone-db
