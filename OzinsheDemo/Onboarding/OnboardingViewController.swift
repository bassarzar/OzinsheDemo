import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    // MARK: - Data

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
        cv.delegate = self
        cv.dataSource = self
        cv.register(OnboardingCollectionViewCell.self,
                    forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        return cv
    }()

    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor(named: "7C3AED")
        pc.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        return pc
    }()

    private let nextButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Әрі қарай", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.alpha = 0
        return btn
    }()

    private let skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Өткізу", for: .normal)
        btn.setTitleColor(UIColor(named: "111827"), for: .normal)
        btn.backgroundColor = UIColor(named: "F3F4F6")
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.layer.cornerRadius = 8
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        return btn
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSlides()
        setupUI()
        setupGradient()
        setupActions()
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
                subtitle: "Кез келген құрылғыдан қара Сүйікті фильміңді қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"
            ),
            OnboardingSlide(
                image: "thirdImage",
                title: "ÖZINŞE-ге қош келдің!",
                subtitle: "Тіркелу оңай. Қазір тіркел де, қалаған фильміңе қол жеткіз"
            )
        ]

        pageControl.numberOfPages = slides.count
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

        nextButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(56)
        }

        pageControl.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
        }

        skipButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.right.equalToSuperview().inset(16)
        }
    }

    private func setupGradient() {
        buttonGradient.colors = [
            UIColor(named: "7E2DFC")!.cgColor,
            UIColor(named: "B376F7")!.cgColor
        ]
        buttonGradient.startPoint = CGPoint(x: 0, y: 0.5)
        buttonGradient.endPoint = CGPoint(x: 1, y: 0.5)

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
            pageControl.currentPageIndicatorTintColor = UIColor(named: "B376F7")
            pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.3)
            
        } else {
            finishOnboarding()
        }

        updateUI()
    }

    @objc private func skipTapped() {
        finishOnboarding()
    }

    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "seenOnboarding")

        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    private func updateUI() {
        let isLast = currentPage == slides.count - 1

        UIView.animate(withDuration: 0.25) {
            self.nextButton.alpha = isLast ? 1 : 0
            self.skipButton.alpha = isLast ? 0 : 1
        }
    }
}

// MARK: - Collection

extension OnboardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        slides.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCollectionViewCell.identifier,
            for: indexPath
        ) as! OnboardingCollectionViewCell

        cell.configure(with: slides[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width,
                      height: view.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = currentPage
        updateUI()
    }
}
