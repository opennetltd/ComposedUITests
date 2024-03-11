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
        .package(url: "https://github.com/opennetltd/Composed.git", branch: "fix-reload-after-item-deletes"),
    ],
    targets: [
        .target(
            name: "ComposedDependant",
            dependencies: ["Composed"]
        ),
    ]
)
