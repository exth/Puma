import XCTest
@testable import Puma
 

@MainActor
final class VerificationCodeViewModelTests: XCTestCase {
    var vm: VerificationCodeViewModel!
    var mockAuthService: MockAuthService!
    var session: SessionManager!
    var coordinator: AuthFlowCoordinator!

    override func setUp() async throws {
        try await super.setUp()
        mockAuthService = MockAuthService()
        session = SessionManager()
        vm = VerificationCodeViewModel(coordinator: AuthFlowCoordinator(), email: "testEmail@gmail.com", authService: mockAuthService, session: session)
    }
 
    override func tearDown() async throws {
        vm = nil
        mockAuthService = nil
        session = nil
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        try await super.tearDown()
    }

 
    func test_resendLinkTapped_shouldCallService() async {
        vm.resendLinkTapped()
        try? await Task.sleep(nanoseconds: 300_000_000)
        XCTAssertTrue(mockAuthService.resendVerificationCalled)
    }
}
