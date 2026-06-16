import UIKit
import SnapKit

final class LoginViewController: UIViewController {

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
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28) ?? .boldSystemFont(ofSize: 28)
        label.textColor = UIColor(named: "111827")
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунтқа кіріңіз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14) ?? .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()

    private let emailLabel = AuthLabelFactory.make("Email")
    private let emailField = AuthTextField(type: .email, placeholder: "Сіздің email")

    private let passwordLabel = AuthLabelFactory.make("Құпия сөз")
    private let passwordField = AuthTextField(type: .password, placeholder: "Сіздің құпия сөзіңіз")

    private let forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Құпия сөзді ұмыттыңыз ба?", for: .normal)
        btn.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        return btn
    }()

    private let loginButton = GradientAuthButton(title: "Кіру")

    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунтыңыз жоқ па?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()

    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Тіркелу", for: .normal)
        btn.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 13) ?? .systemFont(ofSize: 13)
        return btn
    }()

    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "Немесе"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13) ?? .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "9CA3AF")
        label.textAlignment = .center
        return label
    }()

    private let appleButton = SocialAuthButton(title: "Apple ID-мен тіркелініз", iconName: "apple.logo")
    private let googleButton = SocialAuthButton(title: "Google-мен тіркелініз", iconName: "g.circle.fill")

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
            forgotPasswordButton, loginButton,
            noAccountLabel, registerButton,
            orLabel, appleButton, googleButton
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

        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(24)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(forgotPasswordButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        noAccountLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(18)
            $0.centerX.equalToSuperview().offset(-30)
        }

        registerButton.snp.makeConstraints {
            $0.centerY.equalTo(noAccountLabel)
            $0.leading.equalTo(noAccountLabel.snp.trailing).offset(4)
        }

        orLabel.snp.makeConstraints {
            $0.top.equalTo(noAccountLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        appleButton.snp.makeConstraints {
            $0.top.equalTo(orLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }

        googleButton.snp.makeConstraints {
            $0.top.equalTo(appleButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(40)
        }
    }

    // MARK: - Actions

    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)

        emailField.onTextChanged = { [weak self] _ in self?.emailField.isError = false }
        passwordField.onTextChanged = { [weak self] _ in self?.passwordField.isError = false }
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func loginTapped() {
        view.endEditing(true)
        var hasError = false

        if !isValidEmail(emailField.text) {
            emailField.isError = true
            emailField.errorMessage = "Қате формат"
            hasError = true
        }

        if passwordField.text.isEmpty {
            passwordField.isError = true
            passwordField.errorMessage = "Құпия сөзді енгізіңіз"
            hasError = true
        }

        guard !hasError else { return }
        navigateToMain()
    }

    @objc private func registerTapped() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func forgotTapped() {
        // TODO: forgot password flow
    }

    private func navigateToMain() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
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
