import Foundation


public class XCAssetAnalyzer {
	
	public init(urlToXCAsset:URL) {
		self.rootURL = urlToXCAsset
	}
	
	public func fileContents()->Data {
		return "import UIKit\n".data(using: .utf8)!
			+ UIColorGenerator(colorNames: colorNames).generateFile().data(using: .utf8)!
			+ UIImageGenerator(imageNames: imageNames).generateFile().data(using: .utf8)!
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
	
	private lazy var fileManager = FileManager()
	
	private let rootURL:URL
	
}
