# 🛸 SkyLens: Drone Gallery Optimization

SkyLens is an iOS application designed for drone photographers to review high-resolution aerial captures in the field .

**Current Phase:** Phase 1 (Baseline Simulation - Sessions 1 & 2)
**Status:** Intentionally Unoptimized 🚨

## 📝 Overview

This project successfully resolves severe UI stuttering, main-thread blocking and network timeout errors (Code -1001) caused by loading massive 4K RAW image payloads. The application has been fully refactored to utilize a thread-safe, asynchronous architecture, ensuring a fluid 60 FPS scrolling experience with a minimal memory footprint .

## 🛠 Optimization Techniques Implemented
### 1. Asynchronous UI Unblocking (`async/await`) 
Synchronous `Data(contentsOf: )` calls were completely removed.
The network layer was rewritten using swift 5.5 concurrency (`URLSession.shared.data(from:url) async throws`) wrapped within SwiftUI `.task` modifiers. This unblocks the main UI thread during heavy network activity and automatically off-screen
### 2. Core Graphics Downsampling

### 3. Thread-Safe In-Memory Caching

### 4. UI Polish

## 🏗 Architecture & Setup

The project has been structured with a clean, scalable folder architecture to separate concerns:
* **`Models/`**: Contains the `ImageModel` struct.
* **`Services/`**: Contains the `MockDataService`, which acts as our mock backend . It dynamically generates 50 unique payload URLs for 4k images ( 3840x2160) using public placeholder API to simulate massive RAW drone files. 
* **`Views/`**: Contains the SwiftUI `ContentView` ( a `LazyVGrid` layout) and the `ImageCellView`.
* **`Utilities/` **: (Reserved for future downsampling and catching engines).

## 🏮 The Bottleneck: Synchronous Loading

Inside `ImageCellView.swift`, the application currently utilizes the following intentionally poor implementation:

```swift
let data = try Data(contentsOf: url)
let image = UIImage(data: data)

