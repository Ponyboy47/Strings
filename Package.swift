// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Strings",
    products: [
        .library(
            name: "Strings",
            targets: ["Strings"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Strings",
            dependencies: []),
        .testTarget(
            name: "StringsTests",
            dependencies: ["Strings"]),
    ]
)
