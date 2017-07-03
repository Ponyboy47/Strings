import XCTest
@testable import Strings

class StringsTests: XCTestCase {
    let testStr: String = "tHiS iS a TeSt StRiNg!"

    func testUniq() {
        for _ in 1...10 {
            let uniq1 = String.uniq
            let uniq2 = String.uniq
            XCTAssertNotEqual(uniq1, uniq2)
        }
    }

    func testUniqCount() {
        XCTAssertEqual(String.uniq.count, 64)
    }

    func testSentenceCase() {
        XCTAssertEqual(testStr.sentenceCased, "This is a test string!")
    }

    func testWordCase() {
        XCTAssertEqual(testStr.wordCased, "This Is A Test String!")
    }

    func testSubstringFullRange() {
        let subStr: Substring = testStr[...]
        XCTAssertEqual(subStr.string, testStr)
    }

    func testSubstringFromRange() {
        let subStr: Substring = testStr[17...]
        XCTAssertEqual(subStr.string, "RiNg!")
    }

    func testSubstringUpToRange() {
        let subStr: Substring = testStr[..<5]
        XCTAssertEqual(subStr.string, "tHiS ")
    }

    func testSubstringIncludingRange() {
        let subStr: Substring = testStr[...5]
        XCTAssertEqual(subStr.string, "tHiS i")
    }

    func testSubstringRangeUpTo() {
        let subStr: Substring = testStr[5..<17]
        XCTAssertEqual(subStr.string, "iS a TeSt St")
    }

    func testSubstringRangeIncluding() {
        let subStr: Substring = testStr[5...17]
        XCTAssertEqual(subStr.string, "iS a TeSt StR")
    }

    func testSubstringNegativeFromRange() {
        let subStr: Substring = testStr[(-5)...]
        XCTAssertEqual(subStr.string, "RiNg!")
    }

    func testSubstringUpToNegativeRange() {
        let subStr: Substring = testStr[..<(-5)]
        XCTAssertEqual(subStr.string, "tHiS iS a TeSt St")
    }

    func testSubstringIncludingNegativeRange() {
        let subStr: Substring = testStr[...(-5)]
        XCTAssertEqual(subStr.string, "tHiS iS a TeSt StR")
    }

    func testSubstringRangeUpToNegative() {
        let subStr: Substring = testStr[(-17)..<(-5)]
        XCTAssertEqual(subStr.string, "iS a TeSt St")
    }

    func testSubstringRangeIncludingNegative() {
        let subStr: Substring = testStr[(-17)...(-5)]
        XCTAssertEqual(subStr.string, "iS a TeSt StR")
    }

    func testSubstringFromExceedingRange() {
        let subStr8: Substring = testStr[100...]
        XCTAssertEqual(subStr8.string, "!")
    }

    func testSubstringUpToSameRange() {
        let subStr9: Substring = testStr[5..<5]
        XCTAssertEqual(subStr9.string, "")
    }

    func testSubstringIncludingSameRange() {
        let subStr9: Substring = testStr[5...5]
        XCTAssertEqual(subStr9.string, "i")
    }

    func testSubstringUpToExceedingRange() {
        let subStr11: Substring = testStr[..<100]
        XCTAssertEqual(subStr11.string, testStr.dropLast().string)
    }

    func testSubstringIncludingExceedingRange() {
        let subStr11: Substring = testStr[...100]
        XCTAssertEqual(subStr11.string, testStr)
    }

    func testSubstringFromCharacterRange() {
        let subStr: Substring? = testStr["R"...]
        XCTAssertNotNil(subStr)
        XCTAssertEqual(subStr!.string, "RiNg!")
    }

    func testSubstringUpToCharacterRange() {
        let subStr: Substring? = testStr[..<" "]
        XCTAssertNotNil(subStr)
        XCTAssertEqual(subStr!.string, "tHiS")
    }

    func testSubstringIncludingCharacterRange() {
        let subStr: Substring? = testStr[..." "]
        XCTAssertNotNil(subStr)
        XCTAssertEqual(subStr!.string, "tHiS ")
    }

    func testSubstringCharacterRangeUpTo() {
        let subStr: Substring? = testStr[" "..<"R"]
        XCTAssertNotNil(subStr)
        XCTAssertEqual(subStr!.string, " iS a TeSt St")
    }

    func testSubstringCharacterRangeIncluding() {
        let subStr: Substring? = testStr[" "..."R"]
        XCTAssertNotNil(subStr)
        XCTAssertEqual(subStr!.string, " iS a TeSt StR")
    }

    func testSubstringCharacterRangeMissingChar() {
        let subStr: Substring? = testStr[" "..."Z"]
        XCTAssertNil(subStr)
    }

    func testLStrip1() {
        let testStripStr1 = "  \(testStr)"
        XCTAssertEqual(testStripStr1.lstrip(), testStr)
    }

    func testLStrip2() {
        let testStripStr2 = "12321\(testStr)"
        XCTAssertEqual(testStripStr2.lstrip("123"), testStr)
        XCTAssertNotEqual(testStripStr2.lstrip(), testStr)
    }

    func testLStrip3() {
        let testStripStr3 = " \(testStr) "
        XCTAssertEqual(testStripStr3.lstrip(), "\(testStr) ")
    }

    func testRStrip1() {
        let testStripStr1 = "\(testStr)  ".rstrip()
        XCTAssertEqual(testStripStr1, testStr)
    }

    func testRStrip2() {
        let testStripStr2 = "\(testStr)12321".rstrip("123")
        XCTAssertEqual(testStripStr2, testStr)
    }

    func testRStrip3() {
        let testStripStr3 = " \(testStr) ".rstrip()
        XCTAssertEqual(testStripStr3, " \(testStr)")
    }

    func testStrip1() {
        let testStripStr1 = "\(testStr)  "
        XCTAssertEqual(testStripStr1.strip(), testStr)
    }

    func testStrip2() {
        let testStripStr2 = "12321\(testStr)12321"
        XCTAssertEqual(testStripStr2.strip("123"), testStr)
    }

    func testStrip3() {
        let testStripStr3 = " \(testStr)"
        XCTAssertEqual(testStripStr3.strip(), testStr)
    }
}

#if os(Linux)
extension StringsTests {
    static var allTests = [
        ("testUniq", testUniq),
        ("testUniqCount", testUniqCount),
        ("testSentenceCase", testSentenceCase),
        ("testWordCase", testWordCase),
        ("testSubstringFullRange", testSubstringFullRange),
        ("testSubstringFromRange", testSubstringFromRange),
        ("testSubstringUpToRange", testSubstringUpToRange),
        ("testSubstringIncludingRange", testSubstringIncludingRange),
        ("testSubstringRangeUpTo", testSubstringRangeUpTo),
        ("testSubstringRangeIncluding", testSubstringRangeIncluding),
        ("testSubstringNegativeFromRange", testSubstringNegativeFromRange),
        ("testSubstringRangeUpToNegative", testSubstringRangeUpToNegative),
        ("testSubstringRangeIncludingNegative", testSubstringRangeIncludingNegative),
        ("testSubstringFromExceedingRange", testSubstringFromExceedingRange),
        ("testSubstringUpToSameRange", testSubstringUpToSameRange),
        ("testSubstringIncludingSameRange", testSubstringIncludingSameRange),
        ("testSubstringUpToExceedingRange", testSubstringUpToExceedingRange),
        ("testSubstringIncludingExceedingRange", testSubstringIncludingExceedingRange),
        ("testSubstringFromCharacterRange", testSubstringFromCharacterRange),
        ("testSubstringUpToCharacterRange", testSubstringUpToCharacterRange),
        ("testSubstringIncludingCharacterRange", testSubstringIncludingCharacterRange),
        ("testSubstringCharacterRangeUpTo", testSubstringCharacterRangeUpTo),
        ("testSubstringCharacterRangeIncluding", testSubstringCharacterRangeIncluding),
        ("testSubstringCharacterRangeMissingChar", testSubstringCharacterRangeMissingChar),
        ("testLStrip1", testLStrip1),
        ("testLStrip2", testLStrip2),
        ("testLStrip3", testLStrip3),
        ("testRStrip1", testRStrip1),
        ("testRStrip2", testRStrip2),
        ("testRStrip3", testRStrip3),
        ("testStrip1", testStrip1),
        ("testStrip2", testStrip2),
        ("testStrip3", testStrip3)
    ]
}
#endif
