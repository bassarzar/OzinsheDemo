import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let identifier = "SearchCollectionViewCell"
    
    lazy var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F3F4F6")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    
    lazy var label: UILabel = {
        let labelCell = UILabel()
        
        labelCell.text = "1111"
        labelCell.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        labelCell.textColor = UIColor(named: "374151")
        labelCell.textAlignment = .center
        
        return labelCell
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor(named: "FFFFFF")
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(label)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(6)
        }
        
    }
    
    
}
