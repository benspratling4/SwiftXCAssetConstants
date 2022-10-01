//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation



public class UIColorGenerator {
	
	public init(colorNames:[String]) {
		self.colorNames = colorNames
	}
	
	public func generateFile()->String {
		return Self.boilerPlateTop
		+ colorNames
			.map({ colorConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ Self.boilerPlateBottom
	}
	
	func colorConstantDeclaration(for colorName:String)->String {
		return "public static let \(colorName.swiftyStaticVariableName):UIColor = UIColor(named:\"\(colorName)\", in:.module, compatibleWith:nil)!"
	}
	
	let colorNames:[String]
	
	static let boilerPlateTop = """
extension UIColor {


"""
	
	static let boilerPlateBottom = """


}

"""
	
}

