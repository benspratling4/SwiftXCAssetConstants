//
//  UIColorConstantTests.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation
import XCTest
@testable import ExampleProject


class UIColorConstantTests : XCTestCase {
	
	func testColor() {
		let vc = SomeViewController(nibName: nil, bundle: nil)
		XCTAssertNotNil(vc.view.backgroundColor)
	}
	
}
