import SwiftUI


struct SwipeBackEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        SwipeBackEnablerViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}


private final class SwipeBackEnablerViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
