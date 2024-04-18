// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "ComposedDependant",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library( name: "ComposedDependant", targets: ["ComposedDependant"]),
    ],
    dependencies: [
        .package(url: "https://github.com/opennetltd/Composed.git", from: "2.0.0-beta.2"),
    ],
    targets: [
        .target(
            name: "ComposedDependant",
            dependencies: ["Composed"]
        ),
    ]
)
