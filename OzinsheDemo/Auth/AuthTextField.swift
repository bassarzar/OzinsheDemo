import UIKit
import SnapKit

enum AuthTextFieldType {
    case email
    case password
    case confirmPassword
}

final class AuthTextField: UIView {

    // MARK: - Public

    var text: String { textField.text ?? "" }
    var onTextChanged: ((String) -> Void)?

    var isError: Bool = false {
        didSet { updateAppearance() }
    }

    var errorMessage: String? {
        didSet { errorLabel.text = errorMessage }
    }

    // MARK: - UI

    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let textField = UITextField()
    private let eyeButton = UIButton(type: .custom)
    private let errorLabel = UILabel()

    private let fieldType: AuthTextFieldType
    private var isPasswordVisible = false

    // MARK: - Init

    init(type: AuthTextFieldType, placeholder: String) {
        self.fieldType = type
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setupUI(placeholder: String) {
        addSubviews(containerView, errorLabel)

        containerView.backgroundColor = UIColor(named: "F3F4F6")
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        containerView.addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor(named: "9CA3AF")

        switch fieldType {
        case .email:
            iconImageView.image = UIImage(systemName: "envelope")
        case .password, .confirmPassword:
            iconImageView.image = UIImage(systemName: "lock")
        }

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(18)
        }

        containerView.addSubview(textField)
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 15) ?? .systemFont(ofSize: 15)
        textField.textColor = UIColor(named: "111827")
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(named: "9CA3AF") ?? .lightGray]
        )
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        if fieldType == .email {
            textField.keyboardType = .emailAddress
        }
        if fieldType == .password || fieldType == .confirmPassword {
            textField.isSecureTextEntry = true
        }

        if fieldType == .password || fieldType == .confirmPassword {
            containerView.addSubview(eyeButton)
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            eyeButton.tintColor = UIColor(named: "9CA3AF")
            eyeButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
            eyeButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(14)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(24)
            }
            textField.snp.makeConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
                $0.trailing.equalTo(eyeButton.snp.leading).offset(-6)
                $0.centerY.equalToSuperview()
            }
        } else {
            textField.snp.makeConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
                $0.trailing.equalToSuperview().inset(14)
                $0.centerY.equalToSuperview()
            }
        }

        errorLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12) ?? .systemFont(ofSize: 12)
        errorLabel.textColor = UIColor(named: "FF402B")
        errorLabel.isHidden = true
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Appearance

    private func updateAppearance() {
        if isError {
            containerView.layer.borderColor = UIColor(named: "FF402B")?.cgColor
            containerView.backgroundColor = UIColor(named: "FF402B")?.withAlphaComponent(0.05)
            errorLabel.isHidden = false
        } else {
            containerView.layer.borderColor = UIColor.clear.cgColor
            containerView.backgroundColor = UIColor(named: "F3F4F6")
            errorLabel.isHidden = true
        }
    }

    func setFocused(_ focused: Bool) {
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

    @objc private func togglePassword() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        let icon = isPasswordVisible ? "eye.slash" : "eye"
        eyeButton.setImage(UIImage(systemName: icon), for: .normal)
    }

    @objc private func textDidChange() {
        onTextChanged?(textField.text ?? "")
    }
}

// MARK: - UITextFieldDelegate

extension AuthTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) { setFocused(true) }
    func textFieldDidEndEditing(_ textField: UITextField) { setFocused(false) }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
