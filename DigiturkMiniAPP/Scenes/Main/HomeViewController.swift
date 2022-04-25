//
//  HomeViewController.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 20.04.2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HomeTableviewCell.self, forCellReuseIdentifier: "homeCell")
        return tableview
    }()
    var genreList: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("app started")
        layout()
        sendRequest()
    }
    
    func sendRequest() {
        NetworkManager().getGenresList { [weak self] response in
            print(response)
            DispatchQueue.main.async {
                self?.genreList = response.genres
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController {
    
    func layout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableviewCell
        cell.genreName.text = genreList?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = genreList?[indexPath.row].name ?? ""
        let id = genreList?[indexPath.row].id ?? 0
        let vc = MovieListRouter().prepareView(genreName: name, genreId: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
