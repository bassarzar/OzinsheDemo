import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {

    
    lazy var posterImageView =
    {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "FavoritePoster")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    lazy var titleLabel =
    {
        let label = UILabel()
        
        label.text = "Қызғалдақтар мекені"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    lazy var subTitleLabel =
    {
        let label = UILabel()
        
        label.text = "2020 • Телехикая • Мультфильм"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    
    lazy var playView =
    {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(named: "Play-Filled"))
        let label = UILabel()
        
        view.backgroundColor = UIColor(named: "F8EEFF")
        view.layer.cornerRadius = 8
        
        label.text = "Қарау"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(named: "9753F0")
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
        }
        
        return view
    }()
    
    lazy var lineView =
    {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI() {
        [posterImageView, titleLabel, subTitleLabel, playView, lineView].forEach {
            contentView.addSubview($0)
        }
        
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.right.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.right.equalToSuperview().inset(24)
        }
        
        playView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(0)
        }
        
    }
    

}
