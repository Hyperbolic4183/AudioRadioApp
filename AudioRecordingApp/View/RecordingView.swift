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
    let side = 130
    
    weak var delegate: RecordingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(255, 189, 40)
        setupStartButton()
        setupPauseButton()
        setupRestartButton()
        setupStopButton()
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
        startButton.backgroundColor = .white
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchDown)
        let size = startButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        startButton.setImage(image, for: .normal)
        startButton.imageEdgeInsets = UIEdgeInsets(top: -size.height/2-SizeOfImageView.height/2, left: 0, bottom: 0, right: -size.width)
        startButton.titleEdgeInsets = UIEdgeInsets(top: size.height/2+SizeOfImageView.height/2, left: -SizeOfImageView.width, bottom: 0, right: 0)
        addSubview(startButton)
        let side = size.width+50
        startButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(side)
            $0.height.equalTo(side)
        }
        self.startButton.layer.masksToBounds = true
        self.startButton.layer.cornerRadius = (side)/2
        //print(side)124
    }
    
    private func setupPauseButton() {
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let sizeOfImageView = imageView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        pauseButton.isHidden = true
        pauseButton.setTitle("一時停止する", for: .normal)
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
        let image = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light))?.withTintColor(.black,renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let sizeOfImageView = imageView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        restartButton.isHidden = true
        restartButton.setTitle("再開する", for: .normal)
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
        stopButton.backgroundColor = .orange
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchDown)
        let size = stopButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        stopButton.setImage(image, for: .normal)
        stopButton.imageEdgeInsets = UIEdgeInsets(top: -size.height/2-sizeOfImageView.height/2, left: 0, bottom: 0, right: -size.width)
        stopButton.titleEdgeInsets = UIEdgeInsets(top: size.height/2+sizeOfImageView.height/2, left: -sizeOfImageView.width, bottom: 0, right: 0)
        addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.width.equalTo(side)
            $0.height.equalTo(side)
            $0.left.equalTo(restartButton.snp.right)
            $0.centerY.equalToSuperview()
        }
        stopButton.layer.cornerRadius = CGFloat(side/2)
        stopButton.layer.masksToBounds = true
    }
    
    @objc func startButtonTapped() {
        startButton.isHidden = true
        pauseButton.isHidden = false
        delegate?.start()
    }
    
    @objc func recordAddButtonTapped() {
        delegate?.add()
    }
    
    @objc func pauseButtonTapped() {
        pauseButton.isHidden = true
        restartButton.isHidden = false
        stopButton.isHidden = false
        delegate?.pause()
    }
    
    @objc func restartButtonTapped() {
        stopButton.isHidden = true
        restartButton.isHidden = true
        pauseButton.isHidden = false
        delegate?.restart()
    }
    
    @objc func stopButtonTapped() {
        delegate?.stop()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            restartButton.isHidden = true
            stopButton.isHidden = true
            startButton.isHidden = false
        }
    }
}


