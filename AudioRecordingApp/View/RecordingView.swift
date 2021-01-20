//
//  RecordingView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit
import SnapKit
import AVFoundation

class RecordingView: UIView {
    let windowRect = UIScreen.main.bounds
    let startButton = UIButton()
    let pauseButton = UIButton()
    let restartButton = UIButton()
    let stopButton = UIButton()
    let endButton = UIButton()
    let timerLabel = UILabel()
    let side = 130
    var counter = -1
    var timer: Timer!
    
    weak var recordingDelegate: RecordingViewDelegate?
    weak var audioRequestDelegate: AudioRequestDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(255, 189, 40)
        setupStartButton()
        setupPauseButton()
        setupRestartButton()
        setupStopButton()
        setupEndButton()
        setupTimerLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupStartButton() {
        let image = UIImage(systemName: "mic", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let SizeOfImageView = imageView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        startButton.setTitleColor(.black, for: .normal)
        startButton.setTitle("収録開始", for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        startButton.backgroundColor = .white
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchDown)
        let size = startButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        startButton.setImage(image, for: .normal)
        startButton.imageEdgeInsets = UIEdgeInsets(top: -size.height/2-SizeOfImageView.height/2, left: 0, bottom: 0, right: -size.width)
        startButton.titleEdgeInsets = UIEdgeInsets(top: size.height/2+SizeOfImageView.height/2, left: -SizeOfImageView.width, bottom: 0, right: 0)
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(side)
            $0.height.equalTo(side)
        }
        self.startButton.layer.masksToBounds = true
        self.startButton.layer.cornerRadius = CGFloat((side)/2)
    }
    
    private func setupPauseButton() {
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let sizeOfImageView = imageView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        pauseButton.isHidden = true
        pauseButton.setTitle("一時停止する", for: .normal)
        pauseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.backgroundColor = .white
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchDown)
        let size = pauseButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        pauseButton.setImage(image, for: .normal)
        pauseButton.imageEdgeInsets = UIEdgeInsets(top: -size.height/2-sizeOfImageView.height/2, left: 0, bottom: 0, right: -size.width)
        pauseButton.titleEdgeInsets = UIEdgeInsets(top: size.height/2+sizeOfImageView.height/2, left: -sizeOfImageView.width, bottom: 0, right: 0)
        addSubview(pauseButton)
        pauseButton.snp.makeConstraints {
            $0.width.equalTo(self.side)
            $0.height.equalTo(self.side)
            $0.center.equalToSuperview()
        }
        pauseButton.layer.cornerRadius = CGFloat(self.side/2)
        pauseButton.layer.masksToBounds = true
    }
    
    private func setupRestartButton() {
        let image = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))?.withTintColor(.black,renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let sizeOfImageView = imageView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        restartButton.isHidden = true
        restartButton.setTitle("再開する", for: .normal)
        restartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        restartButton.setTitleColor(.black, for: .normal)
        restartButton.backgroundColor = .white
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchDown)
        let size = restartButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        restartButton.setImage(image, for: .normal)
        restartButton.imageEdgeInsets = UIEdgeInsets(top: -size.height/2-sizeOfImageView.height/2, left: 0, bottom: 0, right: -size.width)
        restartButton.titleEdgeInsets = UIEdgeInsets(top: size.height/2+sizeOfImageView.height/2, left: -sizeOfImageView.width, bottom: 0, right: 0)
        addSubview(restartButton)
        restartButton.snp.makeConstraints {
            $0.width.equalTo(self.side)
            $0.height.equalTo(self.side)
            $0.center.equalToSuperview()
        }
        restartButton.layer.cornerRadius = CGFloat(self.side/2)
        restartButton.layer.masksToBounds = true
    }
    
    private func setupStopButton() {
        let image = UIImage(systemName: "stop", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let sizeOfImageView = imageView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        stopButton.isHidden = true
        stopButton.setTitle("停止する", for: .normal)
        stopButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        stopButton.backgroundColor = .orange
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchDown)
        let size = stopButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        stopButton.setImage(image, for: .normal)
        stopButton.imageEdgeInsets = UIEdgeInsets(top: -size.height/2-sizeOfImageView.height/2, left: 0, bottom: 0, right: -size.width)
        stopButton.titleEdgeInsets = UIEdgeInsets(top: size.height/2+sizeOfImageView.height/2, left: -sizeOfImageView.width, bottom: 0, right: 0)
        addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.centerX.equalTo(restartButton.snp.right)
            $0.centerY.equalTo(restartButton.snp.bottom)
        }
        stopButton.layer.cornerRadius = CGFloat(50)
        stopButton.layer.masksToBounds = true
    }
    
    private func setupEndButton() {
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        endButton.setImage(image, for: .normal)
        endButton.addTarget(self, action: #selector(endButtonTapped), for: .touchDown)
        let size = endButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(endButton)
        endButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.left.equalToSuperview().offset(30)
            if #available(iOS 11, *) {
                $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            } else {
                $0.top.equalToSuperview().offset(20)
            }
        }
    }
    
    private func setupTimerLabel() {
        timerLabel.isHidden = true
        timerLabel.font = UIFont.systemFont(ofSize: 25)
        timerLabel.textAlignment = .center
        addSubview(timerLabel)
        
        timerLabel.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.bottom.equalTo(startButton.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func startButtonTapped() {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        if status == AVAuthorizationStatus.authorized {
            startButton.isHidden = true
            pauseButton.isHidden = false
            timerLabel.isHidden = false
            recordingDelegate?.start()
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
            
        } else if status == AVAuthorizationStatus.restricted {
            audioRequestDelegate?.showPermissionChangeAlert()
        } else if status == AVAuthorizationStatus.notDetermined {
            audioRequestDelegate?.requestPermission()
        } else if status == AVAuthorizationStatus.denied {
            audioRequestDelegate?.showPermissionChangeAlert()
        }
    }
    
    @objc func pauseButtonTapped() {
        pauseButton.isHidden = true
        restartButton.isHidden = false
        stopButton.isHidden = false
        recordingDelegate?.recordPause()
        self.timer.invalidate()
    }
    
    @objc func restartButtonTapped() {
        stopButton.isHidden = true
        restartButton.isHidden = true
        pauseButton.isHidden = false
        recordingDelegate?.restart()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    }
    
    @objc func stopButtonTapped() {
        recordingDelegate?.stop()
        restartButton.isHidden = true
        stopButton.isHidden = true
        startButton.isHidden = false
    }
    
    @objc func endButtonTapped() {
        recordingDelegate?.dismiss()
    }
    
    @objc func timerStarted() {
        let int = Int()
        counter += 1
        timerLabel.text = "\(int.time(second: counter))"
    }
}



