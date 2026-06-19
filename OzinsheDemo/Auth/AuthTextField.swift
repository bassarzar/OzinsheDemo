import UIKit
import SnapKit

enum AuthTextFieldType {
    case email
    case password
    case confirmPassword
}

class AuthTextField: UIView {
    
    // MARK: - Public
    
    var text: String { textField.text ?? "" }
    var onTextChanged: ((String) -> Void)?
    
    var isError: Bool = false {
        didSet { updateAppearance() }
    }
    
    var errorMessage: String? {
        didSet { errorLabel.text = errorMessage }
    }
    
    
    // MARK: - Properties
    
    private let fieldType: AuthTextFieldType
    private var isPasswordVisible = false
    
    
    // MARK: - UI
    
    lazy var containerView: UIView =
    {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F3F4F6")
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        
        return view
    }()
    
    lazy var iconImageView: UIImageView =
    {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "9CA3AF")
        
        return imageView
    }()
    
    lazy var textField: UITextField =
    {
        let tf = UITextField()
        
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        tf.textColor = UIColor(named: "111827")
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
        return tf
    }()
    
    lazy var eyeButton: UIButton =
    {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.tintColor = UIColor(named: "9CA3AF")
        
        return button
    }()
    
    lazy var errorLabel: UILabel =
    {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "FF402B")
        label.isHidden = true
        
        return label
    }()
    
    
    // MARK: - Init
    
    init(type: AuthTextFieldType, placeholder: String) {
        self.fieldType = type
        super.init(frame: .zero)
        
        setupUI(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    func setupUI(placeholder: String) {
        addSubviews(containerView, errorLabel)
        containerView.addSubviews(iconImageView, textField)
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(named: "9CA3AF") ?? .lightGray]
        )
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        switch fieldType {
        case .email:
            iconImageView.image = UIImage(named: "message")
            textField.keyboardType = .emailAddress
        case .password, .confirmPassword:
            iconImageView.image = UIImage(named: "password")
            textField.isSecureTextEntry = true
            containerView.addSubview(eyeButton)
            eyeButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(52)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        if fieldType == .password || fieldType == .confirmPassword {
            eyeButton.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(14)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(24)
            }
            
            textField.snp.makeConstraints { make in
                make.left.equalTo(iconImageView.snp.right).offset(10)
                make.right.equalTo(eyeButton.snp.left).offset(-6)
                make.centerY.equalToSuperview()
            }
        } else {
            textField.snp.makeConstraints { make in
                make.left.equalTo(iconImageView.snp.right).offset(10)
                make.right.equalToSuperview().inset(14)
                make.centerY.equalToSuperview()
            }
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: - Appearance
    
    private func updateAppearance() {
        if isError {
            containerView.layer.borderColor = UIColor(named: "FF402B")?.cgColor
            containerView.backgroundColor = UIColor(named: "FF402B")?.withAlphaComponent(0.08)
            errorLabel.isHidden = false
        } else {
            containerView.layer.borderColor = UIColor.clear.cgColor
            containerView.backgroundColor = UIColor(named: "F3F4F6")
            errorLabel.isHidden = true
        }
    }
    
    private func setFocused(_ focused: Bool) {
        guard !isError else { return }
        
        if focused {
            containerView.layer.borderColor = UIColor(named: "7E2DFC")?.cgColor
            containerView.layer.borderWidth = 1.5
            containerView.backgroundColor = .white
        } else {
            containerView.layer.borderColor = UIColor.clear.cgColor
            containerView.layer.borderWidth = 1
            containerView.backgroundColor = UIColor(named: "F3F4F6")
        }
    }
    
    
    // MARK: - Actions
    
    @objc func togglePassword() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        
        let icon = isPasswordVisible ? "removeButton" : "showPassword"
        eyeButton.setImage(UIImage(named: icon), for: .normal)
    }
    
    @objc func textDidChange() {
        onTextChanged?(textField.text ?? "")
    }
}


// MARK: - UITextFieldDelegate

extension AuthTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setFocused(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setFocused(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
