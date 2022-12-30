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
			.filter({ $0.pathExtension == colorPathExtension })
			.map({ $0.deletingPathExtension() })
			.map({ $0.lastPathComponent })
	}()
	
	public lazy var imageNames:[String] = {
		return allSubUrls
			.filter({ $0.pathExtension == imagePathExtension })
			.map({ $0.deletingPathExtension() })
			.map({ $0.lastPathComponent })
	}()
	
	lazy var allSubUrls:[URL] = {
		recursiveAllSubUrls(in:rootURL)
	}()
	
	
	private func recursiveAllSubUrls(in url:URL)->[URL] {
		guard let allSubDirs = try? fileManager
			.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
		 else {
			return []
		}
		let areResourceSubDirs = allSubDirs.filter({ $0.pathExtension == colorPathExtension || $0.pathExtension == imagePathExtension })
		let areNotResourceSubDirs = allSubDirs.filter({ !areResourceSubDirs.contains($0) })
		let additionalSubUrls = areNotResourceSubDirs
			.filter({ $0.hasDirectoryPath })
			.map({ recursiveAllSubUrls(in: $0) })
			.reduce(areResourceSubDirs, +)
		return additionalSubUrls
	}
	
	
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


fileprivate let colorPathExtension:String = "colorset"
fileprivate let imagePathExtension:String = "imageset"
