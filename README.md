# The Velvet Leash: Daily Paws Report Generator

A lightweight, full-stack internal web application built for **The Velvet Leash Boutique & Boarding**.
This tool allows daycare staff to quickly generate and share "Daily Paws Reports" with pet parents via unique, mobile-reponsive web links.

## 🌟 Features

* **staff Input Form: ** A fast, streanlined interface for staff consumption, best friends, and daily notes.
* **Instant Report Generation:** Generates a unique, read-only URL (e.g., '/report/<UUID>') immediately upon form submission .
* **Parent View:** A clean, mobile-first, boutique-styled summary page for pet owners to view their dog's specific report on the go.

* **Local Storage:** Uses SQLite for lightweight, reliable data persistence.

## Tech stack & Architecture

* **Language: ** Swift 5.5
* **Framework:** Vapor 4
* **Database & ORM:** SQLite & Fluent
* **Templating:** Leaf
* **Styling: ** Custom CSS (Mobile-first, boutique aesthetic)
* **Concurrency: ** EventLoopFuture `(Architected specifically for macOS 11/ xcode 13 compatibility)

## 🚀 Getting Started
Follow these instructions to get a copy of the project up and running on your local machine using xcode

### Prerequisites

* A Mac running macOS .
* **Xcode** installed (Project is fully compatible with macOS 11 Big Sur / Xcode 13.2.1).
* Swift Package Manager (built into Xcode).

### Installation & Setup
1. **Clone the repository: **
```bash
git clone [https://github.com/abrehamshiferaw/xcode.git](https://github.com/abrehamshiferaw/xcode.git)
cd xcode

open Package.swift
```


