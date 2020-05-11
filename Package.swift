// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "AppSupport",
    platforms: [.iOS(.v13), .tvOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "AppSupport",
            targets: ["AppSupport"]),
    ],
    targets: [
        .target(
            name: "AppSupport",
            dependencies: []),
        .testTarget(
            name: "AppSupportTests",
            dependencies: ["AppSupport"]),
    ]
)
