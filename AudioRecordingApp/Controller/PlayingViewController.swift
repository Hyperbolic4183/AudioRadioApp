//
//  PlayingViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit

class PlayingViewController: UIViewController {

    private(set) var playingView = PlayingView()
    
    override func loadView() {
        view = playingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
