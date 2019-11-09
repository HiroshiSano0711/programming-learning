// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HelloKitura",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.8.0")
    ],
    targets: [
        .target(
            name: "HelloKitura",
            dependencies: ["Kitura"]),
        .testTarget(
            name: "HelloKituraTests",
            dependencies: ["HelloKitura"]),
    ]
)
