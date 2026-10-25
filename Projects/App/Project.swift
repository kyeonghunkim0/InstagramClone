import ProjectDescription
import ProjectDescriptionHelpers

/// Firebase/{Dev,Prod}/GoogleService-Info.plist 중 현재 configuration에 맞는 파일을 앱 번들에 복사
/// Resources/ 밖에 두는 이유: buildableFolders에 들어가면 두 plist가 같은 이름으로 복사돼 충돌한다
let copyFirebasePlist: TargetScript = .post(
    script: """
    PLIST="${SRCROOT}/Firebase/${CONFIGURATION}/GoogleService-Info.plist"
    if [ ! -f "$PLIST" ]; then
        echo "warning: $PLIST 가 없습니다. Firebase 콘솔에서 받아 넣어주세요."
        exit 0
    fi
    cp "$PLIST" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/GoogleService-Info.plist"
    """,
    name: "Copy GoogleService-Info.plist",
    basedOnDependencyAnalysis: false
)

let project = Project(
    name: "App",
    settings: .app,
    targets: [
        .target(
            name: "InstagramClone",
            destinations: .iOS,
            product: .app,
            bundleId: "\(bundleIdPrefix)$(BUNDLE_ID_SUFFIX)",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
                "UILaunchScreen": [:],
            ]),
            buildableFolders: ["Sources", "Resources"],
            scripts: [copyFirebasePlist],
            dependencies: Feature.allCases.map { .feature($0) } + [.data, .domain, .designSystem],
            settings: .target(base: [
                "OTHER_LDFLAGS": "$(inherited) -ObjC",
                // 존재 여부가 환경마다 다른 plist를 복사하므로 스크립트 샌드박스를 끈다
                "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
            ])
        ),
        .target(
            name: "InstagramCloneTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleIdPrefix).Tests",
            deploymentTargets: deploymentTargets,
            buildableFolders: ["Tests"],
            dependencies: [.target(name: "InstagramClone")],
            settings: .target
        ),
    ]
)
