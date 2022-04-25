//
//  HomeTableviewCell.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit
import SnapKit

class HomeTableviewCell: UITableViewCell {
    
    let genreName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
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
        contentView.addSubview(genreName)
        genreName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
    }
    
}
