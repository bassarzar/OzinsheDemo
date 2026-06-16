import UIKit
import SnapKit

// MARK: - GradientAuthButton

final class GradientAuthButton: UIButton {

    private let gradientLayer = CAGradientLayer()

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16) ?? .boldSystemFont(ofSize: 16)
        layer.cornerRadius = 16
        clipsToBounds = true

        gradientLayer.colors = [
            UIColor(named: "7E2DFC")!.cgColor,
            UIColor(named: "B376F7")!.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)

        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    @objc private func touchDown() {
        UIView.animate(withDuration: 0.1) { self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97) }
    }

    @objc private func touchUp() {
        UIView.animate(withDuration: 0.1) { self.transform = .identity }
    }
}

// MARK: - SocialAuthButton

final class SocialAuthButton: UIButton {

    init(title: String, iconName: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(UIColor(named: "111827"), for: .normal)
        titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 15) ?? .systemFont(ofSize: 15, weight: .medium)

        let img = UIImage(systemName: iconName)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "111827") ?? .black)
        setImage(img, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)

        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "D1D5DB")?.cgColor
    }

    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - AuthLabelFactory

enum AuthLabelFactory {
    static func make(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "SFProDisplay-Medium", size: 13) ?? .systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(named: "111827")
        return label
    }
}
