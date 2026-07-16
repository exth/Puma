import XCTest
@testable import Puma
 

@MainActor
final class AuthViewModelTests: XCTestCase {
    var vm: AuthViewModel!
    var session: SessionManager!
    var mockAuthService: MockAuthService!
 
    override func setUp() async throws {
        try await super.setUp()
        session = SessionManager()
        mockAuthService = MockAuthService()
        vm = AuthViewModel(session: session, authService: mockAuthService)
    }
 
    override func tearDown() async throws {
        vm = nil
        session = nil
        mockAuthService = nil
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        try await super.tearDown()
    }
 
    
    func test_signInWithGoogle_success_shouldCompleteAuthentication() async {
        await vm.signInWithGoogle()
 
        XCTAssertTrue(mockAuthService.signInWithGoogleCalled)
        XCTAssertEqual(session.authState, .firstLogin)
        XCTAssertNil(vm.errorMessage)
    }
}
