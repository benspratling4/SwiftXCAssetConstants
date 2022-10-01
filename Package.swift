// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftXCAssetConstants",
	platforms: [
		.iOS(.v13),	//mainly for ExampleProject, ExampleProjectTests
		.tvOS(.v13),	//mainly for ExampleProject, ExampleProjectTests
	],
    products: [
		.plugin(name: "SwiftXCAssetConstants", targets: ["SwiftXCAssetConstants"]),
//		.library(name: "SwiftXCAssetConstantsLib", targets: ["SwiftXCAssetConstantsLib"]),
//		.library(name: "ExampleProject", type: .dynamic, targets: ["ExampleProject"])
    ],
    dependencies: [
    ],
    targets: [
		//internal library for doing the work
		.target(name: "SwiftXCAssetConstantsLib"),
		
		//the executable which is run by the plugin on a file-by-file basis
		.executableTarget(name: "SwiftXCAssetConstantsExec"
						 ,dependencies: [
							.target(name: "SwiftXCAssetConstantsLib"),
						 ]),
		
		//the main product, a plugin
		.plugin(name: "SwiftXCAssetConstants", capability: .buildTool(), dependencies: [
			.target(name: "SwiftXCAssetConstantsExec"),
		]),
		
		//an example of how you would call this plug-in for an ios project
		.target(name: "ExampleProject"
				, plugins: [
			"SwiftXCAssetConstants",
		]
			   ),
		
		//sample tests of ExampleProject to make it build
		.testTarget(name: "ExampleProjectTests", dependencies: [
			.target(name: "ExampleProject")
		]),
		
		
    ]
)
