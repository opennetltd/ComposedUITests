import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        UIView.setAnimationsEnabled(ProcessInfo.processInfo.arguments.contains("--enable-regression-animations"))

        let window = UIWindow(windowScene: scene)

        window.rootViewController = UINavigationController(
            rootViewController: TestSelectionViewController()
        )
        self.window = window
        window.makeKeyAndVisible()
    }
}
