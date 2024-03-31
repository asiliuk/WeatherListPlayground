// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherListPackage",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "WeatherListPackage",
            targets: ["WeatherListPackage"]),
    ],
    targets: [
        .target(
            name: "WeatherListPackage",
            dependencies: ["WeatherListProvider", "AsiliukMVVM"]),
        .target(
            name: "WeatherListProvider"),

        .target(
            name: "AsiliukMVVM",
            dependencies: ["WeatherListProvider"]),
        .testTarget(
            name: "AsiliukMVVMTests",
            dependencies: ["AsiliukMVVM", "WeatherListProvider"]),
    ]
)
