//
//  MovieListTableviewCell.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MovieListTableviewCell: UITableViewCell {
    
    let screen = UIScreen.main.bounds
    
    let movieName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let posterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    func layout() {
        contentView.addSubview(movieName)
        movieName.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(screen.width/2)
        }
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
           // make.trailing.equalTo(self.movieName.snp.leading)
        }
        contentView.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.movieName.snp.bottom)
           // make.leading.equalTo(self.posterImage.snp.trailing)
            make.width.equalTo(screen.width/2)
        }
    }
    
    func refreshCell(response: Result) {
        movieName.text = response.originalTitle
        let path = response.posterPath
        let basePath = Constants.posterPath
        let urlString = basePath + path
        let imageUrl = URL(string: urlString)
        posterImage.kf.setImage(with: imageUrl)
        overviewLabel.text = response.overview
    }
    
}
