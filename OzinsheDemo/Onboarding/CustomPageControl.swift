import UIKit

final class CustomPageControl: UIView {

    // MARK: - Properties

    var numberOfPages: Int = 0 {
        didSet { setupDots() }
    }

    var currentPage: Int = 0 {
        didSet { updateDots() }
    }

    var activeColor: UIColor = UIColor(named: "B376F7") ?? .purple
    var inactiveColor: UIColor = UIColor(named: "9CA3AF") ?? .lightGray

    
    private var dots: [UIView] = []
    private let dotHeight: CGFloat = 8
    private let dotWidth: CGFloat = 8
    private let activeDotWidth: CGFloat = 24
    private let spacing: CGFloat = 8

    // MARK: - Setup

    private func setupDots() {
        dots.forEach { $0.removeFromSuperview() }
        dots = []

        for _ in 0..<numberOfPages {
            let dot = UIView()
            dot.layer.cornerRadius = dotHeight / 2
            dot.clipsToBounds = true
            addSubview(dot)
            dots.append(dot)
        }

        updateDots()
    }

    private func updateDots() {
        var xOffset: CGFloat = 0

        for (index, dot) in dots.enumerated() {
            let isActive = index == currentPage
            let width = isActive ? activeDotWidth : dotWidth

            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                dot.backgroundColor = isActive ? self.activeColor : self.inactiveColor
                dot.frame = CGRect(x: xOffset, y: 0, width: width, height: self.dotHeight)
                dot.layer.cornerRadius = self.dotHeight / 2
            }

            xOffset += width + spacing
        }

        let totalWidth = activeDotWidth + dotWidth * CGFloat(numberOfPages - 1) + spacing * CGFloat(numberOfPages - 1)
        frame.size = CGSize(width: totalWidth, height: dotHeight)
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        let totalWidth = activeDotWidth + dotWidth * CGFloat(numberOfPages - 1) + spacing * CGFloat(numberOfPages - 1)
        return CGSize(width: totalWidth, height: dotHeight)
    }
}
