import UIKit
import SnapKit

class LanguageTableViewCell: UITableViewCell {

    let identifier = "languageCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    lazy var languageLabel = {
        let label = UILabel()
        
        label.text = "Қазақша"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    
    lazy var checkmark = {
        let image = UIImageView()
        
        image.image = UIImage(named: "checkmark")
        
        return image
    }()
    
    
    lazy var lineView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB tab")
        
        return view
    }()
    
    
    
    func setupUI() {
        
        contentView.backgroundColor = UIColor(named: "FFFFFF")
        contentView.addSubviews(languageLabel, checkmark, lineView)
        
        languageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        checkmark.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        lineView.snp.makeConstraints { (make) in
            make.right.left.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    

}
