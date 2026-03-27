import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        attributes?.forEach { layoutAttribute in

            guard layoutAttribute.representedElementCategory == .cell else { return }

            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
    
}

class SearchViewController: UIViewController {

    var isLoading: Bool = false
    var categories: [Category] = []
    var movies: [Movie] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Іздеу"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchTextField.delegate = self
        
        removeButton.isHidden = true
        tableView.isHidden = true

        hideKeyboardWhenTappedAround()
        downloadCategories()
        addViews()
    }
    
    


    lazy var searchTextField: TextFieldWithPadding = {
        let searchTF = TextFieldWithPadding()
        
        searchTF.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        searchTF.placeholder = "Іздеу"
        searchTF.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        searchTF.textColor = UIColor(named: "9CA3AF")
        searchTF.layer.borderWidth = 1.0
        searchTF.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        searchTF.layer.cornerRadius = 12
        
        return searchTF
    }()

    
    lazy var removeButton: UIButton = {
        let removeButton = UIButton()
        
        removeButton.setImage(UIImage(named: "removeButton"), for: .normal)
        removeButton.contentMode = .scaleToFill
        removeButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        
        return removeButton
    }()
    

    lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.backgroundColor = UIColor(named: "F3F4F6")
        searchButton.layer.cornerRadius = 12
        searchButton.tintColor = UIColor(named: "111827")
        searchButton.contentMode = .scaleToFill
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return searchButton
    }()
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Санаттар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    

    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionView.backgroundColor = UIColor(named: "111827D")
        
        return collectionView
    }()
    

    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "FFFFFF")
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableCell")
        
        return tableView
    }()

    
    

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func clearTextField() {
        searchTextField.text = ""
        downloadSearchMovies()
    }

    @objc func searchButtonTapped() {
        downloadSearchMovies()
    }

    func downloadCategories() {
        categories = [
            Category(id: 1, name: "Телехикая"),
            Category(id: 2, name: "Ситком"),
            Category(id: 3, name: "Көркем фильм"),
            Category(id: 4, name: "Мультфильм"),
            Category(id: 5, name: "Мультсериал"),
            Category(id: 6, name: "Аниме"),
            Category(id: 7, name: "Тв-бағдарлама және реалити-шоу"),
            Category(id: 8, name: "Деректі фильм"),
            Category(id: 9, name: "Музыка"),
            Category(id: 10, name: "Шетел фильмдері")
        ]
        collectionView.reloadData()
    }

    func addViews() {
        view.backgroundColor = UIColor(named: "111827D")

        view.addSubviews(searchButton, searchTextField, removeButton, titleLabel, collectionView, tableView)
       

        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(96)
            make.height.equalTo(56)
        }

        removeButton.snp.makeConstraints { make in
            make.height.width.equalTo(52)
            make.right.equalTo(searchTextField.snp.right)
            make.centerY.equalTo(searchTextField)
        }

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.right.equalToSuperview().inset(24)
            make.width.height.equalTo(56)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(searchTextField.snp.bottom).offset(35)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(collectionView.snp.bottom)
        }
        
    }
    
    
    
    

    func downloadSearchMovies() {
        guard let text = searchTextField.text else { return }

        if text.isEmpty {

            titleLabel.text = "Санаттар"
            collectionView.isHidden = false
            tableView.isHidden = true
            movies.removeAll()
            tableView.reloadData()
            removeButton.isHidden = true
            
            return
        }
        titleLabel.text = "Іздеу нәтижелері"
        collectionView.isHidden = true
        tableView.isHidden = false
        removeButton.isHidden = false
    }
}



extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell",
                                                 for: indexPath) as! MovieTableViewCell

        cell.setData(movie: movies[indexPath.row])
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = MovieInfoController()
        
        movieInfoVC.movie = movies[indexPath.row]
        navigationController?.show(movieInfoVC, sender: self)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchCollectionViewCell",
            for: indexPath
        ) as! SearchCollectionViewCell

        cell.label.text = categories[indexPath.row].name
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let categoryVC = CategoryTableViewController()
        
        categoryVC.categoryID = categories[indexPath.row].id
        categoryVC.categoryName = categories[indexPath.row].name

        navigationController?.show(categoryVC, sender: self)
    }
    
}



extension SearchViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == searchTextField {
            searchTextField.layer.borderColor =
            UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1).cgColor
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField == searchTextField {
            searchTextField.layer.borderColor =
            UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1).cgColor
        }
    }
    
}
