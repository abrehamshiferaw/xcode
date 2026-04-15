# 🚁 SkyLens: Drone Gallery Optimization

SkyLens is an iOS application designed for drone photographers to review high-resolution aerial captures in the field.

**Current Phase:** Final Delivery  
**Status:** Highly Optimized (60 FPS) 🚀

## 📝 Overview

This project successfully resolves severe UI stuttering, main-thread blocking, and network timeout errors (Code -1001) caused by loading massive 4K RAW image payloads. The application has been fully refactored to utilize a thread-safe, asynchronous architecture, ensuring a fluid 60 FPS scrolling experience with a minimal memory footprint.

## 🛠 Optimization Techniques Implemented

### 1. Asynchronous UI Unblocking (`async/await`)

Synchronous `Data(contentsOf:)` calls were completely removed. The network layer was rewritten using Swift 5.5 concurrency (`URLSession.shared.data(from: url) async throws`) wrapped within SwiftUI `.task` modifiers. This unblocks the main UI thread during heavy network activity and automatically cancels requests if a cell scrolls off-screen.

### 2. Core Graphics Downsampling

To prevent massive memory spikes, raw network data is intercepted before being decoded into a standard `UIImage`. Using `ImageIO` and `CGImageSource`, the 4K payloads are downsampled into lightweight, screen-optimized thumbnails (300x300pt) directly from the data buffer, vastly reducing RAM overhead.

### 3. Thread-Safe In-Memory Caching (`actor` & `NSCache`)

To prevent redundant network requests and re-downsampling when users scroll back up the `LazyVGrid`, an in-memory cache was implemented using `NSCache`. To prevent race-condition crashes during concurrent cell rendering, the cache manager is wrapped in a Swift `actor`, guaranteeing thread-safe read/write operations.

### 4. UI Polish

The UI was updated with a "Photography Studio" aesthetic, featuring a forced `.dark` color scheme, 8pt rounded image radii, and `ProgressView` loading states to provide immediate visual feedback during asynchronous fetching.

## 🚀 How to Run

1. Open `SkyLens.xcodeproj` in Xcode 13.2.1+.
2. Select an iOS Simulator.
3. Press `Cmd + R` to build and run.
