// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "PureSwiftUITools",
    platforms: [
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "PureSwiftUITools",
            targets: ["PureSwiftUITools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CodeSlicing/pure-swift-ui.git", .branch("feature/3.0.0")),
    ],
    targets: [
        .target(
            name: "PureSwiftUITools",
            dependencies: ["PureSwiftUI"]),
    ]
)
