# Financial Packet + Sales Analysis Data Model
## Overview

This model builds on the core financial packet to add customer-level sales and profitability analysis. It supports Gross Profit reporting, customer rankings, and controlled display order.

## Primary Use Cases

P&L by customer

Customer ranking by Gross Profit

Sales contribution analysis

Financial statement views with customer drill-down

Measure customer profitability through sales amount, sales over time, and sales variables (incentives, brokers, freight) for top customers

## Model Design

-**Architecture**

Core financial model stays the same

Customer dimensions added without affecting totals

Ranking and display logic kept in helper tables

Includes sales variables and metrics to track profitability by top customers

-**Key Fact Tables**

P&L by Customer: Financial activity by customer

Transaction Detail: Shared with the financial packet for reconciliation

-**Key Dimension Tables**

Customer Display Order: Controls category grouping, rank, and final sort order

Chart of Accounts: Shared with financial packet

Calendar: Shared time intelligence layer

-**Ranking and Display Logic**

Gross Profit calculated at customer level

Rank stored separately to avoid circular dependencies

Custom categories supported without inflating totals

-**Design Principles**

Customer logic layered on top of financial truth

No duplication of financial measures

Sorting and ranking handled outside of visuals
