//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation



public class UIColorGenerator {
	
	public init(colorNames:[String], context:Context) {
		self.colorNames = colorNames
		self.context = context
	}
	
	public func generateFile()->String {
		return Self.boilerPlateTop
		+ colorNames
			.map({ colorConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ Self.boilerPlateBottom
	}
	
	lazy var moduleName:String = {
		return context == .swiftPackage ? ".module" : ".designConstants"
	}()
	
	func colorConstantDeclaration(for colorName:String)->String {
		return "public static let \(colorName.swiftyStaticVariableName):UIColor = UIColor(named:\"\(colorName)\", in:\(moduleName), compatibleWith:nil)!"
	}
	
	let colorNames:[String]
	let context:Context
	
	static let boilerPlateTop = """
extension UIColor {


"""
	
	static let boilerPlateBottom = """


}

"""
	
}

