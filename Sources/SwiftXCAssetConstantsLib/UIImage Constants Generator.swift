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
	
	public func generateFile()->String {
		return Self.boilerPlateTop
		+ imageNames
			.map({ imageConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ Self.boilerPlateBottom
	}
	
	lazy var moduleName:String = {
		return context == .swiftPackage ? ".module" : ".designConstants"
	}()
	
	func imageConstantDeclaration(for imageName:String)->String {
		return "public static let \(imageName.swiftyStaticVariableName):UIImage = UIImage(named:\"\(imageName)\", in:\(moduleName), compatibleWith:nil)!"
	}
	
	let imageNames:[String]
	let context:Context
	
	static let boilerPlateTop = """
extension UIImage {


"""
	
	static let boilerPlateBottom = """


}


"""
	
}
