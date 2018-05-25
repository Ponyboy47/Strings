/*

	String+.swift

	Created By: Jacob Williams
	Description: Adds useful functionality to Strings
	License: MIT License

*/

import Foundation

extension String {
    /// A randomly generated, unique string of 64 alphanumeric characters (upper and lowercased letter)
    public static var uniq: String {
        let letters: [Character] = ["a","b","c","d","e","f","g","h","i","j","k",
                                    "l","m","n","o","p","q","r","s","t","u","v",
                                    "w","x","y","z","A","B","C","D","E","F","G",
                                    "H","I","J","K","L","M","N","O","P","Q","R",
                                    "S","T","U","V","W","X","Y","Z","0","1","2",
                                    "3","4","5","6","7","8","9"]
        #if os(Linux)
        let len = letters.count
        #else
        let len = UInt32(letters.count)
        #endif

        var randomString: String = ""

        for _ in 1...64 {
            #if os(Linux)
            let rand: Int = random() % len
            #else
            let rand: Int = Int(arc4random_uniform(len))
            #endif
            randomString.append(letters[rand])
        }
        return randomString
    }

    /**
     A randomly generated, unique string based on the characters of the String parameter
     - Parameters:
       - length: The size (in characters) of the random string to generate
       - from: A String containing the characters to use in the randomly generated string
     - Returns: A string
     */
    public static func uniq(length: Int, from letters: String) -> String {
        #if os(Linux)
            let len = letters.count
        #else
            let len = UInt32(letters.count)
        #endif

        var randomString: String = ""

        for _ in 1...length {
            #if os(Linux)
                let rand: Int = random() % len
            #else
                let rand: Int = Int(arc4random_uniform(len))
            #endif
            randomString.append(letters[rand])
        }
        return randomString
    }

    /**
     A randomly generated, unique string based on the characters in the Character array
     - Parameters:
     - length: The size (in characters) of the random string to generate
     - from: An array of Characters to use in the randomly generated string
     - Returns: A string
     */
    public static func uniq(length: Int, from characters: [Character]) -> String {
        #if os(Linux)
            let len = characters.count
        #else
            let len = UInt32(characters.count)
        #endif

        var randomString: String = ""

        for _ in 1...length {
            #if os(Linux)
                let rand: Int = random() % len
            #else
                let rand: Int = Int(arc4random_uniform(len))
            #endif
            randomString.append(characters[rand])
        }
        return randomString
    }

    #if !os(Linux)
    /**
     A randomly generated, unique string based on the characters in the NSCharacterSet
     - Parameters:
     - length: The size (in characters) of the random string to generate
     - from: An NSCharacterSet to use in the randomly generated string
     - Returns: A string
     */
    public static func uniq(length: Int, from charset: NSCharacterSet) -> String {
        let len = UInt32(charset.characters.count)

        var randomString: String = ""

        for _ in 1...length {
            let rand: Int = Int(arc4random_uniform(len))
            randomString.append(charset.characters[rand])
        }
        return randomString
    }
    #endif

    /// Capitalizes the first character and lowercases the rest
    public var sentenceCased: String {
        guard !isEmpty else { return String() }
        let first = String(self.first!).uppercased()
        let other = self.dropFirst().lowercased()
        return first + other
    }

    /// Capitalizes the first letter of every word and lowercases the rest
    public var wordCased: String {
        let charset = CharacterSet(charactersIn: " _")
        let words = components(separatedBy: charset)

        var capitalizedString = ""
        let spaceChar: Character = " "

        for word in words where !word.isEmpty {
            capitalizedString += word.sentenceCased
            if word != words.last! {
                capitalizedString.append(spaceChar)
            }
        }
        return capitalizedString
    }

    @available(*, unavailable, message: "Use the Swift String builtin 'hasSuffix' instead.")
    /**
     Checks if a string ends with a specified string
     - Parameter string: The string to test against
     - Returns: A Boolean indicating whether or not the string ends in the specified parameter string
     */
    public func ends(with string: String) -> Bool {
        return hasSuffix(string)
    }

    @available(*, unavailable, message: "Use the Swift String builtin 'hasPrefix' instead.")
    /**
     Checks if a string starts with a specified string
     - Parameter string: The string to test against
     - Returns: A Boolean indicating whether or not the string starts in the specified parameter string
     */
    public func starts(with string: String) -> Bool {
        return hasPrefix(string)
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
        for char in self {
            if !trim.contains(char.unicodeScalar) {
                break
            }
            toTrim += 1
        }
        return String(self[self.index(of: toTrim)...])
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
        for char in reversed() {
            if !trim.contains(char.unicodeScalar) {
                break
            }
            toTrim += 1
        }
        toTrim = count - toTrim
        return String(self[..<self.index(of: toTrim)])
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

    #if os(Linux)
    /// Returns a C compatible string, this var is only needed for Linux since String already conforms to CVarArg on the Apple platforms
    public var cString: CVarArg? {
        return NSString(string: self).utf8String
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

#if !os(Linux)
extension NSCharacterSet {
    var characters: [Character] {
        var chars = [Character]()
        for plane: UInt8 in 0...16 {
            if self.hasMemberInPlane(plane) {
                let p0 = UInt32(plane) << 16
                let p1 = (UInt32(plane) + 1) << 16
                for c: UTF32Char in p0..<p1 {
                    if self.longCharacterIsMember(c) {
                        var c1 = c.littleEndian
                        let s = String.init(bytesNoCopy: &c1, length: c.bitWidth, encoding: .utf32LittleEndian, freeWhenDone: true)!
                        chars.append(Character(s))
                    }
                }
            }
        }
        return chars
    }
}
#endif
