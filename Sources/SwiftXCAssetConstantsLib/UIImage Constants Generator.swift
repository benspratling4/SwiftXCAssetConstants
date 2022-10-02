//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation

public class UIImageGenerator {
	
	public init(imageNames:[String], context:Context) {
		self.imageNames = imageNames
		self.context = context
	}
	
	public func generateUIKitFile()->String {
		return "extension UIImage {\n"
		+ imageNames
			.map({ imageConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ "\n}\n"
	}
	
	public func generateSwiftUIFile()->String {
		return "extension Image {\n"
		+ imageNames
			.map({ imageSwiftUIConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ "\n}\n"
	}
	
	lazy var moduleName:String = {
		return context == .swiftPackage ? ".module" : ".designConstants"
	}()
	
	func imageConstantDeclaration(for imageName:String)->String {
		return "public static let \(imageName.swiftyStaticVariableName):UIImage = UIImage(named:\"\(imageName)\", in:\(moduleName), compatibleWith:nil)!"
	}
	
	
	func imageSwiftUIConstantDeclaration(for imageName:String)->String {
		return "public static let \(imageName.swiftyStaticVariableName):Image = Image(\"\(imageName)\", bundle:\(moduleName))"
	}
	
	let imageNames:[String]
	let context:Context
	
	
}
