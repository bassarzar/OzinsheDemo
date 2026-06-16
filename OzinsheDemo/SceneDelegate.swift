import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // Временно сбрасываем для теста
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "seenOnboarding")

        let rootVC: UIViewController

        let seenOnboarding = UserDefaults.standard.bool(forKey: "seenOnboarding")
        let isLoggedIn     = UserDefaults.standard.bool(forKey: "isLoggedIn")

        if isLoggedIn {
            rootVC = TabBarViewController()
        } else if seenOnboarding {
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.setNavigationBarHidden(true, animated: false)
            rootVC = nav
        } else {
            rootVC = OnboardingViewController()
        }

        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}
