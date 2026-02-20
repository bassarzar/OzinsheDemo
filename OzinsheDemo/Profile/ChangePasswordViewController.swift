import UIKit

class ChangePasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    func setupNavigationBar() {
        navigationItem.title = "Құпия сөзді өзгерту"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        appearance.shadowColor = UIColor(named: "D1D5DB")

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
}
