// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTools",
    platforms: [
        .iOS(.v15),
        .watchOS(.v6),
        .macOS(.v10_15),
        .tvOS(.v13),
    ],
    products: [
        .plugin(
            name: "SwiftTools",
            targets: ["SwiftTools"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.50.3/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "abe7c0bb505d26c232b565c3b1b4a01a8d1a38d86846e788c4d02f0b1042a904"
        ),
        .binaryTarget(
            name: "swiftformat",
            url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.51.2/swiftformat.artifactbundle.zip",
            checksum: "d8954ff40cf39d8e343eabd83e730bd8c85a27463e356e66cd51808ca3badcc7"
        ),
        .binaryTarget(
            name: "swiftgen",
            url: "https://github.com/nicorichard/SwiftGen/releases/download/6.5.1/swiftgen.artifactbundle.zip",
            checksum: "a8e445b41ac0fd81459e07657ee19445ff6cbeef64eb0b3df51637b85f925da8"
        ),
        .plugin(
            name: "SwiftTools",
            capability: .buildTool(),
            dependencies: [
                "SwiftLintBinary",
                "swiftformat",
                "swiftgen"
            ]
        )
    ]
)
