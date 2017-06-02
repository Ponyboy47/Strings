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
        let letters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
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
            randomString += "\(nextChar)"
        }
        return randomString
    }

    /// The number of characters in the string
    public var length: Int {
        return characters.count
    }

    /// Capitalizes the first character and lowercases the rest
    public var sentenceCased: String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst()).lowercased()
        return first + other
    }

    /// Capitalizes the first letter of every word and lowercases the rest
    public var wordCased: String {
        let charset = CharacterSet(charactersIn: " _")
        let words = components(separatedBy: charset)

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

    /// Removes the first character from the string
	public func dropFirst() -> String {
        guard characters.count > 0 else { return self }
        return String(characters.dropFirst())
    }

    /// Removes the last character from the string
	public func dropLast() -> String {
        guard characters.count > 0 else { return self }
        return String(characters.dropLast())
    }

    /**
     Gets the substring from one integer index to another
     - Parameter from: The index of the character to start the substring. Default is 0
     - Parameter to: The final index of the character to end the substring. Default is -1
     - Returns: A string of the substring from the starting index to the ending one
     */
    public func substring(from: Int = 0, to: Int = -1) -> String {
        var from = from <= -1 ? characters.count + from : from
        var to = to <= -1 ? characters.count + to + 1 : to
        var startIdx: String.Index
        var endIdx: String.Index
        if from >= characters.count {
            from = characters.count
            startIdx = endIndex
        } else if from == 0 {
            startIdx = startIndex
        } else {
            startIdx = index(startIndex, offsetBy: from)
        }
        if to >= characters.count {
            to = characters.count
            endIdx = endIndex
        } else if to == 0 {
            endIdx = startIndex
        } else {
            endIdx = index(startIndex, offsetBy: to)
        }
        guard startIdx != endIdx else { return "" }
        var range: Range<String.Index>
        if from < to {
            range = startIdx..<endIdx
        } else {
            range = endIdx..<startIdx
        }
        return substring(with: range)
    }

    /**
     Strips characters from the left side of the String
     - Parameter in charset: A `CharacterSet` to remove from the left side of the string
     - Returns: A String with the left side having been trimmed
     */
    public func lstrip(in charset: CharacterSet?) -> String {
        var trim: CharacterSet
        if charset != nil {
            trim = charset!
        } else {
            trim = .whitespaces
        }
        var toTrim = 0
        // Breaks once we hit the first non-trimmable character
        for char in characters {
            if !trim.contains(char.unicodeScalar) {
                break
            }
            toTrim += 1
        }
        return substring(from: toTrim)
    }

    /**
     Strips characters from the left side of the String
     - Parameter charsin: A String containing all the characters that should be removed from the left side of the string
     - Returns: A String with the left side having been trimmed
     */
    public func lstrip(_ charsin: String? = nil) -> String {
        if let str = charsin {
            return lstrip(in: CharacterSet(charactersIn: str))
        }
        return lstrip(in: nil)
    }

    /**
     Strips characters from the right side of the String
     - Parameter in charset: A `CharacterSet` to remove from the right side of the string
     - Returns: A String with the right side having been trimmed
     */
    public func rstrip(in charset: CharacterSet?) -> String {
        var trim: CharacterSet
        if charset != nil {
            trim = charset!
        } else {
            trim = .whitespaces
        }
        var toTrim = 0
        // Breaks once we hit the first non-trimmable character
        for char in characters.reversed() {
            if !trim.contains(char.unicodeScalar) {
                break
            }
            toTrim += 1
        }
        toTrim = characters.count - toTrim
        return substring(to: toTrim)
    }

    /**
     Strips characters from the right side of the String
     - Parameter charsin: A String containing all the characters that should be removed from the right side of the string
     - Returns: A String with the right side having been trimmed
     */
    public func rstrip(_ charsin: String? = nil) -> String {
        if let str = charsin {
            return rstrip(in: CharacterSet(charactersIn: str))
        }
        return rstrip(in: nil)
    }

    /**
     Strips characters from both sides of the String
     - Parameter in charset: A `CharacterSet` to remove from the outter sides of the string
     - Returns: A String with both sides having been trimmed
     */
    public func strip(in charset: CharacterSet?) -> String {
        var trim: CharacterSet
        if charset != nil {
            trim = charset!
        } else {
            trim = .whitespaces
        }
        return trimmingCharacters(in: trim)
    }

    /**
     Strips characters from both sides of the String
     - Parameter charsin: A String containing all the characters that should be removed from the outter sides of the string
     - Returns: A String with both sides having been trimmed
     */
    public func strip(_ charsin: String? = nil) -> String {
        if let str = charsin {
            return strip(in: CharacterSet(charactersIn: str))
        }
        return strip(in: nil)
    }

    /**
     Gets the character at the specified index in the string
     - Parameter at index: The index of the character to return
     - Returns: The Character at the specified index
     */
    public func character(at index: Int) -> Character {
        var index = index
        if index > length {
            index = length
        }
        return characters[characters.index(characters.startIndex, offsetBy: index)]
    }

    #if os(Linux)
    /// Returns a C compatible string, this var is only needed for Linux since String already conforms to CVarArg on the Apple platforms
    public var cString: CVarArg? {
        return (self as? NSString)?.utf8String
    }
    #endif
}

extension Character {
    /// The UnicodeScalar value of the character
    public var unicodeScalar: UnicodeScalar {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars

        return UnicodeScalar(scalars[scalars.startIndex].value)!
    }
}
