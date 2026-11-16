// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "UserDefaultsKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "UserDefaultsKit",
            targets: ["UserDefaultsKit"]),
    ],
    targets: [
        .target(name: "UserDefaultsKit"),
        .testTarget(
            name: "UserDefaultsKitTests",
            dependencies: ["UserDefaultsKit"]),
    ]
)
