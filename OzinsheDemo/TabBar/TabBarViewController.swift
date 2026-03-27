import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "F9FAFB")

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func setupTabs() {

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())

        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Home"),
            selectedImage: UIImage(named: "SelectedHome")
        )

        searchVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Search"),
            selectedImage: UIImage(named: "SelectedSearch")
        )

        favoriteVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Favorite"),
            selectedImage: UIImage(named: "SelectedFavorite")
        )

        profileVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Profile"),
            selectedImage: UIImage(named: "SelectedProfile")
        )

        setViewControllers( [homeVC, searchVC, favoriteVC, profileVC], animated: true)
    }
    
}
