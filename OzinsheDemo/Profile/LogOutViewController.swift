import UIKit
import SnapKit

class LogOutViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tapGest()
        //localizeLanguage()
    }
    
    
    @objc func logoutButtonTapped() {
        
    }
    
    
    @objc func cancelButtonTapped() {
        dismissView()
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: onView) == true {
            return false
        }
        return true
    }
    
    
    lazy var onView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "FFFFFF")
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    
    lazy var logOutView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB tab")
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    
    lazy var logOutLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Шығу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Сіз шынымен аккаунтыңыздан шығасыз ба?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    
    lazy var agreeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Иә, шығу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var disagreeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Жоқ", for: .normal)
        button.setTitleColor(UIColor(named: "7E2DFC"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(onView)
        
        onView.addSubviews(
            logOutView,
            logOutLabel,
            questionLabel,
            agreeButton,
            disagreeButton
        )
        
        
        onView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(303)
        }
        
        
        logOutView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 64, height: 5))
        }
        
        
        logOutLabel.snp.makeConstraints { make in
            make.top.equalTo(logOutView.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        
        
        questionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(logOutLabel.snp.bottom).offset(8)
        }
        
        
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        
        disagreeButton.snp.makeConstraints { make in
            make.top.equalTo(agreeButton.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
    }
    
    
    func localizeLanguage() {
        logOutLabel.text = "LOG_OUT_LABEL".localized()
        questionLabel.text = "LOG_OUT_QUESTION_LABEL".localized()
        agreeButton.setTitle("LOG_OUT_BUTTON".localized(), for: .normal)
        disagreeButton.setTitle("NO_LOG_OUT_BUTTON".localized(), for: .normal)
    }
    
    
    func tapGest() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        tap.delegate = self
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
    
    
    @objc private func handleDismiss(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
            
        case .changed:
            
            guard translation.y > 0 else { return }
            onView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            
        case .ended, .cancelled:
            
            let shouldDismiss = translation.y > 120 || velocity.y > 1200
            
            if shouldDismiss {
                dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.onView.transform = .identity
                }
            }
        default:
            break
        }
        
    }
    
    
    
    
    
}
