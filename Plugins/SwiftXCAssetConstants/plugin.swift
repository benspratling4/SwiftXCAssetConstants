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
				let appDir = context.pluginWorkDirectory.appending(target.moduleName)
				let output = appDir.appending("\(base)_ui_constants.swift")
//				print("working dir \(appDir)")
//				return .prebuildCommand(displayName: "Create UIColor and UIImage constants from \(base).xcassets"
//										, executable: try context.tool(named: "SwiftXCAssetConstantsExec").path
//										, arguments: [input.string, output.string]
//										, outputFilesDirectory: appDir)

				return .buildCommand(displayName: "Create UIColor and UIImage constants from \(base).xcassets"
									 ,executable: try context.tool(named: "SwiftXCAssetConstantsExec").path
									 ,arguments:[input.string, output.string]
									 ,inputFiles: [input]
									 ,outputFiles: [output])
			})
	}
}


//sorry, but if you run this on an .xcassets file in an xcode project, it'll do this just fine,
//but then xcode will refuse to actually include the assets in the final app.
//so until apple provides a way to work around that,  this is disabled

//#if canImport(XcodeProjectPlugin)
/*
import XcodeProjectPlugin

extension SwiftXCAssetConstants : XcodeBuildToolPlugin {
	/// 👇 This entry point is called when operating on an Xcode project.
	func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
//		return []
//		guard let target = target as? SourceModuleTarget else { return [] }
		return try target
			.inputFiles.filter({ $0.path.extension == "xcassets" })
			.enumerated()
			.map({ (offset, xsd) in
				let base = xsd.path.stem
				let input = xsd.path
				let output = context.pluginWorkDirectory.appending("\(base)_ui_constants.swift")
				print("working dir \(output)")
//				return .prebuildCommand(displayName: "Create UIColor and UIImage constants from \(base).xcassets"
//										, executable: try context.tool(named: "SwiftXCAssetConstantsExec").path
//										, arguments: [input.string, output.string, "--xcodeproject"]
//										, outputFilesDirectory: context.pluginWorkDirectory)
				return .buildCommand(displayName: "Create UIColor and UIImage constants from \(base).xcassets"
									 ,executable: try context.tool(named: "SwiftXCAssetConstantsExec").path
									 ,arguments:[input.string, output.string /*, "--xcodeproject"*/]
									 ,inputFiles: [input]
									 ,outputFiles: [output])
			})
	}

}
 */

//#endif
