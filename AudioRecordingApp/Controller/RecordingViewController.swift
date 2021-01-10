//
//  RecordingVieweController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit

class RecordingViewController: UIViewController {
    
    // ----------Viewの設定----------
    private(set) var recordingView = RecordingView()
    private(set) var draftView = DraftView()
    
    override func loadView() {
        view = recordingView
    }
    
    // ----------Modelの設定----------
    var model = RecordingModel()
    
    override func viewDidLoad() {
        recordingView.delegate = self
        draftView.delegate = self
    }
    
}

extension RecordingViewController: RecordingViewDelegate {
    
    func start() {
        model.start()
    }
    
    func pause() {
        model.pause()
    }
    
    func restart() {
        model.restart()
    }
    
    func stop() {
        model.stop()
        view = draftView
    }
    
    func save() {
        model.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismiss() {
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
    }
    
    func play() {
        model.play()
    }
}
