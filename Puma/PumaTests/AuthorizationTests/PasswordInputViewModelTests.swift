import XCTest
@testable import Puma
 

@MainActor
final class PasswordInputViewModelTests: XCTestCase {
    var vm: PasswordInputViewModel!
    var coordinator: AuthFlowCoordinator!
    var mockAuthService: MockAuthService!
 
    override func setUp() async throws {
        try await super.setUp()
        coordinator = AuthFlowCoordinator()
        mockAuthService = MockAuthService()
        vm = PasswordInputViewModel(email: "test@example.com", coordinator: coordinator, authService: mockAuthService)
    }
 
    override func tearDown() async throws {
        vm = nil
        coordinator = nil
        mockAuthService = nil
        try await super.tearDown()
    }
 

    func test_continueTapped_emptyPassword_shouldSetEmptyError() {
        vm.password = " "
        vm.continueTapped()
        XCTAssertEqual(vm.validationError, .empty)
    }
 
    func test_continueTapped_tooShortPassword_shouldSetTooShortError() {
        vm.password = "Abc123@"
        vm.continueTapped()
        XCTAssertEqual(vm.validationError, .tooShort)
    }
 
    func test_continueTapped_missingNumber_shouldSetMissingNumberError() {
        vm.password = "Qwertyuiop@"
        vm.continueTapped()
        XCTAssertEqual(vm.validationError, .missingNumber)
    }
 
    func test_continueTapped_missingSpecialCharacter_shouldSetMissingCharacterError() {
        vm.password = "Qwertyuiop123"
        vm.continueTapped()
        XCTAssertEqual(vm.validationError, .missingCharacter)
    }
 
    func test_continueTapped_validPassword_shouldCallSignUp() async {
        vm.password = "Password123@"
        vm.continueTapped()
        try? await Task.sleep(nanoseconds: 300_000_000)
        XCTAssertTrue(mockAuthService.signUpCalled)
        XCTAssertNil(vm.validationError)
    }
}
