//
//  Strings+Subscript.swift
//  Strings
//
//  Created by Jacob Williams on 7/3/17.
//

import Foundation

extension String {
    /**
     Converts an Integer index to a String.Index
     - Parameter of: The Integer index to convert to a String.Index from the String
     - Returns: A String.Index representation of the Integer index
     */
    public func index(of i: Int) -> String.Index {
        guard i >= 0 else {
            return index(endIndex, offsetBy: i, limitedBy: startIndex) ?? startIndex
        }
        return index(startIndex, offsetBy: i, limitedBy: endIndex) ?? index(endIndex, offsetBy: -1)
    }

    /**
     Gets the character at the specified index in the string
     - Parameter index: The index of the character to return
     - Returns: The Character at the specified index
     */
    public subscript(index: Int) -> Character {
        return self[self.index(of: index)]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: An Integer range of the characters to include
     - Returns: The Substring of the range
     */
    public subscript(range: ClosedRange<Int>) -> Substring {
        let start = index(of: range.lowerBound)
        let end = index(of: range.upperBound)
        return self[start...end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: An Integer range of the characters to include up to, but not including, the upperBound
     - Returns: The Substring of the range
     */
    public subscript(range: Range<Int>) -> Substring {
        let start = index(of: range.lowerBound)
        let end = index(of: range.upperBound)
        return self[start..<end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: An Integer range of the characters to include from a lower bound to the end of the String
     - Returns: The Substring of the range
     */
    public subscript(range: PartialRangeFrom<Int>) -> Substring {
        let start = index(of: range.lowerBound)
        return self[start...]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: An Integer range of the characters to include from the beginning and up to, but not including, an upperBound
     - Returns: The Substring of the range
     */
    public subscript(range: PartialRangeUpTo<Int>) -> Substring {
        let end = index(of: range.upperBound)
        return self[..<end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: An Integer range of the characters to include from the beginning through an upperBound
     - Returns: The Substring of the range
     */
    public subscript(range: PartialRangeThrough<Int>) -> Substring {
        let end = index(of: range.upperBound)
        return self[...end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: A Character-based range of the characters to include
     - Returns: The Substring of the range or nil if one of the Character boundaries could not be found
     */
    public subscript(range: ClosedRange<Character>) -> Substring? {
        guard let start = index(of: range.lowerBound) else { return nil }
        guard let end = index(of: range.upperBound) else { return nil }
        return self[start...end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: A Character-based range of the characters to include up to, but not including, the upperBound
     - Returns: The Substring of the range or nil if one of the Character boundaries could not be found
     */
    public subscript(range: Range<Character>) -> Substring? {
        guard let start = index(of: range.lowerBound) else { return nil }
        guard let end = index(of: range.upperBound) else { return nil }
        return self[start..<end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: A Character-based range of the characters to include from a lower bound to the end of the String
     - Returns: The Substring of the range or nil if one of the Character boundaries could not be found
     */
    public subscript(range: PartialRangeFrom<Character>) -> Substring? {
        guard let start = index(of: range.lowerBound) else { return nil }
        return self[start...]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: A Character-based range of the characters to include from the beginning and up to, but not including, an upperBound
     - Returns: The Substring of the range or nil if one of the Character boundaries could not be found
     */
    public subscript(range: PartialRangeUpTo<Character>) -> Substring? {
        guard let end = index(of: range.upperBound) else { return nil }
        return self[..<end]
    }

    /**
     Returns a substring of the characters in the range
     - Parameter range: A Character-based range of the characters to include from the beginning through an upperBound
     - Returns: The Substring of the range or nil if one of the Character boundaries could not be found
     */
    public subscript(range: PartialRangeThrough<Character>) -> Substring? {
        guard let end = index(of: range.upperBound) else { return nil }
        return self[...end]
    }
}
