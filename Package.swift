// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Catamaran",
    platforms: [
        .macOS(.v10_15),
        .custom("Windows", versionString: "5"),
        .custom("Linux", versionString: "5")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Catamaran",
            targets: ["Catamaran"]),
    ],
    dependencies: [
            .package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.0"),
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Catamaran", dependencies: [
                "CatamaranMacros",
            ]),
        .testTarget(
            name: "CatamaranTests",
            dependencies: ["Catamaran", "CatamaranMacros"]),
        .macro(name: "CatamaranMacros",
              dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
              ]),
        .executableTarget(name: "CatamaranTestClient", dependencies: ["Catamaran"], path: "Executable/")
    ]
)
