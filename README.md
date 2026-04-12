# 🛸 SkyLens: Drone Gallery Optimization

SkyLens is an iOS application designed for drone photographers to review high-resolution aerial captures in the field .

**Current Phase:** Phase 1 (Baseline Simulation - Sessions 1 & 2)
**Status:** Intentionally Unoptimized 🚨

## 📝 Overview

The goal of this project phase is to establish a performance baseline by deliberately recreating a common iOS bottleneck: **Main-thread.**
Currently, the application attempts to synchronously download and decode a batch of 50+ 4k high-resolution image while the user scrolls.
This Causes severe UI stuttering, frame drops, and application hangs, simulating the exact problem we aim to fix in subsequent phases using Swift concurrency and Core Graphics downsampling. 

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

