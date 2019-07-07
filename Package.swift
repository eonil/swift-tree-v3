// swift-tools-version:5.0
// https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md
import PackageDescription

let package = Package(
    name: "TreeV3",
    platforms: [
        .macOS(.v10_11),
    ],
    products: [
        .library(name: "TreeV3", type: .static, targets: ["TreeV3"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TreeV3",
            dependencies: [],
            path: "TreeV3"),
        .testTarget(
            name: "TreeV3Test",
            dependencies: ["TreeV3"],
            path: "TreeV3Test"),
    ]
)
