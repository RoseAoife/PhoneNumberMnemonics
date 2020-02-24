// WordList.swift
// Created for Assignment 5 of CSI 380

import Foundation

// YOU FILL IN HERE
// You'll want to create a mechanism here for loading and querying
// words.txt. It's up to you how you do this. You may consider a struct.

public struct wordList {
	var text = String()

	public init(fileName url: String) {
		let fileURL = URL(fileURLWithPath: url)

		do { 
			text = try String(contentsOf: fileURL, encoding: .utf8)
			print(text)
		} 
		catch { 
			print("Error reading file") 
		}
	}
}
