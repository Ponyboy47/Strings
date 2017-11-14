//
//  Substring.swift
//  Strings
//
//  Created by Jacob Williams on 7/3/17.
//

extension Substring {
    /**
     The String representation of self

     This creates a new String object to prevent retaining references to self's parent String representation
     */
    public var string: String {
        return String(self)
    }
}
