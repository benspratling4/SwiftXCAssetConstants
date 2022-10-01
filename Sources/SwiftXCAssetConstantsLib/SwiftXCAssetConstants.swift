import Foundation


public class XCAssetAnalyzer {
	
	public init(urlToXCAsset:URL, context:Context) {
		self.rootURL = urlToXCAsset
		self.context = context
	}
	
	public func fileContents()->Data {
		return topBoilerPlate()
			+ UIColorGenerator(colorNames: colorNames, context: context).generateFile().data(using: .utf8)!
			+ UIImageGenerator(imageNames: imageNames, context: context).generateFile().data(using: .utf8)!
			+ bottomBoilerPlate()
		
	}
	
	public lazy var colorNames:[String] = {
		return allSubUrls
			.filter({ $0.pathExtension == "colorset" })
			.map({ $0.deletingPathExtension() })
			.map({ $0.lastPathComponent })
	}()
	
	public lazy var imageNames:[String] = {
		return allSubUrls
			.filter({ $0.pathExtension == "imageset" })
			.map({ $0.deletingPathExtension() })
			.map({ $0.lastPathComponent })
	}()
	
	lazy var allSubUrls:[URL] = {
		return (
			try? fileManager
			.contentsOfDirectory(at: rootURL, includingPropertiesForKeys: nil, options: [])
			) ?? []
	}()
	
	func topBoilerPlate()->Data {
		"import UIKit\n".data(using: .utf8)!
	}
	
	func bottomBoilerPlate()->Data {
		switch context {
		case .swiftPackage:
			return "\n\n".data(using: .utf8)!
			
		case .xcodeProject:
			return """
extension Bundle {
	fileprivate static let designConstants:Bundle = Bundle(for:DesignConstantsAnchor.self)
}
fileprivate class DesignConstantsAnchor { }

""".data(using: .utf8)!
		}
		
		
	}
	
	
	private var context:Context
	
	private lazy var fileManager = FileManager()
	
	private let rootURL:URL
	
}

public enum Context {
	case swiftPackage
	case xcodeProject
}
