// WordList.swift
// Created for Assignment 5 of CSI 380

import Foundation

// YOU FILL IN HERE
// You'll want to create a mechanism here for loading and querying
// words.txt. It's up to you how you do this. You may consider a struct.
// Tynan Matthews & Steven Pershyn

public struct wordList {
	var words = [""]

	public init(fileName url: String) {
		let fileURL = URL(fileURLWithPath: url)
		var text = String()

		do { 
			text = try String(contentsOf: fileURL, encoding: .utf8)
			self.words = text.components(separatedBy: "\n")
		} 
		catch { 
			print("Error reading file") 
		}
	}

	public func getWords() -> [String] {
		return self.words
	}
}
