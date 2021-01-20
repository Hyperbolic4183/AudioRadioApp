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
    var model: OperationOfRecord?
    
    override func viewDidLoad() {
        recordingView.recordingDelegate = self
        recordingView.audioRequestDelegate = self
        draftView.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        model?.audioPlayer = nil
        model = nil
    }
}

extension RecordingViewController: RecordingViewDelegate {
    
    func start() {
        model?.start()
    }
    
    func pause() {
        model?.pause()
    }
    
    func restart() {
        model?.restart()
    }
    
    func stop() {
        model?.stop()
        view = draftView
    }
    
    func save(title: String) {
        model?.save(title: title)
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismiss() {
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
    }
    
    func play() {
        model?.play()
    }
}

extension RecordingViewController: AudioRequestDelegate{
    //許可を求めるアラートを出す
    func requestPermission() {
        model?.requestRecord()
    }
    //拒否されているので、設定し直すアラートを出す
    func showPermissionChangeAlert() {
        print("拒否されてます")
        let alert = UIAlertController(title: "マイクの許可", message: "設定からマイクの使用を許可してください", preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    //許可されている時
    func authorized() {
        model?.start()
    }
}
