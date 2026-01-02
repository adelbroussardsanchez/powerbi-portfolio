# Financial Packet Dashboard

This repository contains a Power BI dashboard designed to analyze financial data and provide the end user with easy-to-read and -understand financial statements. All identifying information, including client names, account numbers, and sensitive transaction details, has been fully redacted. The dataset is structured to preserve real-world relationships and hierarchies without exposing private information.

## Purpose
The dashboard provides insights into financial performance, including month-to-date, quarter-to-date, and year-to-date metrics. It supports analysis of key line items such as revenue, gross profit, and expenses, with visual indicators (KPIs) for performance trends.

## Key Features
- **Time Intelligence Measures:** Current month, prior month, and year-to-date calculations that account for accounting delays (data is available one month behind due to month-end close).  
- **Dynamic Percent Calculations:** Gross Profit % and other ratio metrics calculated with conditional logic to handle missing or zero values.  
- **Visual Performance Indicators:** Month-over-month and year-over-year changes flagged with green/red symbols based on thresholds.  
- **Secure Data Handling:** All sensitive client and account information has been removed; only the structure and logic of the financial data remain.

## Contents
- **Dashboard Recordings:** Video walkthroughs of the interactive Power BI dashboard.  
- **Data Model Screenshot:** Visual representation of table relationships and hierarchies.  
- **M Code:** Power Query scripts for all tables used in the dashboard.  
- **Example DAX Measures:** Key calculations for financial metrics and time intelligence.  
- **Tabular Editor Scripts:** DAX and format string expressions for calculation groups and formatting.

## Usage
This dashboard serves as a portfolio example to demonstrate advanced Power BI modeling, financial reporting, and time intelligence techniques. It can be used as a reference in automating financial statements using Power BI.

