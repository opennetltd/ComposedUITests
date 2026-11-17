// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ComposedDependant",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library( name: "ComposedDependant", targets: ["ComposedDependant"]),
    ],
    dependencies: [
        .package(url: "https://github.com/opennetltd/Composed.git", branch: "crash-fixes"),
    ],
    targets: [
        .target(
            name: "ComposedDependant",
            dependencies: ["Composed"]
        ),
    ]
)
