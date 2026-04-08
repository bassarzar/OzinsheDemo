import UIKit
import SnapKit

class ProfileViewController: UIViewController, LanguageProtocol {
    
    func languageDidChanged() {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    
    
    @objc func logoutButtonTapped() {
        let logOutVC = LogOutViewController()
        
        logOutVC.modalPresentationStyle = .overFullScreen
        
        self.present(logOutVC, animated: true , completion: nil)
    }
    
    
    
    @objc func personalDataButtonTapped() {
        let profileVC = EditPersonalDataViewController()
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
    
    @objc func changePasswordButtonTapped() {
        let changePasswordVC = ChangePasswordViewController()
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    
    
    @objc func languageButtonTapped() {
        let languageVC = LanguageViewController()
        
        languageVC.modalPresentationStyle = .overFullScreen
        languageVC.delegate = self
        
        present(languageVC, animated: true , completion: nil)
    }
    
    
    
    
    func setupNavigationBar() {
        navigationItem.title = "Профиль"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "F9FAFB")

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "logOut"),
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "FF402B")
    }

    
    
    // MARK: TITLE
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "ProfilePoster")
        
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Менің профилім"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "nurnazarorynbassar@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    
    lazy var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F9FAFB")
        
        return view
    }()
    
    

    //MARK: PERSONAL DATA
    
    lazy var personalDataButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Жеке Деректер", for: .normal)
        button.setTitleColor(UIColor(named: "111827"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(personalDataButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var personalDataLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Өңдеу"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 12)
        
        return label
    }()
    
    
    lazy var personalDataArrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "ArrowRight")
        
        return imageView
    }()
    
    
    lazy var personalDataLineView: UIView = {
        let line = UIView()

        line.backgroundColor = UIColor(named: "D1D5DB")
        
        return line
    }()
    
    
    
    
    // MARK: CHANGE PASSWORD
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Құпия сөзді өзгерту", for: .normal)
        button.setTitleColor(UIColor(named: "111827"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var changePasswordArrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "ArrowRight")
        
        return imageView
    }()
    
    
    lazy var changePasswordLineView: UIView = {
        let line = UIView()

        line.backgroundColor = UIColor(named: "D1D5DB")
        
        return line
    }()
    
    
    
    
    //MARK: LANGUAGE
    
    lazy var languageButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Тіл", for: .normal)
        button.setTitleColor(UIColor(named: "111827"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Қазақша"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 12)
        
        return label
    }()
    
    
    lazy var languageArrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "ArrowRight")
        
        return imageView
    }()
    
    
    lazy var languageLineView: UIView = {
        let line = UIView()

        line.backgroundColor = UIColor(named: "D1D5DB")
        
        return line
    }()
    
    
    
    
    // MARK: SWITCH MODE
    
    lazy var darkModeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Қараңғы режим"
        label.textColor = UIColor(named: "111827")
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
        
        return label
    }()
    
    lazy var darkModeSwitch: UISwitch = {
        let dMSwitch = UISwitch()

        dMSwitch.onTintColor = UIColor(named: "B376F7")
        dMSwitch.thumbTintColor = UIColor(named: "E5E7EB")
        dMSwitch.addTarget(self, action: #selector(switcher(_:)), for: .valueChanged)

        return dMSwitch
    }()
    
    
    @objc func switcher(_ dmswitch: UISwitch) {
        if dmswitch.isOn {
            
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {

                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        } else {
            
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) {

                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
    
    
    
    // MARK: IMPLEMENTATION
    
    func setupUI() {
        
        view.addSubviews(profileImageView, titleLabel, subtitleLabel, backView)
        
        backView.addSubviews( personalDataButton, personalDataLabel, personalDataArrowImageView, personalDataLineView, changePasswordButton, changePasswordArrowImageView, changePasswordLineView, languageButton, languageLabel, languageArrowImageView, languageLineView, darkModeLabel, darkModeSwitch)
        
        
        profileImageView.snp.makeConstraints { (make) in
            make.height.equalTo(120)
            make.width.equalTo(120)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        // Personal Data
        
        personalDataButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        personalDataArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(personalDataButton)
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.right.equalToSuperview().inset(24)
        }
        
        personalDataLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(personalDataButton)
            make.right.equalTo(personalDataArrowImageView.snp.left).offset(-8)
        }
        
        personalDataLineView.snp.makeConstraints { (make) in
            make.top.equalTo(personalDataButton.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(24)
        }
        
        
        // Password
        
        changePasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(personalDataLineView).offset(1)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        changePasswordArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(changePasswordButton)
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.right.equalToSuperview().inset(24)
        }
        
        changePasswordLineView.snp.makeConstraints { (make) in
            make.top.equalTo(changePasswordButton.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(24)
        }
        
        
        // Language
        
        languageButton.snp.makeConstraints { (make) in
            make.top.equalTo(changePasswordLineView).offset(1)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        languageArrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(languageButton)
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.right.equalToSuperview().inset(24)
        }
        
        languageLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(languageButton)
            make.right.equalTo(languageArrowImageView.snp.left).offset(-8)
        }
        
        languageLineView.snp.makeConstraints { (make) in
            make.top.equalTo(languageButton.snp.bottom).offset(1)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(24)
        }
        
        
        // Switcher
        
        darkModeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(languageLineView).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        
        darkModeSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(languageLineView).offset(20)
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(darkModeLabel)
        }
        
        
    }
    
    
    
}
