//
//  Module.swift
//  
//
//  Created by 김경훈 on 10/25/26.
//

import ProjectDescription

public enum Feature: String, CaseIterable {
    case auth = "Auth"
    case feed = "Feed"
    case upload = "Upload"
    case search = "Search"
    case profile = "Profile"
}

extension TargetDependency {
    public static let domain: TargetDependency = .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
    public static let domainTesting: TargetDependency = .project(target: "DomainTesting", path: .relativeToRoot("Projects/Domain"))
    public static let data: TargetDependency = .project(target: "Data", path: .relativeToRoot("Projects/Data"))
    public static let designSystem: TargetDependency = .project(target: "DesignSystem", path: .relativeToRoot("Projects/Shared/DesignSystem"))

    public static func feature(_ feature: Feature) -> TargetDependency {
        .project(target: feature.rawValue, path: .relativeToRoot("Projects/Feature/\(feature.rawValue)"))
    }

    public enum External {
        public static let kingfisher: TargetDependency = .external(name: "Kingfisher")
        public static let firebaseAuth: TargetDependency = .external(name: "FirebaseAuth")
        public static let firebaseFirestore: TargetDependency = .external(name: "FirebaseFirestore")
        public static let firebaseStorage: TargetDependency = .external(name: "FirebaseStorage")
    }
}
