import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Құпия сөзді өзгерту"
        
        setupUI()
        //localizeLanguage()
        hideKeyboardWhenTappedAround()
    }
    
    
    
    lazy var passwordLabel = {
        let label = UILabel()
        
        label.text = "Құпиясөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    
    lazy var passwordTextField = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    
    lazy var passwordImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "password")
        
        return image
    }()
    
    
    lazy var showPasswordButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)

        return button
    }()

    
    lazy var repeatPasswordLabel = {
        let label = UILabel()
        
        label.text = "Құпиясөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")

        return label
    }()

    
    lazy var repeatPasswordTextField = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 12

        return textField
    }()
    
    
    lazy var repeatPasswordImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "password")

        return image
    }()
    

    lazy var repeatShowPasswordButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(repeatShowPasswordTapped), for:
            .touchUpInside)

        return button
    }()

    
    lazy var saveChangesButton = {
        let button = UIButton()
        
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)

        return button
    }()
    
    
    
    @objc func showPasswordButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

    @objc func repeatShowPasswordTapped() {
        repeatPasswordTextField.isSecureTextEntry =
            !repeatPasswordTextField.isSecureTextEntry
    }
    
    
    @objc func saveChangesButtonTapped() {
        
    }
    
    
    func localizeLanguage() {
        passwordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        repeatPasswordTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
        saveChangesButton.setTitle("USER_INFO_SAVE_BUTTON".localized(), for: .normal)
        passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        navigationItem.title = "CHANGE_PASSWORD_NAVIGATION".localized()
    }
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "F9FAFB")

        view.addSubviews(
            passwordLabel,
            passwordTextField,
            passwordImage,
            showPasswordButton,
            repeatPasswordLabel,
            repeatPasswordTextField,
            repeatPasswordImage,
            repeatShowPasswordButton,
            saveChangesButton
        )

        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(21)
            make.height.equalTo(21)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }

        passwordImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalTo(passwordTextField.snp.left).offset(16)
            make.centerY.equalTo(passwordTextField)
        }

        showPasswordButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 56))
            make.right.equalTo(passwordTextField.snp.right)
            make.centerY.equalTo(passwordTextField)
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }

        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }

        repeatPasswordImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.left.equalTo(repeatPasswordTextField.snp.left).offset(16)
            make.centerY.equalTo(repeatPasswordTextField)
        }
        
        repeatShowPasswordButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 36, height: 56))
            make.right.equalTo(repeatPasswordTextField.snp.right)
            make.centerY.equalTo(repeatPasswordTextField)
        }

        saveChangesButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        
        
    }
    
    
    
    
}
