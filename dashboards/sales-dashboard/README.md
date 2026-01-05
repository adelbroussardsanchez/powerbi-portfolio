# Honey Financial Packet & Sales Analysis Dashboard

This repository contains a Power BI dashboard built to replicate a full financial packet while also supporting detailed sales performance analysis. The dashboard combines traditional financial statements with operational sales insights to mirror the type of reporting delivered to executive and client stakeholders. All identifying information, including client names, customer identifiers, account numbers, and transactional details, has been fully redacted. The data model preserves real-world structure, relationships, and business logic without exposing private information.


## Purpose

The dashboard is designed to deliver a complete financial packet alongside sales analysis in a single, cohesive Power BI file. It supports month-to-date, quarter-to-date, and year-to-date reporting for financial statements, while also enabling analysis of sales trends, customer performance, and revenue drivers. The goal is to demonstrate how Power BI can replace static financial packets with dynamic, self-service reporting.


## Key Features

-**Financial Packet Reporting:**

Income Statement–style views with revenue, cost of goods sold, gross profit, and operating expenses

MTD, QTD, and YTD metrics aligned to accounting periods

Prior-period and prior-year comparisons


-**Sales Analysis:**

Revenue trends over time by customer, product, or sales category

Contribution to total revenue and gross profit by customer or segment

Variance analysis highlighting growth and decline drivers


-**Advanced Time Intelligence:**

Measures that respect fiscal logic and month-end close timing (data lag built into calculations)

Consistent handling of partial periods and historical comparisons


-**Robust Financial Logic:**

Ratio calculations (e.g., Gross Profit %, margin metrics) with defensive logic for zero or missing values

Clear separation of base measures and presentation measures to ensure auditability


-**Executive-Ready Visuals:**

KPI indicators for period-over-period performance

Clean, packet-style layouts designed to mirror real financial reporting expectations


-**Secure Data Handling:**

All sensitive financial and sales data has been anonymized

Only modeling techniques, DAX logic, and structural patterns are preserved


## Contents

-**Dashboard Recordings:** Walkthrough videos demonstrating financial packet navigation and sales analysis workflows

-**Data Model Screenshot:** Visual documentation of fact and dimension tables, including financial and sales relationships

-**M Code:** Power Query transformations used to shape financial and sales data

-**Example DAX Measures:** Core financial metrics, sales measures, and time intelligence logic

-**Tabular Editor Assets:** Calculation groups, format strings, and organizational metadata

## Usage

This dashboard is intended as a portfolio artifact showcasing advanced Power BI capabilities in financial reporting and sales analytics. It demonstrates how static financial packets and disconnected sales reports can be unified into a single, governed data model that supports both executive-level financial review and deeper analytical exploration.
