CompanyDB - SQL Database Project 🚀

A comprehensive SQL project that demonstrates my ability to design, implement, and manage a real-world company database using MySQL.
This project focuses on database normalization, table relationships, data handling, and complex SQL queries — making it a great showcase of my database and problem-solving skills.

📌 Project Overview

The CompanyDB project manages a company's information, including:

=> Departments

=> Employees & Managers

=> Projects & Assignments

=> Clients

=> Employee-Project Mapping

It contains realistic sample data and over 50+ SQL queries ranging from basic retrievals to advanced joins, aggregations, and subqueries.

📂 Database Schema
Entities & Relationships

=> Departments → Stores department information

=> Employees → Tracks employee details and managers

=> Projects → Stores project info and budgets

=> Employee_Project → Many-to-many mapping between employees and projects

=> Clients → Client database for company projects

SCHEME Diagram -- 

Departments ─────< Employees >───── Employee_Project >───── Projects  
                       │
                       └────────────── Manager (Self-Join)
Clients (Standalone)
