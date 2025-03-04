// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMeasurementUnits",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SwiftMeasurementUnits",
            targets: ["SwiftMeasurementUnits"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alessio2704/HapticManager.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "SwiftMeasurementUnits",
            dependencies: ["HapticManager"]
        ),
        .testTarget(
            name: "SwiftMeasurementUnitsTests",
            dependencies: ["SwiftMeasurementUnits"]
        ),
    ]
)
