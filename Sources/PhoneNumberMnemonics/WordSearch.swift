// WordSearch.swift
// Created for Assignment 5 of CSI 380
// Tynan Matthews & Steven Pershyn

import Foundation

// YOU FILL IN HERE
// Feel free to put in additional utility code as long as you have
// no loops, no *mutable* global variables, and no custom classes.

// Replaces each character in a phone number with an array of the
// possible letters that could be in place of that character
// For instance, 234 becomes [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]]
public func letters(for phoneNumber: String) -> [[String]] {
    let result: [[String]] = phoneNumber.map { 
        switch $0 {
	case "0":
		return ["0"] 
	case "1":
		return ["1"]  
	case "2":
		return ["A", "B", "C"]
	case "3":
		return ["D", "E", "F"] 
	case "4":
		return ["G", "H", "I"] 
	case "5":
		return ["J", "K", "L"] 
	case "6":
		return ["M", "N", "O"]
	case "7":
		return ["P", "Q", "R", "S"] 
	case "8":
		return ["T", "U", "V"] 
	case "9":
		return ["W", "X", "Y", "Z"]
	default:
		return [] 
        }  
    }
    return result
}

// Finds all of the ordered permutations of a given
// array of arrays of strings
// combining each choice in one
// array with each choice in the next array, and so on to produce strings
// For instance permuations(of: [["a", "b"], ["c"], ["d", "e"]]) will return
// ["acd", "ace" "bcd", "bce"]
// reduce, flatMap, and map
public func permutations(of arrays: [[String]]) -> [String] {
    return arrays.reduce([""]) { (last: [String], next: [String]) -> [String] in
	return next.flatMap { (nextLetter: String) -> [String] in
            return last.map { (lastLetter: String) -> String in
		return lastLetter + nextLetter
            }
	}
    }
}

// Finds all of the possible strings of characters that a phone number
// can potentially represent
// Uses letters(for:) and permutations(of:) to do this
public func possibles(for phoneNumber: String) -> [String] {
    let possibleLetters = letters(for: phoneNumber)
    let possiblePermutations = permutations(of: possibleLetters)
    return possiblePermutations
}

// Returns all of the words in a given *string* from the wordlist.txt file
// using only words in the word list of minimum length ofMinLength
public func wordsInString(_ string: String, ofMinLength length: UInt) -> [String] {
    let words = wordList(fileName: "words.txt").getWords()
    let word_list = words.filter { (word: String) -> Bool in word.length >= length }
    return word_list.filter { string.uppercased().contains($0.uppercased()) }.map { $0.uppercased() }
}

// Returns all possibles strings of characters that a phone number
// can potentially represent that contain words in words.txt
// greater than or equal to ofMinLength characters
public func possiblesWithWholeWords(ofMinLength length: UInt, for phoneNumber: String) -> [String] {
    let words = wordList(fileName: "words.txt").getWords()
    let posibilities = possibles(for: phoneNumber)
    let valid_words = words.filter { $0.length >= length } 
    let result = valid_words.map { (word: String) -> [String] in return posibilities.filter {$0.uppercased().contains(word.uppercased()) }}.filter { $0 != [] }[0].map { $0.uppercased() }
    if result.count > 0 {
	return result
    } else {
	return [""] }
}

// Returns the phone number mnemonics that have the most words present in words.txt
// within them (note that these words could be overlapping)
// For instance, if there are two mnemonics that contain three words from
// words.txt, it will return both of them, if the are no other mnemonics
// that contain more than three words
public func mostWords(for phoneNumber: String) -> [String] {
    var num = 0
    var most = [""]
    var result = [""]
    let n = possibles(for: phoneNumber).map { wordsInString($0, ofMinLength: 0) }
    n.map { if $0.count >= num { most = most.filter { Int($0) == num }; most.append(String(n.index(of: $0)!)); num = $0.count }}
    most.map { result.append(possibles(for: phoneNumber)[Int($0)!]) }
    result.removeFirst(1)
    return result
}

// Returns the phone number mnemonics with the longest words from words.txt
// If more than one word is tied for the longest, returns all of them
public func longestWords(for phoneNumber: String) -> [String] {
    var most = 0
    var big = [""]
    let words = wordList(fileName: "words.txt").getWords()
    let posibilities = possibles(for: phoneNumber)
    let result = words.map { (word: String) -> [String] in return posibilities.filter {$0.uppercased().contains(word.uppercased()) }}.filter { $0 != [] }[0].map { $0.uppercased() }
    let new_result = result.map { (word: String) -> [()] in return wordsInString(word, ofMinLength: 0).map { if $0.length > most { most = $0.length; big = [$0] } } }
    return big
}
