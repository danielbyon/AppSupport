import XCTest
@testable import AppSupport

final class AppSupportTests: XCTestCase {

    @UserDefault(key: "testKey", defaultValue: 0) var testDefault: Int

    func testUserDefault() {
        let expected = 1

        testDefault = expected

        let actual = testDefault
        XCTAssert(expected == actual)
    }

    static var allTests = [
        ("testUserDefault", testUserDefault),
    ]
}
