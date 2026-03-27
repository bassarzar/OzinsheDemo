import UIKit

class CategoryTableViewController: UITableViewController {
    
    let identifier = "SearchTableViewController"
    
    var categoryID: Int = 0
    var categoryName: String = ""
    
    var isLoading: Bool = false
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableCell")
        
        self.title = categoryName
        navigationItem.title = categoryName
        
        downloadMoviesByCategory()
    }
    
    @objc func handleRefresh() {
        if !isLoading {
            isLoading = true
            movies.removeAll()
            tableView.reloadData()
            downloadMoviesByCategory()
        }
    }
    
    func downloadMoviesByCategory() {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieTableCell",
            for: indexPath
        ) as! MovieTableViewCell
        
        cell.setData(movie: movies[indexPath.row])
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 153
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let movieInfoVC = MovieInfoController()
        
        movieInfoVC.movie = movies[indexPath.row]
        navigationController?.show(movieInfoVC, sender: self)
    }
    
    
}
