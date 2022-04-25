//
//  MovieListViewController.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController {
    
    var genreID: Int?
    var page = 1
    public static var movielistModelstring : MovieListModelString?

    private lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MovieListTableviewCell.self, forCellReuseIdentifier: "movieListCell")
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        getMovieList()
    }
    
    func getMovieList() {
        NetworkManager().getMovieList(genres: String(genreID ?? 0),page: String(page)) { response in
            print(response)
            MovieListViewController.movielistModelstring = response
        }
    }
}

extension MovieListViewController {
    
    func layout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let response = MovieListViewController.movielistModelstring?.results
        
        return response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell", for: indexPath) as! MovieListTableviewCell
        guard let response = MovieListViewController.movielistModelstring?.results?[indexPath.row] else { return UITableViewCell() }
        cell.refreshCell(response: response)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PlayerViewRouter().prepareView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            print("fetch more")

            guard !NetworkManager().isPaginating else {
                return
            }
            
            tableView.tableFooterView = createSpinnerFooter()
            
            let pageInt = self.page + 1
            let pageS = pageInt
            self.page = pageS
            
            print(pageS)
            
            NetworkManager().getMovieList(genres: String(self.genreID ?? 0), pagination: true, page: String(pageS)) { response in
                if response.results?.count == 0 {
                    let pageInt = (Int(self.page) ) - 1
                    let pageS = String(pageInt)
                    self.page = Int(pageS) ?? 0
                }
                if response.results?.isEmpty == false {
                    var movieListModelString = MovieListModelString()
                    movieListModelString.page = response.page
                    movieListModelString.results = response.results

                    MovieListViewController.movielistModelstring?.results?.append(contentsOf: response.results!)

                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "newDataNotif"),object: nil))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else {
                    print("error")
                }

                print(response)
            }
        }
        
    }
    
}
