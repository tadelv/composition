// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Composition",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "CompositionRoot",
      targets: ["CompositionRoot"]),
    .library(
      name: "Models",
      targets: ["Models"]),
    .library(
      name: "FeatureA",
      targets: ["FeatureA"]),
    .library(
      name: "FeatureB",
      targets: ["FeatureB"]),
    .library(
      name: "FeatureC",
      targets: ["FeatureC"]),
    .library(
      name: "NavigationTools",
      targets: ["NavigationTools"]
    ),
    .library(
      name: "ListFeature",
      targets: ["ListFeature"]
    ),
    .library(
      name: "Images",
      targets: ["Images"]
    ),
    .library(
      name: "Fonts",
      targets: ["Fonts"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swiftui-navigation.git", from: "0.8.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "CompositionRoot",
      dependencies: [
        "FeatureA",
        "FeatureB",
        "ListFeature"
      ]
    ),
    .target(
      name: "Models",
      dependencies: []),
    .target(
      name: "FeatureA",
      dependencies: [
        .product(name: "SwiftUINavigation", package: "swiftui-navigation"),
        "Models"
      ]),
    .target(
      name: "FeatureB",
      dependencies: [
        .product(name: "SwiftUINavigation", package: "swiftui-navigation"),
        "Models",
        "FeatureC",
        "NavigationTools"
      ]),
    .target(
      name: "FeatureC",
      dependencies: [
        .product(name: "SwiftUINavigation", package: "swiftui-navigation"),
        "Models",
        "Images",
        "Fonts"
      ]),
    .target(
      name: "NavigationTools",
      dependencies: [
        .product(name: "SwiftUINavigation", package: "swiftui-navigation")
      ]
    ),
    .target(
      name: "ListFeature",
      dependencies: [
        "NavigationTools",
        "FeatureC"
      ]
    ),
    .target(
      name: "Images"
    ),
    .target(
      name: "Fonts",
      resources: [.process("Fonts")]
    )
  ]
)
