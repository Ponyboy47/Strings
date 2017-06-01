import XCTest
@testable import Strings

class StringsTests: XCTestCase {
    let testStr = "tHiS iS a TeSt StRiNg!"

    func testUniq() {
        let uniq1 = String.uniq
        let uniq2 = String.uniq
        XCTAssertNotEqual(uniq1, uniq2)
    }

    func testUniqCount() {
        XCTAssertEqual(String.uniq.length, 64)
    }

    func testLength() {
        XCTAssertEqual(testStr.length, testStr.characters.count)
    }

    func testSentenceCase() {
        XCTAssertEqual(testStr.sentenceCased, "This is a test string!")
    }

    func testWordCased() {
        XCTAssertEqual(testStr.wordCased, "This Is A Test String!")
    }

    func testEndsWith1() {
        XCTAssertTrue(testStr.ends(with: "StRiNg!"))
    }

    func testEndsWith2() {
        XCTAssertFalse(testStr.ends(with: "tHiS"))
    }

    func testStartsWith1() {
        XCTAssertTrue(testStr.starts(with: "tHiS"))
    }

    func testStartsWith2() {
        XCTAssertFalse(testStr.starts(with: "StRiNg!"))
    }

    func testDropFirst() {
        XCTAssertEqual(testStr.dropFirst(), "HiS iS a TeSt StRiNg!")
    }

    func testDropLast() {
        XCTAssertEqual(testStr.dropLast(), "tHiS iS a TeSt StRiNg")
    }

    func testSubstring1() {
        let subStr1 = testStr.substring()
        XCTAssertEqual(subStr1, testStr)
    }

    func testSubstring2() {
        let subStr2 = testStr.substring(from: 17)
        XCTAssertEqual(subStr2, "RiNg!")
    }

    func testSubstring3() {
        let subStr3 = testStr.substring(to: 5)
        XCTAssertEqual(subStr3, "tHiS ")
    }

    func testSubstring4() {
        let subStr4 = testStr.substring(from: 5, to: 17)
        XCTAssertEqual(subStr4, "iS a TeSt St")
    }

    func testSubstring5() {
        let subStr5 = testStr.substring(from: -5)
        XCTAssertEqual(subStr5, "RiNg!")
    }

    func testSubstring6() {
        let subStr6 = testStr.substring(to: -5)
        XCTAssertEqual(subStr6, "tHiS iS a TeSt StR")
    }

    func testSubstring7() {
        let subStr7 = testStr.substring(from: 17, to: 5)
        XCTAssertEqual(subStr7, "iS a TeSt St")
    }

    func testSubstring8() {
        let subStr8 = testStr.substring(from: 100)
        XCTAssertEqual(subStr8, "")
    }

    func testSubstring9() {
        let subStr9 = testStr.substring(from: 5, to: 5)
        XCTAssertEqual(subStr9, "")
    }

    func testSubstring10() {
        let subStr10 = testStr.substring(from: -17, to: -5)
        XCTAssertEqual(subStr10, "iS a TeSt StR")
    }

    func testSubstring11() {
        let subStr11 = testStr.substring(to: 1000)
        XCTAssertEqual(subStr11, testStr)
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
extension StringTests {
    static var allTests = [
        ("testUniq", testUniq),
        ("testUniqCount", testUniqCount),
        ("testLength", testLength),
        ("testSentenceCase", testSentenceCase),
        ("testWordCase", testWordCase),
        ("testEndsWith1", testEndsWith1),
        ("testEndsWith2", testEndsWith2),
        ("testStartsWith1", testStartsWith1),
        ("testStartsWith2", testStartsWith2),
        ("testDropFirst", testDropFirst),
        ("testDropLast", testDropLast),
        ("testSubstring1", testSubstring1),
        ("testSubstring2", testSubstring2),
        ("testSubstring3", testSubstring3),
        ("testSubstring4", testSubstring4),
        ("testSubstring5", testSubstring5),
        ("testSubstring6", testSubstring6),
        ("testSubstring7", testSubstring7),
        ("testSubstring8", testSubstring8),
        ("testSubstring9", testSubstring9),
        ("testSubstring10", testSubstring10),
        ("testSubstring11", testSubstring11),
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
