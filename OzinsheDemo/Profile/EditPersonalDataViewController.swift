import UIKit
import SnapKit

class EditPersonalDataViewController: UIViewController {

    var userID: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Жеке Деректер"
        setupUI()
        //localizeLanguage()
        hideKeyboardWhenTappedAround()
    }
    
    

    lazy var nameLabel = {
        let label = UILabel()
        
        label.text = "Сіздің атыңыз"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)

        return label
    }()

    
    lazy var nameTextField = {
        let textField = UITextField()
        
        textField.placeholder = "Атыңызды енгізіңіз"
        textField.textColor = UIColor(named: "111827")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)

        return textField
    }()

    
    lazy var lineView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB tab")

        return view
    }()
    
    
    lazy var emailLabel = {
        let label = UILabel()
        
        label.text = "Email"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)

        return label
    }()
    

    lazy var emailTextField = {
        let textField = UITextField()
        
        textField.placeholder = "nurnazarorynbassar@gmail.com"
        textField.textColor = UIColor(named: "111827")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)

        return textField
    }()

    
    lazy var lineView2 = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB tab")

        return view
    }()
    
    
    lazy var phoneLabel = {
        let label = UILabel()
        
        label.text = "Телефон"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)

        return label
    }()

    
    lazy var phoneTextField = {
        let textField = UITextField()
        
        textField.placeholder = "+7 775 648 72 22"
        textField.textColor = UIColor(named: "111827")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)

        return textField
    }()

    
    lazy var lineView3 = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB tab")

        return view
    }()
    

    lazy var birthDateLabel = {
        let label = UILabel()
        
        label.text = "Туған күні"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)

        return label
    }()
    
    
    lazy var birthDateTextField = {
        let textField = UITextField()
        
        textField.placeholder = "2005-05-22"
        textField.textColor = UIColor(named: "111827")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)

        return textField
    }()

    
    lazy var lineView4 = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB tab")

        return view
    }()

    
    lazy var saveChangesButton = {
        let button = UIButton()
        
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveDataButton), for: .touchUpInside)

        return button
    }()
    
    
    
    
    func localizeLanguage() {
        navigationItem.title = "USER_INFO_NAVIGATION".localized()
        nameLabel.text = "USER_INFO_NAME_LABEL".localized()
        nameTextField.placeholder = "USER_INFO_NAME_TEXT_FIELD".localized()
        phoneLabel.text = "US_INFO_PHONE_LABEL".localized()
        birthDateLabel.text = "US_INFO_BIRTH_LABEL".localized()
        saveChangesButton.setTitle("US_INFO_SAVE_BUTTON".localized(), for: .normal)
    }
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    @objc func saveDataButton() {
        
    }
    
    
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "F9FAFB")

        view.addSubviews(nameLabel, nameTextField, lineView, emailLabel, emailTextField, lineView2, phoneLabel, phoneTextField, lineView3, birthDateLabel, birthDateTextField, lineView4, saveChangesButton)

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(21)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(33)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }

        lineView2.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }

        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }

        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }

        lineView3.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        birthDateLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }

        birthDateTextField.snp.makeConstraints { make in
            make.top.equalTo(birthDateLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }

        lineView4.snp.makeConstraints { make in
            make.top.equalTo(birthDateTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        saveChangesButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(56)
        }
        
        
        
        
        
    }
    
    
    
    
    
}
