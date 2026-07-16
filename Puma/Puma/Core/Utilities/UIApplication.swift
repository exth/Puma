import UIKit


extension UIApplication {
    @MainActor
    func mainWindowViewController() -> UIViewController? {
        let scene = connectedScenes.first { $0 is UIWindowScene } as? UIWindowScene
        return scene?.windows.first { $0.isKeyWindow }?.rootViewController
    }
}
