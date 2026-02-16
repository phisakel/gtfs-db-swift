// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "gtfs-db-swift",
    defaultLocalization: "en", // for tests
     platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v7),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GtfsDb",
            targets: ["GtfsDb"]),
    ],
     dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "7.9.0"),
        .package(url: "https://github.com/emma-k-alexandra/GTFS.git", .upToNextMajor(from: "1.0.1")),
	],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        .target(
            name: "GtfsDb",
            dependencies: [
                .product(name: "GRDB", package: "grdb.swift"),
                "GTFS"
            ],
            swiftSettings: [
       		    .enableUpcomingFeature("InferIsolatedConformances"),
        		.enableUpcomingFeature("NonisolatedNonsendingByDefault")
 
            ]),
        .testTarget(
            name: "GtfsDbTests",
            dependencies: [
                "GtfsDb",
            ],
            swiftSettings: [
       		    .enableUpcomingFeature("InferIsolatedConformances"),
        		.enableUpcomingFeature("NonisolatedNonsendingByDefault")
            ]
        ),
    ]
)
