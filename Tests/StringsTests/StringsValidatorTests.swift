import XCTest
@testable import Strings

class StringsValidationTests: XCTestCase {
    let testStr = "tHiS iS a TeSt StRiNg!"

    func testEmail1() {
        XCTAssertFalse(testStr.validate(EmailValidator.self))
    }

    func testEmail2() {
        let email = "ponyboy47@gmail.com"
        XCTAssertTrue(email.validate(EmailValidator.self))
    }

    func testEmail3() {
        let email = "test@test"
        XCTAssertFalse(email.validate(EmailValidator.self))
    }

    func testEmail4() {
        let email = "email.@invalid.com"
        XCTAssertFalse(email.validate(EmailValidator.self))
    }

    func testEmail5() {
        let email = "email@.invalid.com"
        XCTAssertFalse(email.validate(EmailValidator.self))
    }
}

#if os(Linux)
extension StringsValidationTests {
    static var allTests = [
        ("testEmail1", testEmail1),
        ("testEmail2", testEmail2),
        ("testEmail3", testEmail3),
        ("testEmail4", testEmail4),
        ("testEmail5", testEmail5)
    ]
}
#endif
