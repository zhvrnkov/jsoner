// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "JSONer",
        platforms: [.macOS(.v10_15)],
        products: [
            .executable(name: "JSONer", targets: ["JSONer"]),
            .library(name: "CartfileParser", targets: ["CartfileParser"])
        ],
        dependencies: [
            .package(url: "https://github.com/apple/swift-argument-parser.git", .exact("0.3.1")),
        ],
        targets: [
            .target(
                    name: "JSONer",
                    dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
                                   "CartfileParser"]),
            .target(name: "CartfileParser"),
            .testTarget(name: "CartfileParserTest",
                        dependencies: ["CartfileParser"],
                        resources: [.copy("Resources")])
        ]
)
