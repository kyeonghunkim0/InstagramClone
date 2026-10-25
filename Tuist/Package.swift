// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:],
        // 외부 패키지도 워크스페이스와 같은 configuration 이름을 써야 한다
        baseSettings: .settings(configurations: [
            .debug(name: "Dev"),
            .release(name: "Prod"),
        ])
    )
#endif

let package = Package(
    name: "InstagramClone",
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "12.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "8.0.0"),
    ]
)
