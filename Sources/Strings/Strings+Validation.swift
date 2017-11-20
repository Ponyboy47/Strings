import Foundation

public protocol Validator {
    static func validate(_ value: Validatable) -> Bool
}

public struct EmailValidator: Validator {
    public static func validate(_ value: Validatable) -> Bool {
        guard let str = value as? String else { return false }
        let emailRegex: String = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        #if os(Linux)
        // This _shouldn't_ ever fail
        guard let cRegex = emailRegex.cString else { return false }
        return NSPredicate(format: "SELF MATCHES %@", cRegex).evaluate(with: str)
        #else
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
        #endif
    }
}

public struct AlphaValidator: Validator {
    public static func validate(_ value: Validatable) -> Bool {
        guard value is String || value is Character else { return false }
		let charset = CharacterSet.letters
		if value is String {
			let str = value as! String
            for char in str {
                if !charset.contains(char.unicodeScalar) {
                    return false
                }
            }
        } else if !charset.contains((value as! Character).unicodeScalar) {
            return false
        }
        return true
    }
}

public struct AlphaNumericValidator: Validator {
    public static func validate(_ value: Validatable) -> Bool {
        guard value is String || value is Character else { return false }
		let charset = CharacterSet.alphanumerics
		if value is String {
			let str = value as! String
            for char in str {
                if !charset.contains(char.unicodeScalar) {
                    return false
                }
            }
        } else if !charset.contains((value as! Character).unicodeScalar) {
            return false
        }
        return true
    }
}

public struct NumericValidator: Validator {
    public static func validate(_ value: Validatable) -> Bool {
        return NSPredicate(format: "SELF MATCHES [0-9.,]+").evaluate(with: "\(value)")
    }
}

public protocol Validatable {
    func validate(_ validator: Validator.Type) -> Bool
}

extension String: Validatable {
    public func validate(_ validator: Validator.Type) -> Bool {
        return validator.validate(self)
    }
}

extension Character: Validatable {
    public func validate(_ validator: Validator.Type) -> Bool {
        return validator.validate(self)
    }
}
