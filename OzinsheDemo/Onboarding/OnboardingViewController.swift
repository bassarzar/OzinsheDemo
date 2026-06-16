import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    // MARK: - Properties

    private var slides: [OnboardingSlide] = []
    private var currentPage = 0
    private let buttonGradient = CAGradientLayer()

    // MARK: - UI

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(
            OnboardingCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier
        )
        return cv
    }()

    private lazy var pageControl: CustomPageControl = {
        let pc = CustomPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 0
        return pc
    }()

    private lazy var nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Әрі қарай", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.alpha = 0
        return btn
    }()

    private lazy var skipButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Өткізу", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        return btn
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSlides()
        setupGradientButton()
        setupActions()
        updateUI(animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonGradient.frame = nextButton.bounds
    }

    // MARK: - Setup

    private func setupSlides() {
        slides = [
            OnboardingSlide(
                image: "firstImage",
                title: "ÖZINŞE-ге қош келдің!",
                subtitle: "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"
            ),
            OnboardingSlide(
                image: "secondImage",
                title: "ÖZINŞE-ге қош келдің!",
                subtitle: "Кез келген құрылғыдан қара. Сүйікті фильмді қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"
            ),
            OnboardingSlide(
                image: "thirdImage",
                title: "ÖZINŞE-ге қош келдің!",
                subtitle: "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"
            )
        ]
        collectionView.reloadData()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        skipButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.right.equalToSuperview().inset(16)
        }

        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(56)
        }

        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
    }

    private func setupGradientButton() {
        buttonGradient.colors = [
            UIColor(named: "7E2DFC")?.cgColor ?? UIColor.purple.cgColor,
            UIColor(named: "B376F7")?.cgColor ?? UIColor.systemPurple.cgColor
        ]
        buttonGradient.startPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.endPoint   = CGPoint(x: 1, y: 0.5)
        nextButton.layer.insertSublayer(buttonGradient, at: 0)
    }

    private func setupActions() {
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func nextTapped() {
        if currentPage < slides.count - 1 {
            currentPage += 1
            collectionView.scrollToItem(
                at: IndexPath(item: currentPage, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
            pageControl.currentPage = currentPage
            updateUI(animated: true)
        } else {
            finishOnboarding()
        }
    }

    @objc private func skipTapped() {
        finishOnboarding()
    }

    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "seenOnboarding")

        let loginVC = LoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        nav.setNavigationBarHidden(true, animated: false)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

    // MARK: - State

    private func updateUI(animated: Bool) {
        let isLast = currentPage == slides.count - 1
        let nextAlpha: CGFloat = isLast ? 1 : 0
        let skipAlpha: CGFloat = isLast ? 0 : 1

        if animated {
            UIView.animate(withDuration: 0.25) {
                self.nextButton.alpha = nextAlpha
                self.skipButton.alpha = skipAlpha
            }
        } else {
            nextButton.alpha = nextAlpha
            skipButton.alpha = skipAlpha
        }
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        slides.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCollectionViewCell.identifier,
            for: indexPath
        ) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: slides[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        view.bounds.size
    }
}

// MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        guard page != currentPage else { return }
        currentPage = page
        pageControl.currentPage = currentPage
        updateUI(animated: true)
    }
}
