// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "zenea-swift-http",
    platforms: [
        .macOS("13.3")
    ],
    products: [
        .library(name: "zenea-swift-http", targets: ["ZeneaHTTP"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.92.6"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.3.0"),
        .package(url: "https://github.com/zenea-project/zenea-swift.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "ZeneaHTTP",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "zenea-swift", package: "zenea-swift")
            ],
            path: "./Sources/zenea-swift-http"
        )
    ]
)
