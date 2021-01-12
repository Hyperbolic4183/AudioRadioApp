//
//  PlayingViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit

class PlayingViewController: UIViewController {
    let audioTitle: String
    let audioPath: String
    
    init(audioTitle: String, audioPath: String) {
        self.audioTitle = audioTitle
        self.audioPath = audioPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var playingView = PlayingView(frame: CGRect(), title: audioTitle, path: audioPath)
    
    override func loadView() {
        view = playingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = playingView.title
    }
}
