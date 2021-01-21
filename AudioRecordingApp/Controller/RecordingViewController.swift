//
//  RecordingVieweController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit

let notificationOfDraftAudioPlayerFinished = "draftAudioPlayerDidFinishPlaying"
let notificationOfAudioPlayerFinished = "audioPlayerDidFinishPlaying"

class RecordingViewController: UIViewController {
    
    private(set) var recordingView = RecordingView()
    private(set) var draftView:  DraftView?

    
    override func loadView() {
        view = recordingView
    }
    
    var recordingModel: OperationOfRecord?
    var playbackModel: OperationOfPlayback?
    
    override func viewDidLoad() {
        recordingView.recordingDelegate = self
        recordingView.audioRequestDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(notification), name: NSNotification.Name(rawValue: notificationOfDraftAudioPlayerFinished), object: nil)
    }
    @objc func notification() {
        draftView?.playButton.isHidden = false
        draftView?.pauseButton.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .init(rawValue: notificationOfDraftAudioPlayerFinished), object: nil)
    }
}

extension RecordingViewController: RecordingViewDelegate {
    
    func start() {
        recordingModel?.start()
        guard let url = recordingModel?.audioURL else { return }
        print(url)
    }
    
    func recordPause() {
        recordingModel?.pause()
    }
    
    func restart() {
        recordingModel?.restart()
    }
    
    func stop() {
        recordingModel?.stop()
        let url = recordingModel?.audioURL
        guard let _url = url else { return }
        playbackModel = OperationOfPlayback(url: _url)
        draftView = DraftView()
        draftView?.draftPlayingDelegate = self
        draftView?.recordingDelegate = self
        view = draftView
    }
    
    func save(title: String) {
        recordingModel?.save(title: title)
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecordingViewController: AudioRequestDelegate{
    //許可を求めるアラートを出す
    func requestPermission() {
        recordingModel?.requestRecord()
    }
    //拒否されているので、設定し直すアラートを出す
    func showPermissionChangeAlert() {
        print("拒否されてます")
        let alert = UIAlertController(title: "マイクの許可", message: "設定からマイクの使用を許可してください", preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    //許可されている時
    func authorized() {
        recordingModel?.start()
    }
}

extension RecordingViewController: DraftPlayingDelegate {
    func playingPause() {
        playbackModel?.pause()
    }
    
    func playback() {
        playbackModel?.play()
    }
}
