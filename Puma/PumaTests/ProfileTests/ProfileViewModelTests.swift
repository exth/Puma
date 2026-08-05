import XCTest
@testable import Puma


@MainActor
final class ProfileViewModelTests: XCTestCase {
    var vm: ProfileViewModel!
    var session: SessionManager!
    var mockCacheService: MockProductCacheService!
    var mockAuthService: MockAuthService!
    
    override func setUp() {
        super.setUp()
        session = SessionManager()
        mockCacheService = MockProductCacheService()
        mockAuthService = MockAuthService()
        vm = ProfileViewModel(session: session, cacheService: mockCacheService, authService: mockAuthService)
    }
    
    override func tearDown() {
        vm = nil
        session = nil
        mockCacheService = nil
        mockAuthService = nil
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        super.tearDown()
    }
    
    
    func test_clearCache_shouldSetDidClearCache() {
        vm.clearCache()
        XCTAssertTrue(vm.didClearCache)
    }
    
    func test_signOutTapped_shouldShowSignOutAlert() {
        vm.signOutTapped()
        XCTAssertTrue(vm.isShowingSignOutAlert)
    }
    
    func test_confirmSignOut_shouldLogOutSession() {
        session.completeAuthentication()
        vm.confirmSignOut()
        
        XCTAssertEqual(session.authState, .loggedOut)
    }
    
    func test_deleteAccountTapped_shouldShowDeleteAlert() {
        vm.deleteAccountTapped()
        XCTAssertTrue(vm.isShowingDeleteAccountAlert)
    }
}
