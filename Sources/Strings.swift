/*

	String+.swift

	Created By: Jacob Williams
	Description: Adds useful functionality to Strings
	License: MIT License

*/

import Foundation

extension String {
    /// A randomly generated, unique string of 64 characters
    public static var uniq: String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        #if os(Linux)
        let len = letters.length
        #else
        let len = UInt32(letters.length)
        #endif

        var randomString = ""

        for _ in 1...64 {
            #if os(Linux)
            // TODO: linux random doesn't work correctly (but I'm not using it so...oh well)
			srandom(UInt32(time(nil)))
            let rand: Int = random() % len
            #else
            let rand: Int = Int(arc4random_uniform(len))
            #endif
            let nextChar = letters.character(at: rand)
            randomString += String(nextChar)
        }
        return randomString
    }

    /// Capitalizes the first character and lowercases the rest
    public var sentenceCased: String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }

    /// Capitalizes the first letter of every word and lowercases the rest
    public var wordCased: String {
        let charset = CharacterSet(charactersIn: " _")
        let words = self.components(separatedBy: charset)

        var capitalizedString = ""

        for word in words {
            capitalizedString += word.sentenceCased + " "
        }
        return capitalizedString.dropLast()
    }

    /**
     Checks if a string ends with a specified string
     - Parameter string: The string to test against
     - Returns: A Boolean indicating whether or not the string ends in the specified parameter string
    */  
    public func ends(with string: String) -> Bool {
        if string.characters.count > characters.count {
            return false
        }
        let ending = substring(from: characters.count - string.characters.count, to: characters.count)
        return ending == string
    }

    /**
     Checks if a string starts with a specified string
     - Parameter string: The string to test against
     - Returns: A Boolean indicating whether or not the string starts in the specified parameter string
     */ 
    public func starts(with string: String) -> Bool {
        if string.characters.count > characters.count {
            return false
        }
        let beginning = substring(to: string.characters.count)
        return beginning == string
    }

	public func dropFirst() -> String {
        return String(characters.dropFirst())
    }

	public func dropLast() -> String {
        return String(characters.dropLast())
    }

    public func substring(from: Int = 0, to: Int = -1) -> String {
        let to = to == -1 ? characters.count : to
        var startIdx: String.Index
        var endIdx: String.Index
        if from == 0 {
            startIdx = startIndex
        } else {
            startIdx = index(startIndex, offsetBy: from)
        }
        if to == characters.count {
            endIdx = endIndex
        } else {
            endIdx = index(startIndex, offsetBy: to)
        }
        let range = startIdx..<endIdx
        return substring(with: range)
    }

    public func lstrip(_ charset: CharacterSet = .whitespaces) -> String {
        var toTrim = 0
        // Breaks once we hit the first non-trimmable character
        for char in self.characters {
            if !charset.contains(char.unicodeScalar) {
                break
            }
            toTrim += 1
        }
        return self.substring(from: toTrim)
    }

    public func rstrip(_ charset: CharacterSet = .whitespaces) -> String {
        var toTrim = 0
        // Breaks once we hit the first non-trimmable character
        for char in self.characters.reversed() {
            if !charset.contains(char.unicodeScalar) {
                break
            }
            toTrim += 1
        }
        return self.substring(to: toTrim)
    }

    public func strip(_ charset: CharacterSet = .whitespaces) -> String {
        return self.trimmingCharacters(in: charset)
    }
}

extension Character
{
    public var unicodeScalar: UnicodeScalar {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars

        return UnicodeScalar(scalars[scalars.startIndex].value)!
    }
}
