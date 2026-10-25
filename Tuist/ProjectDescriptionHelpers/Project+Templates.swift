//
//  Project+Templates.swift
//  
//
//  Created by 김경훈 on 10/25/26.
//

import ProjectDescription

public let bundleIdPrefix = "com.kimkhuna.instagramclone"
public let deploymentTargets: DeploymentTargets = .iOS("17.0")

extension Project {
    /// Sources / (Testing) / Tests / (Demo) 타깃을 만드는 공통 템플릿
    public static func module(
        name: String,
        dependencies: [TargetDependency] = [],
        testDependencies: [TargetDependency] = [],
        hasResources: Bool = false,
        hasTesting: Bool = false,
        hasDemo: Bool = false
    ) -> Project {
        var targets: [Target] = [
            .target(
                name: name,
                destinations: .iOS,
                product: .staticFramework,
                bundleId: "\(bundleIdPrefix).\(name)",
                deploymentTargets: deploymentTargets,
                buildableFolders: hasResources ? ["Sources", "Resources"] : ["Sources"],
                dependencies: dependencies,
                settings: .target
            ),
        ]

        if hasTesting {   // Domain/Testing → DomainTesting (Mock Repository)
            targets.append(.target(
                name: "\(name)Testing",
                destinations: .iOS,
                product: .staticFramework,
                bundleId: "\(bundleIdPrefix).\(name)Testing",
                deploymentTargets: deploymentTargets,
                buildableFolders: ["Testing"],
                dependencies: [.target(name: name)],
                settings: .target
            ))
        }

        targets.append(.target(
            name: "\(name)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleIdPrefix).\(name)Tests",
            deploymentTargets: deploymentTargets,
            buildableFolders: ["Tests"],
            dependencies: [.target(name: name)]
                + (hasTesting ? [.target(name: "\(name)Testing")] : [])
                + testDependencies,
            settings: .target
        ))

        if hasDemo {
            targets.append(.target(
                name: "\(name)Demo",
                destinations: .iOS,
                product: .app,
                bundleId: "\(bundleIdPrefix).\(name)Demo",
                deploymentTargets: deploymentTargets,
                infoPlist: .extendingDefault(with: ["UILaunchScreen": [:]]),
                buildableFolders: ["Demo"],
                dependencies: [.target(name: name), .domainTesting],
                settings: .target
            ))
        }

        return Project(name: name, settings: .module, targets: targets)
    }

    /// Feature는 의존성을 인자로 받지 않음 → Domain·DesignSystem 외에는 연결할 수 없음
    public static func feature(_ feature: Feature) -> Project {
        module(
            name: feature.rawValue,
            dependencies: [.domain, .designSystem],
            testDependencies: [.domainTesting],
            hasDemo: true
        )
    }
}
