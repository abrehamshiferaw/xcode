# 🐾 The Velvet Leash: Daily Paws Report Generator

A lightweight, full-stack internal web application built for **The Velvet Leash Boutique & Boarding**. This tool allows daycare staff to quickly generate and share "Daily Paws Reports" with pet parents via unique, mobile-responsive web links.

## 🌟 Features

* **Staff Input Form:** A fast, streamlined interface for staff to log a pet's energy level, meal consumption, best friends, and daily notes.
* **Instant Report Generation:** Generates a unique, read-only URL (e.g., `/report/<UUID>`) immediately upon form submission.
* **Boutique UI:** Clean, centered, mobile-first design built with custom CSS and Vapor's Leaf templating engine.
* **Local Storage:** Uses SQLite for lightweight, reliable data persistence.
* **Containerized:** Includes a custom `Dockerfile` configured for zero-configuration deployments on Linux servers.

## 🛠 Tech Stack & Architecture

* **Language:** Swift 5.5
* **Framework:** Vapor 4
* **Database & ORM:** SQLite & Fluent
* **Templating:** Leaf
* **Deployment:** Docker
* **Architecture Notes:** * Utilizes `EventLoopFuture` for broad macOS compatibility (macOS 11 / Xcode 13.2.1+).
  * Implements a `ReportContext` Data Transfer Object (DTO) to safely bridge complex SQLite `@Field` wrappers with the Leaf HTML encoder.

## 📂 Project Structure

```text
VelvetLeash/
├── Dockerfile                  # Production build instructions
├── Package.swift               # Swift dependencies
├── Resources/                  
│   └── Views/
│       ├── base.leaf           # Main CSS and HTML layout wrapper
│       └── components/         
│           ├── index.leaf      # Staff input form UI
│           └── report.leaf     # Parent read-only page UI
└── Sources/
    └── VelvetLeash/
        ├── Controllers/
        │   └── ReportController.swift # Routing & Data Handling
        ├── Migrations/
        │   └── CreateReport.swift     # SQLite table schemas
        ├── Models/
        │   └── Report.swift           # Database Model
        ├── configure.swift
        ├── main.swift
        └── routes.swift
