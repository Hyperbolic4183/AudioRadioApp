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
    
    // ----------Modelの設定----------
    var model = RecordingModel()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        recordingView.delegate = self
    }
    
}

extension RecordingVieweController: RecordingViewDelegate {
    func recording() {
        model.record()
    }
}
