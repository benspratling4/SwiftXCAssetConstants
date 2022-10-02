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
	
	public func generateUIKitFile()->String {
		return Self.boilerPlateTop
		+ colorNames
			.map({ uiColorConstantDeclaration(for:$0) })
			.joined(separator: "\n")
		+ Self.boilerPlateBottom
	}
	
	
	public func generateSwiftUIFile()->String {
		return "extension Color {\n"
			+ colorNames
				.map({ swiftUIColorConstantDeclaration(for:$0) })
				.joined(separator: "\n")
			+ "\n}\n"
	}
	
	
	lazy var moduleName:String = {
		return context == .swiftPackage ? ".module" : ".designConstants"
	}()
	
	func uiColorConstantDeclaration(for colorName:String)->String {
		return "public static let \(colorName.swiftyStaticVariableName):UIColor = UIColor(named:\"\(colorName)\", in:\(moduleName), compatibleWith:nil)!"
	}
	
	
	func swiftUIColorConstantDeclaration(for colorName:String)->String {
		return "public static let \(colorName.swiftyStaticVariableName):Color = Color(\"\(colorName)\", bundle:\(moduleName))"
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

