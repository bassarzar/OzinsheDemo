import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    
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
        
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var subtitleLabel: UILabel =
    {
        let label = UILabel()
        
        label.text = "Деректерді толтырыңыз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var emailLabel = AuthLabelFactory.make("Email")
    lazy var emailField = AuthTextField(type: .email, placeholder: "Сіздің email")
    
    lazy var passwordLabel = AuthLabelFactory.make("Құпия сөз")
    lazy var passwordField = AuthTextField(type: .password, placeholder: "Сіздің құпия сөзіңіз")
    
    lazy var confirmPasswordLabel = AuthLabelFactory.make("Құпия сөзді қайталаңыз")
    lazy var confirmPasswordField = AuthTextField(type: .confirmPassword, placeholder: "Сіздің құпия сөзіңіз")
    
    lazy var errorBannerLabel: UILabel =
    {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.textColor = UIColor(named: "FF402B")
        label.text = "Мұндай email-ы бар пайдаланушы тіркелген"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        
        return label
    }()
    
    lazy var registerButton = GradientAuthButton(title: "Тіркелу")
    
    lazy var hasAccountLabel: UILabel =
    {
        let label = UILabel()
        
        label.text = "Сізде аккаунт бар ма?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var loginButton: UIButton =
    {
        let button = UIButton(type: .system)
        
        button.setTitle("Кіріңіз", for: .normal)
        button.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 13)
        
        return button
    }()
    
    
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
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registerTapped() {
        view.endEditing(true)
        var hasError = false
        errorBannerLabel.isHidden = true
        
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
        
        // TODO: API call
        // При ошибке email занят — вызвать showErrorBanner()
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
    
    func showErrorBanner() {
        UIView.animate(withDuration: 0.2) {
            self.errorBannerLabel.isHidden = false
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email.trimmingCharacters(in: .whitespaces))
    }
    
    
    // MARK: - Setup
    
    func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        emailField.onTextChanged = { [weak self] _ in
            self?.emailField.isError = false
            self?.errorBannerLabel.isHidden = true
        }
        passwordField.onTextChanged = { [weak self] _ in self?.passwordField.isError = false }
        confirmPasswordField.onTextChanged = { [weak self] _ in self?.confirmPasswordField.isError = false }
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
            confirmPasswordLabel, confirmPasswordField,
            errorBannerLabel, registerButton,
            hasAccountLabel, loginButton
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
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        
        confirmPasswordField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(24)
        }
        
        errorBannerLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(errorBannerLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        hasAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(18)
            make.centerX.equalToSuperview().offset(-28)
            make.bottom.equalToSuperview().inset(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerY.equalTo(hasAccountLabel)
            make.left.equalTo(hasAccountLabel.snp.right).offset(4)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
