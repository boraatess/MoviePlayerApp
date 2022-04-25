//
//  PlayerViewController.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import UIKit
import SnapKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var player : AVPlayer?
    
    private let vmPlayer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let videoPlayer = StreamingVideoPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setupVideoPlayer()
    }
    
    func setupVideoPlayer() {
        videoPlayer.add(to: vmPlayer)
        let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
        videoPlayer.play(url: url!)
    }
    
}

extension PlayerViewController {
    
    func layout() {
        view.backgroundColor = .white
        view.addSubview(vmPlayer)
        vmPlayer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
