# Project Management Dashboard

This repository contains a Power BI project management dashboard built on data sourced from Microsoft Teams task and project workflows. It tracks projects, tasks, resource assignments, and time in a single model to provide clear visibility into execution, workload, and team capacity. All identifying information has been anonymized while preserving real-world structure and logic.

## Purpose

The dashboard provides operational visibility into project progress and team capacity. It is built to answer core management questions: who is working on what, how time is being allocated, where backlog exists, and whether resources are under- or over-utilized. The project demonstrates how Power BI can be used to replace fragmented project tracking tools with a centralized, analytical view.

## Key Features

-**Project & Task Tracking:**

Task counts and effort by project, status, and bucket

Explicit progress identification driven by task-level status logic (buckets)

Clear distinction between planned effort and assigned effort

-**Resource Utilization:**

Effort tracked in hours and normalized into days and weeks using standard capacity assumptions

Aggregation measures built on top of base measures to ensure consistency across visuals

Effort calculations designed to remain stable under different slicer and grouping contexts

-**Time Intelligence:**

Forward-looking date logic to support operational planning

Dynamic calculation of time remaining until the next business milestone (next Monday)

Calendar-driven date resolution to avoid hard-coded assumptions and ensure extensibility

Measures designed to support countdown-style visuals and scheduling indicators

-**Bucket & Status Logic:**

Task classification across all workflow buckets: Backlog, Up Next, In Progress, Blocked

Bucket-level flags at the task grain for filtering, KPIs, and conditional formatting

Bucket-specific counts built on top of flags to avoid double counting

Clear separation between row-level status logic and aggregated measures

-**Model-Driven Design:**

Star-schema structure with clear fact and dimension separation

Aggregation measures expressed as transformations of base measures rather than raw columns

Defensive DAX patterns used to reduce ambiguity and improve measure reliability

-**Secure Data Handling:**

All employee, project, and organizational identifiers removed

Focus maintained on analytical structure, DAX logic, and modeling decisions rather than data content

## Contents

-**Dashboard Recordings:** Video walkthroughs demonstrating project tracking, backlog analysis, and utilization views

-**Data Model Screenshot:** Diagram showing relationships between tables

-**M Code:** Power Query connections and transformations used to shape and standardize source data

-**Example DAX Measures:** Example DAX measures covering effort, backlog, and scheduling logic

## Usage

This dashboard serves as a portfolio example of advanced Power BI modeling for project and resource management. It shows how clean DAX, well-organized measures, and basic date logic can replace manual project tracking with clear, reliable reporting for both managers and executives.
