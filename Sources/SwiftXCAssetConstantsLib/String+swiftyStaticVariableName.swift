//
//  File.swift
//  
//
//  Created by Benjamin Spratling on 10/1/22.
//

import Foundation

extension String {
	var swiftyStaticVariableName:String {
		//quick cheap implementation
		return self.replacingCharacters(from: .alphanumerics.inverted, with: "_")
	}
}

//copied from https://github.com/benspratling4/SwiftPatterns/blob/master/Sources/SwiftPatterns/String%2BCharacterSet%2Breplacements.swift
extension String {
	
	///characters in the given set are replaced with the given string
	mutating func replaceCharacters(from set:CharacterSet, with string:String) {
		var targetIndex = endIndex
		while targetIndex > startIndex {
			guard let range = rangeOfCharacter(from: set, options: [.backwards], range: startIndex..<targetIndex) else { break }
			replaceSubrange(range, with: string)
			targetIndex = range.lowerBound
		}
	}
	
	///same as above, but can be used on let
	func replacingCharacters(from set:CharacterSet, with string:String)->String {
		var newString = self
		newString.replaceCharacters(from: set, with: string)
		return newString
	}
	
	///removes characters in self that are in the set with
	mutating func deleteCharacters(from set:CharacterSet) {
		self.replaceCharacters(from: set, with: "")
	}
	
	///returns a string that is self, but with any characters in the given set removed
	func deletingCharacters(from set:CharacterSet)->String {
		var newString = self
		newString.deleteCharacters(from: set)
		return newString
	}
	
}
