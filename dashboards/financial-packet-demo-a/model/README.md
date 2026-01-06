# Financial Packet Data Model

## Overview

This model is for consistent financial reporting across Income Statement, Balance Sheet, and Cash Flow. It’s built for month-end reporting, comparing periods, and showing hierarchical statements.

## Primary Use Cases

MTD, QTD, and YTD financial statements

Income Statement and Balance Sheet rollups

Cash Flow reporting from transactional data

Period-over-period variance analysis

## Model Design

-**Architecture**

Star-schema–oriented with a shared Chart of Accounts acting as the central dimension

Calendar table drives all time intelligence

Separate summary tables optimize performance for statement visuals

-**Key Fact Tables**

Transaction Detail: Individual financial transactions with date, account, and amount

Balance Sheet: Period-level balances by account

Cash Flow: Cash activity mapped to operating, investing, and financing categories

-**Key Dimension Tables**

Chart of Accounts: Account hierarchy, custom rollups, and display names

Calendar: Date intelligence including month, quarter, offsets, and period flags

Cash Flow Layout: Defines Cash Flow statement structure and ordering

-**Statement Structure**

Hierarchies handled through Level 1 / Level 2 fields and explicit sort orders

Display logic separated from raw financial values

Layout tables control presentation without altering measures

-**Design Principles**

No hard-coded logic inside visuals

All statement structure driven by layout and COA tables

Measures written to be reusable across statements
