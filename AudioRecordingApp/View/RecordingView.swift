//
//  RecordingView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit
import SnapKit



class RecordingView: UIView {
    let windowRect = UIScreen.main.bounds
    let startButton = UIButton()
    let pauseButton = UIButton()
    let restartButton = UIButton()
    let stopButton = UIButton()
    
    weak var delegate: RecordingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupStartButton()
        setupPauseButton()
        setupRestartButton()
        setupStopButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupStartButton() {
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("収録開始", for: .normal)
        startButton.backgroundColor = .blue
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchDown)
        let size = startButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
        }
        print("recordingButtonの状態は\(startButton.isSelected)")
    }
    
    private func setupPauseButton() {
        pauseButton.isHidden = true
        pauseButton.setTitle("一時停止する", for: .normal)
        pauseButton.backgroundColor = .green
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchDown)
        let size = pauseButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(pauseButton)
        pauseButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupRestartButton() {
        restartButton.isHidden = true
        restartButton.setTitle("再開する", for: .normal)
        restartButton.backgroundColor = .green
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchDown)
        let size = restartButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(restartButton)
        restartButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupStopButton() {
        stopButton.isHidden = true
        stopButton.setTitle("停止する", for: .normal)
        stopButton.backgroundColor = .orange
        let size = stopButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.left.equalTo(restartButton.snp.right)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func startButtonTapped() {
        //delegate?.stop()
        //delegate?.recording()
        //startButton.isHidden = true
        startButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    @objc func recordAddButtonTapped() {
        delegate?.add()
    }
    
    @objc func pauseButtonTapped() {
        //delegate?.pause()
        pauseButton.isHidden = true
        restartButton.isHidden = false
        stopButton.isHidden = false
    }
    
    @objc func restartButtonTapped() {
        stopButton.isHidden = true
        restartButton.isHidden = true
        pauseButton.isHidden = false
    }
}


