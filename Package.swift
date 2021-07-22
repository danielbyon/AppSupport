// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppSupport",
    platforms: [.iOS(.v14), .tvOS(.v14), .macOS(.v11)],
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
