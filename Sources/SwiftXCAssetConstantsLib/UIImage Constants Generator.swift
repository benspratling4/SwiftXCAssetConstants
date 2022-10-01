//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation

public class UIImageGenerator {
	
	public init(imageNames:[String]) {
		self.imageNames = imageNames
	}
	
	public func generateFile()->String {
		return Self.boilerPlateTop
		+ imageNames
			.map({ imageConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ Self.boilerPlateBottom
	}
	
	func imageConstantDeclaration(for imageName:String)->String {
		return "public static let \(imageName.swiftyStaticVariableName):UIImage = UIImage(named:\"\(imageName)\", in:.module, compatibleWith:nil)!"
	}
	
	let imageNames:[String]
	
	static let boilerPlateTop = """
extension UIImage {


"""
	
	static let boilerPlateBottom = """


}
"""
	
}
