//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation
import SwiftXCAssetConstantsLib

let arguments = ProcessInfo.processInfo.arguments
guard arguments.count >= 3 else {
	fatalError("arguments.count = \(arguments.count), should be at least 3")
}

let inputFilePath = arguments[1]
let outputFilePath = arguments[2]


try XCAssetAnalyzer(urlToXCAsset: URL(fileURLWithPath: inputFilePath)).fileContents().write(to: URL(fileURLWithPath: outputFilePath))

