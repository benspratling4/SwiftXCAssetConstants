//
//  UIImageConstantTests.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation
import XCTest
@testable import ExampleProject


class UIImageConstantTests : XCTestCase {
	
	func testImage() {
		let vc = SomeViewController(nibName: nil, bundle: nil)
		let imageViews:[UIImageView] = vc
			.view
			.subviews
			.compactMap({ $0 as? UIImageView })
			.filter({ $0.image != nil })
		XCTAssertNotEqual(imageViews.count, 0)
	}
	
}
