//
//  ViewController.swift
//  K05cios
//
//  Created by Martin Randelzofer on 19.06.20.
//  Copyright © 2020 Martin Randelzofer. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        startPlayingVideo()
    }
    
    func startPlayingVideo(){
        let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "video", ofType: "mp4")!)
        let asset: AVAsset = AVAsset(url: videoUrl)
        print(asset.duration)
        let playerItem = AVPlayerItem(asset: asset)
        queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        let playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        queuePlayer.play()
    }
}

