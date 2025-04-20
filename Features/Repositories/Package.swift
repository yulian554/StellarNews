// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repositories",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Repositories",
            targets: ["Repositories"]),
    ],
    dependencies: [
        .package(path: "../AppCommons"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Repositories",
            dependencies: [
                .product(
                    name: "AppCommons",
                    package: "AppCommons"
                ),
                .product(
                    name: "Alamofire",
                    package: "Alamofire"
                )
            ]
        ),
        .testTarget(
            name: "RepositoriesTests",
            dependencies: ["Repositories"]),
    ]
)
