# Strings

Strings is a small set of extensions to the default String implementation in swift. It includes useful functions such as `lstrip` and `rstrip` and makes creating substrings much easier than they normally are.

---
### Installation

Include the following in your Package.swift
```swift
.Package(url: "https://github.com/Ponyboy47/Strings.git", majorVersion: 1)
```

then just import it!

---
### Usage

```swift
import Strings

// Strip extra characters from the left/right (or both)
let str = "  Hello World!  "

print(str.lstrip())
// "Hello World!   "

print(str.rstrip())
// "   Hello World!"

print(str.strip())
// "Hello World!"

// Check if a string starts or ends with a specific substring
let test = "begin.finish"

test.starts(with: "begin")
// true

test.ends(with: "finish")
// true

// Easily generate a random string (of 64 alphanumeric characters)
print(String.uniq)
// vra10hSYFGh6Ba3y6J79oaFQv19BV4vzyUkgs542yuGS7HarbBb7FQpMzEvt4H7D

// You can also create your own unique strings with your own set of characters
let charString: String = "ABCDE"
print(String.uniq(length: 10, from: charString))
// AEADBCCDAE

let charArray: [Character] = ["A", "B", "C", "D", "E"]
print(String.uniq(length: 10, from: charArray))
// AEADBCCDAE

// And if you're on iOS, tvOS, macOS, watchOS (Anything but Linux)
let charset = NSCharacterSet.alphanumeric
print(String.uniq(length: 10, from: charset))
// ru93m32mf0

// Creating substrings is so much easier now! I've created subscripts for integer ranges
// No more dealing with String.Index and having to do `str.index(str.startIndex, offsetBy: X)`
let phone = "8323811692"
print(phone[0])
// 8 <- This will be a Character and not a Substring because it is not a range
print(phone[(-4)...].string)
// 1692
print(phone[..<(-4)].string)
// 832381
print(phone[4...6].string)
// 381

// Notice the `.string` after each substring?
// That's because the substring return a Substring object which has to be cast
//   to a String before it can really be used anywhere. This is intentional behavior
//   to prevent memory leaks since Substring contains a reference to the full String
//   that it was based on. If you could just pass around a Substring everywhere then
//   the original String would never be released and you'd have a memory leak, basically.
// That's why I extended Substring to give it a `.string` attribute which creates a String object from the Substring

// There's also support for Character-based subscript ranges on Strings now.
//   **Beware though, these are potentially unsafe operations and should only be used
//   with great caution.**
print(phone["8"...].string)
// 8322811692
print(phone["2"..<"1"].string)
// 238
print(phone["1"..."9"].string)
// 1169
print(phone["a"...].string)
// nil (because it cannot find index index of a character in the range)
print(phone["2"..."8"].string)
// Will crash because it only gets the index of the first character at the
//   range boundaries and you cannot have a range with the lowerBound > upperBound

// Validation
// Email validation
let goodEmail = "ponyboy47@gmail.com"
let badEmail = "example@badEmail"
goodEmail.validate(EmailValidator.self) // true
badEmail.validate(EmailValidator.self) // false
```
