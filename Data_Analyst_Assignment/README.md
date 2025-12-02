PlatinumRx – Data Analyst Assignment

This repository contains my submitted work for the PlatinumRx Data Analyst assignment.
The goal of the project was to implement small, practical solutions across SQL, spreadsheets, and Python to demonstrate working knowledge of database design, query writing, data lookups, and basic programming.

Project Overview

The assignment is divided into three parts:

SQL – Creating schemas and writing queries for two systems:

Hotel Management System

Clinic Management System

Spreadsheets – Working with timestamps, lookups, and outlet-wise analysis.

Python – Two short scripts focusing on time formatting and string manipulation.

Each task has been organised into separate folders for clarity.

Folder Structure
Data_Analyst_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
│
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
│
└── README.md

What Each Part Contains
1. SQL

The SQL/ directory includes:

Table creation scripts for both the Hotel and Clinic datasets

Insert statements for sample records

Query solutions for all assignment questions, including joins, grouping, ranking functions, and date-based filtering

The SQL scripts were written keeping cross-database compatibility in mind (works on MySQL/PostgreSQL with minimal changes).

2. Spreadsheets

The Ticket_Analysis.xlsx workbook contains:

A lookup column that pulls ticket creation timestamps into the feedback sheet

Calculations to identify tickets created and closed on the same day and the same hour

Summary counts grouped by outlet

Formulas used include VLOOKUP/INDEX-MATCH, date-time extraction, and COUNTIFS.

3. Python

The Python folder includes two scripts:

01_Time_Converter.py
Converts a total number of minutes into a human-readable “X hrs Y minutes” format.

02_Remove_Duplicates.py
Removes repeated characters from a string using simple loop logic.

Both scripts are kept minimal and easy to interpret.

How to View/Run the Files

SQL scripts can be executed in any MySQL/PostgreSQL environment or an online SQL runner.

The spreadsheet file opens in Excel or Google Sheets without any add-ons.

Python scripts run on any Python 3.x setup.

Notes

The assignment is structured in a way to demonstrate clarity, correctness, and clean organisation.
Each file is self-contained and directly answers the questions provided.