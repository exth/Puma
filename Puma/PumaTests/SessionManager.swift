import XCTest
@testable import Puma
 

@MainActor
final class SessionManagerTests: XCTestCase {
    var session: SessionManager!
 
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        session = SessionManager()
    }
 
    override func tearDown() {
        session = nil
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        super.tearDown()
    }
 
    func test_init_noStoredFlag_shouldBeLoggedOut() {
        XCTAssertEqual(session.authState, .loggedOut) 
    }
 
    func test_completeAuthentication_shouldSetFirstLogin() {
        session.completeAuthentication()
        XCTAssertEqual(session.authState, .firstLogin)
    }
 
    func test_logOut_shouldSetLoggedOut() {
        session.completeAuthentication()
        session.logOut()
        XCTAssertEqual(session.authState, .loggedOut)
    }
}
