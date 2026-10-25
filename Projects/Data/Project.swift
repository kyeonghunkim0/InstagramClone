import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "Data",
    dependencies: [
        .domain,
        .External.firebaseAuth,
        .External.firebaseFirestore,
        .External.firebaseStorage,
    ],
    testDependencies: [.domainTesting]
)
