// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShoppeCheckout",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "ShoppeCheckout", targets: [
            "Cart"
        ]),
    ],
    dependencies: [
        .package(url: "https://github.com/ShapovalovIlya/ShoppeStore.git", branch: "main"),
        .package(url: "https://github.com/ShapovalovIlya/SwiftFP.git", branch: "main")
    ],
    targets: [
        .target(
            name: "Cart",
            dependencies: [
                .product(name: "SwiftFP", package: "SwiftFP"),
                .product(name: "ShoppeStore", package: "ShoppeStore"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(name: "ShoppeCheckoutTests", dependencies: [
            "Cart"
        ]),
    ]
)
