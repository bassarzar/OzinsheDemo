import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    
    func setupTabs() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "SelectedHome"))
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SelectedSearch"))
        favoriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "SelectedFavorite"))
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "SelectedProfile"))
        
        setViewControllers([homeVC, searchVC, favoriteVC, profileVC], animated: true)
        
    }

}
