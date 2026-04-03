// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MathShape",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
    ],
    products: [
        .library(
            name: "MathShape",
            targets: ["MathShape"]
        ),
    ],
    targets: [
        .target(name: "MathShape"),
    ]
)
