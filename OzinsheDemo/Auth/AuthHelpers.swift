import UIKit
import SnapKit

// MARK: - GradientAuthButton

class GradientAuthButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        layer.cornerRadius = 16
        clipsToBounds = true
        backgroundColor = UIColor(named: "7E2DFC")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - SocialAuthButton

class SocialAuthButton: UIButton {
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(UIColor(named: "111827"), for: .normal)
        titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        
        setImage(UIImage(named: iconName), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "D1D5DB")?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - OrSeparatorView

class OrSeparatorView: UIView {
    
    lazy var leftLine: UIView =
    {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    lazy var label: UILabel =
    {
        let label = UILabel()
        
        label.text = "Немесе"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 13)
        label.textColor = UIColor(named: "9CA3AF")
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var rightLine: UIView =
    {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubviews(leftLine, label, rightLine)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        leftLine.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(label.snp.leading).offset(-12)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        rightLine.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}


// MARK: - AuthLabelFactory

enum AuthLabelFactory {
    static func make(_ text: String) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.font = UIFont(name: "SFProDisplay-Medium", size: 13)
        label.textColor = UIColor(named: "111827")
        
        return label
    }
}
