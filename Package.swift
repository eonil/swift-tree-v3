// swift-tools-version:5.0
// https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md
import PackageDescription

let package = Package(
    name: "TreeV3",
    platforms: [
        .macOS(.v10_11),
    ],
    products: [
        /// Xcode 11 Beta has troubles with multiple product package...
        .library(name: "TreeV3", type: .static, targets: ["TreeV3"]),
        .library(name: "PDTreeV3", type: .static, targets: ["PDTreeV3"]),
    ],
    dependencies: [
        .package(url: "https://github.com/eonil/BTree", .branch("master")),
    ],
    targets: [
        /// A target is required to build a **module**.
        .target(
            name: "TreeV3",
            dependencies: ["TreeV3Core", "TreeV3Util"],
            path: "TreeV3"),
        .target(
            name: "TreeV3Core",
            dependencies: [],
            path: "TreeV3Core"),
        .target(
            name: "TreeV3Util",
            dependencies: ["TreeV3Core"],
            path: "TreeV3Util"),
        .testTarget(
            name: "TreeV3UtilTest",
            dependencies: ["TreeV3Util"],
            path: "TreeV3UtilTest"),

        .target(
            name: "PDTreeV3",
            dependencies: [
                "TreeV3Core",
                "TreeV3Util",
                .product(name: "BTree"),
            ],
            path: "PDTreeV3"),
        .testTarget(
            name: "PDTreeV3Test",
            dependencies: ["PDTreeV3"],
            path: "PDTreeV3Test"),

    ]
)
