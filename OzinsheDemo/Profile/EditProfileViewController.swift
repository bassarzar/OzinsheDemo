import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func setupNavigationBar() {
        navigationItem.title = "Жеке Деректер"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        appearance.shadowColor = UIColor(named: "D1D5DB")

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    
    
}
