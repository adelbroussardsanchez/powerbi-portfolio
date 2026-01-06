# Project Management Data Model

## Overview

This model tracks projects, tasks, and resource workload. It supports operational monitoring, effort management, and delivery performance, combining task-level detail with time-based analysis. It integrates with Microsoft Teams to capture task and assignment updates.

## Main Uses

Track backlog, blocked, and completed tasks

Analyze resource workload and effort

Monitor project progress and milestones

Report time-based KPIs

Measure project performance and resource contribution

## Model Design

-**Architecture**

Task-focused fact model

Resources and projects as core dimensions

Measures stored in a dedicated table

Supports tracking of task effort, status, and completion

Integrates Teams data for real-time task and assignment updates

-**Fact Tables**

Project Tasks: task status, effort, dates, completion

Resource Assignments: planned vs completed effort by resource

Projects: project metadata and ownership

-**Dimension Tables**

Team Members: resource identity and attributes

Calendar: period, offsets, current-period flags

-**Measure Strategy**

Backlog, blocked, completed counts derived from task flags

Effort tracked in hours, converted to day-level metrics

KPIs written as measures for slicing by project, resource, or time

Includes metrics to assess workload and project-level performance

-**Principles**

Task state separated from reporting logic

No bidirectional relationships

Measures survive filtering across project, resource, and time
