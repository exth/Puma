import Foundation


@Observable
final class ProfileViewModel {
    private let session: SessionManager
    
    init(session: SessionManager) {
        self.session = session
    }
    
    
    func logOut() {
        session.logOut()
    }
}
