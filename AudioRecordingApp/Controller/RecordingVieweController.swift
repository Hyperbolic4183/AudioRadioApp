//
//  RecordingVieweController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit

class RecordingVieweController: UIViewController {
    
    // ----------Viewの設定----------
    private(set) var recordingView = RecordingView()
    override func loadView() {
        view = recordingView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
}
