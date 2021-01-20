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
    var timer: Timer!
    
    init(audioTitle: String, audioPath: String) {
        print("pathは\(audioPath)です")//pathは21012015525610.m4aです
        self.audioTitle = audioTitle
        self.audioPath = audioPath
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notification), name: NSNotification.Name(rawValue: "audioPlayerDidFinishPlaying"), object: nil)
    }
    
    @objc func notification() {
        print("終了した")
        self.playingView.isPlaying.toggle()
        self.playingView.playButton.isHidden = false
        self.playingView.pauseButton .isHidden = true
        self.playingView.playingslider.value = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var playingView = PlayingView(frame: CGRect(), title: audioTitle, path: audioPath)
    var playbackModel: OperationOfPlayback? 
    
    override func loadView() {
        view = playingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = playingView.title
        playingView.delegate = self
        playbackModel = OperationOfPlayback(fileName: audioPath)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        playbackModel?.audioPlayer = nil
        NotificationCenter.default.removeObserver(self, name: .init(rawValue: "audioPlayerDidFinishPlaying"), object: nil)
    }
    
    func valueOfSliderChange() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(tameHasPassed), userInfo: nil, repeats: true)
    }
    
    @objc func tameHasPassed() {
        guard let currentTime = playbackModel?.audioPlayer?.currentTime, currentTime > 0 else { return }
        playingView.playingslider.value = Float(currentTime)
    }
}

extension PlayingViewController: PlayingDelegate {
    func forward10() {
        playbackModel?.audioPlayer?.currentTime += 10
    }
    
    func goback10() {
        playbackModel?.audioPlayer?.currentTime -= 10
    }
    
    func valueChanged() {
        playbackModel?.audioPlayer?.currentTime = TimeInterval(playingView.playingslider.value)
    }
    
    func playback() {
        guard let _duration = playbackModel?.audioPlayer?.duration, _duration > 0 else {
            print("durationが存在しない")
            return
        }
        playingView.playingslider.maximumValue = Float(_duration)
        playbackModel?.play()
        valueOfSliderChange()
    }
    
    func pause() {
        playbackModel?.pause()
        playingView.playingslider.value = Float(playbackModel?.audioPlayer?.currentTime ?? 0)
    }
}
