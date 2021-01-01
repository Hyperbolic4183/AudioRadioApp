//
//  PlaybackViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit

class PlaybackViewController: UIViewController {

    // ----------Viewの設定----------
    private(set) var recordingView = PlaybackView()
    override func loadView() {
        view = recordingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
