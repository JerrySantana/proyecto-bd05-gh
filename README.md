# Real Estate Enterprise Database Architecture

> **Advanced Relational Database & PL/SQL Management System**

---

## 🖥️ Tech Stack

- **RDBMS:** Oracle SQL
- **Programming Language:** PL/SQL (Procedural Language for SQL)
- **Concepts:** Data Definition Language (DDL), Data Manipulation Language (DML), Advanced Persistence, Transaction Control, and Automated Testing.

---

## 🗒️ Description

This repository contains the complete database architecture for a comprehensive **Real Estate and Property Management System**. It was developed to handle the complex business rules of property rentals, sales, ownership transitions, and digital contract storage.

Unlike basic CRUD implementations, this project enforces strict business logic and data integrity directly at the persistence layer using advanced Oracle SQL and PL/SQL capabilities.

---

## 🏗️ Architecture & Core Features

The project is structured into sequential scripts to ensure proper execution, dependency resolution, and modularity:

### 1. Schema Definition (DDL)
- **Entities & Relationships (`s-02`):** Core table structures defining properties, owners, and rental statuses with strict primary/foreign key constraints.
- **Advanced Structures (`s-03` to `s-08`):** Implementation of Temporary Tables, External Tables, Sequences for auto-incrementing IDs, Indices for query optimization, Synonyms, and Data Views.

### 2. Business Logic Implementation (PL/SQL)
- **Stored Procedures (`s-13`, `s-14`):** Encapsulated logic for complex transactions, such as inserting new properties and logging system SMS records.
- **User-Defined Functions (`s-15`, `s-16`):** Modular calculations for financial data, including dynamic rental cost and total rent calculations.
- **Database Triggers (`s-11`, `s-12`):** Automated execution of business rules before/after DML events. Includes triggers for:
  - Price consistency validation.
  - Maximum rental stay verification.
  - Automated status updates when a property is rented or sold.

### 3. Binary Large Object (BLOB) Storage
- **Digital Asset Management (`s-17`):** Specialized scripts to handle the secure storage of binary files directly within the database schema, including property images, payment receipts, and PDF rental contracts.

### 4. Automated Database Testing
Demonstrating a strong commitment to reliability, every logical component includes a dedicated testing script (`-prueba.sql`). These scripts simulate edge cases and valid operations to verify that Triggers, Functions, and Procedures execute perfectly without violating data integrity.

---

## 🪪 About the Project

The complete database architecture, entity-relationship modeling, and PL/SQL scripting were developed by **Gerardo Gabriel Santana Amezcua**. 

This repository reflects the rigorous database engineering principles and relational algebra concepts mastered during the **Computer Engineering** program at **UNAM**. It demonstrates the ability to design highly scalable, secure, and self-validating persistence layers for enterprise applications.
