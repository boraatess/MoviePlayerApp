//
//  PlayerViewRouter.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit

class PlayerViewRouter {
    
    let screen = UIScreen.main.bounds
    var view = PlayerViewController()
    
    func prepareView() -> UIViewController {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screen.width/2, height: 44))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .black
        label.text = "VideoPlayer"
        label.font = UIFont(name: "AvenirNext-Heavy", size: 24)
        self.view.navigationItem.titleView = label
        return view
    }
    
}
