// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "VelvetLeash",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // Core Packages
        .package(url: "https://github.com/vapor/vapor.git", "4.50.0"..<"4.60.0"),
        .package(url: "https://github.com/vapor/fluent.git", "4.4.0"..<"4.5.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", "4.1.0"..<"4.2.0"),
        .package(url: "https://github.com/vapor/leaf.git", "4.0.0"..<"4.2.0"),
        
        // FORCED LOCKS: Prevents sub-packages from downloading Swift 5.7+ feature
        .package(url: "https://github.com/vapor/leaf-kit.git", "1.0.0"..<"1.3.0"),
        .package(url: "https://github.com/apple/swift-collections.git", "1.0.0"..<"1.1.0"),
        .package(url: "https://github.com/apple/swift-atomics.git", "1.0.0"..<"1.1.0")
    ],
    targets: [
        .executableTarget(
            name: "VelvetLeash",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor")
            ]
        )
    ]
)
