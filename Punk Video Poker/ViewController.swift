//
//  ViewController.swift
//  Punk Video Poker
//
//  Created by Daniel Gheorghe on 10/10/2016.
//  Copyright © 2016 The CodePunker. All rights reserved.
//

import UIKit;
import AVKit;
import AVFoundation;

class ViewController: UIViewController {

    var moviePlayer: AVPlayer?
    var moviePlayerViewController: AVPlayerViewController?

    func playVideo() {
        self.moviePlayerViewController = AVPlayerViewController()
        let path = Bundle.main.path(forResource: "1", ofType: "mp4");
        let url = NSURL.fileURL(withPath: path!)
        self.moviePlayer = AVPlayer(url: url);

        self.moviePlayerViewController!.showsPlaybackControls = false;
        self.moviePlayerViewController!.player = moviePlayer;
        self.present(self.moviePlayerViewController!, animated: true) {
            self.moviePlayerViewController!.player!.play()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.moviePlayer?.currentItem)
    }
    
    func playerDidFinishPlaying() {
        NotificationCenter.default.removeObserver(self);
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "appInitializedOnce");
        
        OperationQueue.main.addOperation {
            let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "Game") as! GameViewController
            self.moviePlayerViewController?.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.playVideo();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

