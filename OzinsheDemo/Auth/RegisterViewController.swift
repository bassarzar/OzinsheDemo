import UIKit
import SnapKit

final class RegisterViewController: UIViewController {

    // MARK: - UI

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = UIColor(named: "111827")
        return btn
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28) ?? .boldSystemFont(ofSize: 28)
        label.textColor = UIColor(named: "111827")
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14) ?? .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()

    private let emailLabel = AuthLabelFactory.make("Email")
    private let emailField = AuthTextField(type: .email, placeholder: "Сіздің email")

    private let passwordLabel = AuthLabelFactory.make("Құпия сөз")
    private let passwordField = AuthTextField(type: .password, placeholder: "••••••••")

    private let confirmPasswordLabel = AuthLabelFactory.make("Құпия сөзді қайталаңыз")
    private let confirmPasswordField = AuthTextField(type: .confirmPassword, placeholder: "Сіздің құпия сөзіңіз")

    private let errorBanner: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "FF402B")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private let registerButton = GradientAuthButton(title: "Тіркелу")

    private let hasAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Сізде аккаунт бар ма?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Кіріңіз", for: .normal)
        btn.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 13) ?? .systemFont(ofSize: 13)
        return btn
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupKeyboard()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
        }

        contentView.addSubviews(
            backButton, titleLabel, subtitleLabel,
            emailLabel, emailField,
            passwordLabel, passwordField,
            confirmPasswordLabel, confirmPasswordField,
            errorBanner, registerButton,
            hasAccountLabel, loginButton
        )

        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(36)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(24)
        }

        emailLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(24)
        }

        emailField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
        }

        confirmPasswordField.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        errorBanner.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        registerButton.snp.makeConstraints {
            $0.top.equalTo(errorBanner.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        hasAccountLabel.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(18)
            $0.centerX.equalToSuperview().offset(-28)
            $0.bottom.equalToSuperview().inset(40)
        }

        loginButton.snp.makeConstraints {
            $0.centerY.equalTo(hasAccountLabel)
            $0.leading.equalTo(hasAccountLabel.snp.trailing).offset(4)
        }
    }

    // MARK: - Actions

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        emailField.onTextChanged = { [weak self] _ in
            self?.emailField.isError = false
            self?.errorBanner.isHidden = true
        }
        passwordField.onTextChanged = { [weak self] _ in self?.passwordField.isError = false }
        confirmPasswordField.onTextChanged = { [weak self] _ in self?.confirmPasswordField.isError = false }
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func registerTapped() {
        view.endEditing(true)
        var hasError = false
        errorBanner.isHidden = true

        if !isValidEmail(emailField.text) {
            emailField.isError = true
            emailField.errorMessage = "Қате формат"
            hasError = true
        }

        if passwordField.text.count < 6 {
            passwordField.isError = true
            passwordField.errorMessage = "Минимум 6 таңба"
            hasError = true
        }

        if confirmPasswordField.text != passwordField.text {
            confirmPasswordField.isError = true
            confirmPasswordField.errorMessage = "Құпия сөздер сәйкес келмейді"
            hasError = true
        }

        guard !hasError else { return }

        // TODO: вызов API регистрации
        // При ошибке "email занят":
        errorBanner.text = "Мұндай email-ы бар пайдаланушы тіркелген"
        UIView.animate(withDuration: 0.2) { self.errorBanner.isHidden = false }
    }

    @objc private func loginTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Validation

    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email.trimmingCharacters(in: .whitespaces))
    }

    // MARK: - Keyboard

    private func setupKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func dismissKeyboard() { view.endEditing(true) }

    @objc private func keyboardWillShow(_ n: Notification) {
        guard let frame = n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = frame.height + 20
    }

    @objc private func keyboardWillHide(_ n: Notification) {
        scrollView.contentInset.bottom = 0
    }

    deinit { NotificationCenter.default.removeObserver(self) }
}
