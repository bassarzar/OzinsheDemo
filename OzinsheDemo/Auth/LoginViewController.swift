import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    
    // MARK: - UI
    
    lazy var scrollView: UIScrollView =
    {
        let sv = UIScrollView()
        
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    
    
    lazy var contentView = UIView()
    
    
    lazy var backButton: UIButton =
    {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor(named: "111827")
        
        return button
    }()
    
    
    lazy var titleLabel: UILabel =
    {
        let label = UILabel()
        
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    
    lazy var subtitleLabel: UILabel =
    {
        let label = UILabel()
        
        label.text = "Аккаунтқа кіріңіз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    
    lazy var emailLabel = AuthLabelFactory.make("Email")
    lazy var emailField = AuthTextField(type: .email, placeholder: "Сіздің email")
    
    lazy var passwordLabel = AuthLabelFactory.make("Құпия сөз")
    lazy var passwordField = AuthTextField(type: .password, placeholder: "Сіздің құпия сөзіңіз")
    
    
    lazy var forgotPasswordButton: UIButton =
    {
        let button = UIButton(type: .system)
        
        button.setTitle("Құпия сөзді ұмыттыңыз ба?", for: .normal)
        button.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        
        return button
    }()
    
    
    lazy var loginButton = GradientAuthButton(title: "Кіру")
    
    
    lazy var noAccountLabel: UILabel =
    {
        let label = UILabel()
        
        label.text = "Аккаунтыңыз жоқ па?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    
    lazy var registerButton: UIButton =
    {
        let button = UIButton(type: .system)
        
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 13)
        
        return button
    }()
    
    
    lazy var orSeparator = OrSeparatorView()
    
    lazy var appleButton = SocialAuthButton(title: "Apple ID-мен тіркелініз", iconName: "apple")
    lazy var googleButton = SocialAuthButton(title: "Google-мен тіркелініз", iconName: "google")
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
        setupKeyboard()
    }
    
    
    // MARK: - Actions
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func loginTapped() {
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
    
    
    @objc func goToRegister() {
        let registerVC = RegisterViewController()
        
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @objc func forgotTapped() {
        // TODO: forgot password
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = frame.height + 20
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
    }
    
    
    // MARK: - Private
    
    private func navigateToMain() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email.trimmingCharacters(in: .whitespaces))
    }
    
    
    // MARK: - Setup
    
    func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
        
        emailField.onTextChanged = { [weak self] _ in self?.emailField.isError = false }
        passwordField.onTextChanged = { [weak self] _ in self?.passwordField.isError = false }
    }
    
    
    func setupKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            backButton, titleLabel, subtitleLabel,
            emailLabel, emailField,
            passwordLabel, passwordField,
            forgotPasswordButton, loginButton,
            noAccountLabel, registerButton,
            orSeparator, appleButton, googleButton
        )
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(28)
            make.left.equalToSuperview().inset(24)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(24)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(24)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(12)
            make.right.equalToSuperview().inset(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(18)
            make.centerX.equalToSuperview().offset(-30)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerY.equalTo(noAccountLabel)
            make.left.equalTo(noAccountLabel.snp.right).offset(4)
        }
        
        orSeparator.snp.makeConstraints { make in
            make.top.equalTo(noAccountLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(20)
        }
        
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orSeparator.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(appleButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
