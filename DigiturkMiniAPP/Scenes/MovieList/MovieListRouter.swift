//
//  MovieListRouter.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit

class MovieListRouter {
    
    let screen = UIScreen.main.bounds
    var view = MovieListViewController()
    
    func prepareView(genreName: String, genreId: Int) -> UIViewController {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screen.width/2, height: 44))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .black
        label.text = genreName
        label.font = UIFont(name: "AvenirNext-Heavy", size: 24)
        self.view.navigationItem.titleView = label
        view.genreID = genreId
        return view
    }
    
}
