//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation
import PackagePlugin

@main
struct SwiftXCAssetConstants: BuildToolPlugin {
	/// This entry point is called when operating on a Swift package.
	func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
		guard let target = target as? SourceModuleTarget else { return [] }
		return try target
			.sourceFiles(withSuffix: "xcassets")
			.enumerated()
			.map({ (offset, xsd) in
				let base = xsd.path.stem
				let input = xsd.path
				let output = context.pluginWorkDirectory.appending("\(base)_ui_constants.swift")
				return .buildCommand(displayName: "Create UIColor and UIImage constants from \(base).xcassets"
									 ,executable: try context.tool(named: "SwiftXCAssetConstantsExec").path
									 ,arguments:[input.string, output.string]
									 ,inputFiles: [input]
									 ,outputFiles: [output])
			})
	}
}


#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftXCAssetConstants : XcodeBuildToolPlugin {
	/// 👇 This entry point is called when operating on an Xcode project.
	func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
//		guard let target = target as? SourceModuleTarget else { return [] }
		return try target
			.inputFiles.filter({ $0.path.extension == "xcassets" })
			.enumerated()
			.map({ (offset, xsd) in
				let base = xsd.path.stem
				let input = xsd.path
				let output = context.pluginWorkDirectory.appending("\(base)_ui_constants.swift")
				return .buildCommand(displayName: "Create UIColor and UIImage constants from \(base).xcassets"
									 ,executable: try context.tool(named: "SwiftXCAssetConstantsExec").path
									 ,arguments:[input.string, output.string]
									 ,inputFiles: [input]
									 ,outputFiles: [output])
			})
	}

}

#endif
