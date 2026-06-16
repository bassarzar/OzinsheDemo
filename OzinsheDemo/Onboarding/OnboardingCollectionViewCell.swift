import UIKit
import SnapKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "OnboardingCollectionViewCell"

    // MARK: - UI

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let gradientView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "111827")
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "6B7280")
        return label
    }()

    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .fill
        return stack
    }()

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0.85).cgColor,
            UIColor.white.cgColor
        ]
        layer.locations = [0.0, 0.65, 1.0]
        return layer
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .white

        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        contentView.addSubview(imageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(textStack)

        gradientView.layer.addSublayer(gradientLayer)

        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }

        gradientView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(imageView)
            $0.height.equalTo(200)
        }

        textStack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(24)
        }
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }

    // MARK: - Configure

    func configure(with slide: OnboardingSlide) {
        imageView.image = UIImage(named: slide.image)
        titleLabel.text = slide.title
        subtitleLabel.text = slide.subtitle
    }
}
