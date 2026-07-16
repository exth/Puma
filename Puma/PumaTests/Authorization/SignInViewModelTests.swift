import XCTest
@testable import Puma
 

@MainActor
final class SignInViewModelTests: XCTestCase {
    var vm: SignInViewModel!
    var coordinator: AuthFlowCoordinator!
    var session: SessionManager!
    var mockAuthService: MockAuthService!
 
    override func setUp() async throws {
        try await super.setUp()
        coordinator = AuthFlowCoordinator()
        session = SessionManager()
        mockAuthService = MockAuthService()
        vm = SignInViewModel(email: "test@example.com", coordinator: coordinator, session: session, authService: mockAuthService)
    }
 
    override func tearDown() async throws {
        vm = nil
        coordinator = nil
        session = nil
        mockAuthService = nil
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        try await super.tearDown()
    }
 
    
    func test_continueTapped_emptyPassword_shouldSetEmptyError() {
        vm.password = " "
        vm.continueTapped()
        XCTAssertEqual(vm.passwordError, .empty)
    }
 
    func test_continueTapped_validCredentials_shouldSignIn() async {
        vm.password = "somePassword123@"
        vm.continueTapped()
        try? await Task.sleep(nanoseconds: 300_000_000)
 
        XCTAssertTrue(mockAuthService.signInCalled)
        XCTAssertEqual(session.authState, .firstLogin)
    }
}
