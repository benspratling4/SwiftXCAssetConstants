import Foundation


public class XCAssetAnalyzer {
	
	public init(urlToXCAsset:URL, context:Context) {
		self.rootURL = urlToXCAsset
		self.context = context
	}
	
	public func fileContents()->Data {
		return (topBoilerPlate()
			+ UIColorGenerator(colorNames: colorNames, context: context).generateUIKitFile()
			+ UIImageGenerator(imageNames: imageNames, context: context).generateUIKitFile()
			+ bottomBoilerPlate()
			+ "\n\n#if canImport(SwiftUI)\nimport SwiftUI\n\n"
				+ UIColorGenerator(colorNames: colorNames, context: context).generateSwiftUIFile()
				+ UIImageGenerator(imageNames: imageNames, context: context).generateSwiftUIFile()
				+ "\n#endif\n"
				
		).data(using: .utf8)!
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
	
	func topBoilerPlate()->String {
		"#if canImport(UIKit)\nimport UIKit\n"
	}
	
	func bottomBoilerPlate()->String {
		switch context {
		case .swiftPackage:
			return "\n\n#endif\n"
			
		case .xcodeProject:
			return ( "#" + "endif" +  """

extension Bundle {
	fileprivate static let designConstants:Bundle = Bundle(for:DesignConstantsAnchor.self)
}
fileprivate class DesignConstantsAnchor { }

""")
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
