import ProjectDescription

extension ConfigurationName {
    public static let dev: ConfigurationName = "Dev"
    public static let prod: ConfigurationName = "Prod"
}

extension Settings {
    /// Feature·Domain·Data·DesignSystem 공통
    public static let module: Settings = .settings(configurations: [
        .debug(name: .dev, xcconfig: .relativeToRoot("XCConfig/Shared.xcconfig")),
        .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/Shared.xcconfig")),
    ])

    /// App 전용: 환경별 xcconfig (각 파일이 Shared.xcconfig를 include)
    public static let app: Settings = .settings(configurations: [
        .debug(name: .dev, xcconfig: .relativeToRoot("XCConfig/Dev.xcconfig")),
        .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/Prod.xcconfig")),
    ])

    /// 타깃 기본값에서 SWIFT_VERSION을 빼서 Shared.xcconfig 값을 따르게 한다
    /// (Tuist는 타깃마다 SWIFT_VERSION = 5를 넣고, 타깃 설정이 프로젝트 xcconfig보다 우선한다)
    public static let target: Settings = .target()

    public static func target(base: SettingsDictionary = [:]) -> Settings {
        .settings(base: base, defaultSettings: .recommended(excluding: ["SWIFT_VERSION"]))
    }
}
