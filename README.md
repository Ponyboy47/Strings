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

// Easily generate a random string (of 64 characters)
print(String.uniq)
// vra10hSYFGh6Ba3y6J79oaFQv19BV4vzyUkgs542yuGS7HarbBb7FQpMzEvt4H7D

// Working with substrings is a little easier. Instead of returning character arrays or slices or anything, we just return a new String
let phone = "8323811692"
print(phone.substring(from: -4)) // 1692
print(phone.substring(to: -4)) // 832381
print(phone.substring(from: 4, to: -4)) // 381

// Validation
// Email validation
let goodEmail = "ponyboy47@gmail.com"
let badEmail = "example@badEmail"
goodEmail.validate(EmailValidator.self) // true
badEmail.validate(EmailValidator.self) // false
```
