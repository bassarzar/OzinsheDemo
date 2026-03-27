import UIKit
import SnapKit

protocol LanguageProtocol: AnyObject {
    func languageDidChanged()
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: LanguageProtocol?
    var viewTranslation = CGPoint(x: 0, y: 0)
    let languageArray = [["English", "en"], ["Қазақша", "kz"], ["Русский", "ru"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tapGest()
        
        languageTableView.delegate = self
        languageTableView.dataSource = self
    }
    
    
    
    lazy var onView = {
        let view = UIView()

        view.backgroundColor = UIColor(named: "FFFFFF")
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let backToView = UIView()
        
        backToView.backgroundColor = UIColor(named: "D1D5DB tab")
        backToView.layer.cornerRadius = 3
        
        let languageLabel = UILabel()
        
        languageLabel.text = "Тіл"
        languageLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        languageLabel.textColor = UIColor(named: "111827")
        
        view.addSubviews(backToView, languageLabel)
        
        backToView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(21)
            make.size.equalTo(CGSize(width: 64, height: 5))
        }
        
        languageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(backToView).offset(24)
        }
        return view
    }()
    
    
    lazy var languageTableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "languageCell")
        
        return tableView
    }()
    
    
    
    
    func setupUI() {
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(onView)
        onView.addSubview(languageTableView)
        
        
        onView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(303)
        }
        
        languageTableView.snp.makeConstraints { (make) in
            make.top.equalTo(onView).inset(106)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
    
    func tapGest() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func handleDismiss(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
            
        case .changed:
            guard translation.y > 0 else { return }
            onView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            
        case .ended, .cancelled:
            let shouldDismiss =
                translation.y > 120 || velocity.y > 1200
            
            if shouldDismiss {
                dismiss(animated: true)
            } else {
                UIView.animate(
                    withDuration: 0.25,
                    delay: 0,
                    options: [.curveEaseOut, .allowUserInteraction]
                ) {
                    self.onView.transform = .identity
                }
            }
            
        default:
            break
        }
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecieve touch: UITouch) -> Bool {
        
        if (touch.view?.isDescendant(of: onView))! {
            return false
        }
        return true
    }
    
    
    
}



extension LanguageViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
        
        cell.languageLabel.text = languageArray[indexPath.row][0]
        
        if LanguageManager.currentLanguage() == languageArray[indexPath.row][1] {
            cell.checkmark.image = UIImage(named: "checkmark")
        }
        else {
            cell.checkmark.image = nil
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        LanguageManager.setLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChanged()
        dismiss(animated: true, completion: nil)
    }
    
    
}
