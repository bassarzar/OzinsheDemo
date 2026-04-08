import UIKit
import SnapKit

final class OnboardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "OnboardingCollectionViewCell"

    // MARK: - UI

    private let imageView = UIImageView()
    private let gradientView = UIView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let textStack = UIStackView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .white

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor(named: "111827") ?? .black

        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = UIColor(named: "6B7280") ?? .gray

        textStack.axis = .vertical
        textStack.spacing = 12
        textStack.alignment = .fill

        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)

        contentView.addSubview(imageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(textStack)

        setupConstraints()
        setupGradient()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }

        gradientView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(imageView)
            $0.height.equalTo(180)
        }

        textStack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(24)
        }
    }

    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.white.withAlphaComponent(0.9).cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0.0, 0.7, 1.0]

        gradientView.layer.addSublayer(gradient)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.layer.sublayers?.first?.frame = gradientView.bounds
    }

    // MARK: - Config

    func configure(with slide: OnboardingSlide) {
        imageView.image = UIImage(named: slide.image)
        titleLabel.text = slide.title
        subtitleLabel.text = slide.subtitle
    }
}
