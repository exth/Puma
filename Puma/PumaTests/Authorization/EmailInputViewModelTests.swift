import XCTest
@testable import Puma
 

final class EmailInputViewModelTests: XCTestCase {
    var vm: EmailInputViewModel!
    var coordinator: AuthFlowCoordinator!
 
    override func setUp() {
        super.setUp()
        vm = EmailInputViewModel()
        coordinator = AuthFlowCoordinator()
    }
 
    override func tearDown() {
        vm = nil
        coordinator = nil
        super.tearDown()
    }
 
    
    func test_continueTapped_emptyEmail_shouldSetEmptyError() {
        vm.email = ""
        vm.continueTapped(coordinator: coordinator)
        XCTAssertEqual(vm.validationError, .empty)
    }
 
    func test_continueTapped_invalidEmail_shouldSetInvalidFormatError() {
        vm.email = "notEmail"
        vm.continueTapped(coordinator: coordinator)
        XCTAssertEqual(vm.validationError, .invalidFormat)
    }
 
    func test_continueTapped_validEmail_shouldClearError() {
        vm.email = "testEmail@gmail.com"
        vm.continueTapped(coordinator: coordinator)
        XCTAssertNil(vm.validationError)
    }
}
