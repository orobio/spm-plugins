// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildSupport",
    products: [
        .library(
            name: "ConditionalDependencies",
            type: .dynamic,
            targets: ["ConditionalDependencies"]),
        .library(
            name: "KernelInfo",
            type: .dynamic,
            targets: ["KernelInfo"]),
    ],
    targets: [
        .target(
            name: "ConditionalDependencies",
            dependencies: []),  // Has a dependency to PackageDescription, but I assumed that is either
                                // not possible or quite complicated, so I hacked it into the build script.
        .target(
            name: "KernelInfo",
            dependencies: []),
    ]
)
