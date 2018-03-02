// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Import the required plugins from the BuildSupport package
import ConditionalDependencies
import KernelInfo

let package = Package(
    name: "MyIpLib",
    products: [
        .library(
            name: "MyIpLib",
            targets: [
                .target(condition: KernelInfo.hasIpv4, name: "MyIpv4Module"),
                .target(condition: KernelInfo.hasIpv6, name: "MyIpv6Module"),
            ]
        ),
    ],
    targets: [
        .target(condition: KernelInfo.hasIpv4, name: "MyIpv4Module"),
        .target(condition: KernelInfo.hasIpv6, name: "MyIpv6Module"),
    ]
)
