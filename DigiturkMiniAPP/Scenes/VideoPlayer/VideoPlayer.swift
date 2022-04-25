//
//  VideoPlayer.swift
//  DigiturkMiniAPP
//
//  Created by bora ateş on 25.04.2022.
//

import AVFoundation
import AVKit
import SnapKit

class StreamingVideoPlayer {
    
    private let playerViewController = AVPlayerViewController()
    
    private let avPlayer = AVPlayer()
    
    private lazy var playerView: UIView = {
        let view = playerViewController.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func add(to view: UIView) {
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func play(url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        avPlayer.replaceCurrentItem(with: playerItem)
        playerViewController.player = avPlayer
        playerViewController.player?.play()
    }
}
