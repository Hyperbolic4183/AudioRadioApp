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
    let recordingButton = UIButton()
    let pauseButton = UIButton()
    let stopButton = UIButton()
    
    weak var delegate: RecordingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupRecordingButton()
        setupPauseButton()
        setupStopButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupRecordingButton() {
        recordingButton.setTitleColor(.black, for: .normal)
        recordingButton.setTitle("録音する", for: .normal)
        recordingButton.setTitleColor(.white, for: .normal)
        recordingButton.backgroundColor(.red, for: .normal)
        
        recordingButton.setTitle("録音中", for: .selected)
        recordingButton.setTitleColor(.black, for: .selected)
        recordingButton.backgroundColor(.yellow, for: .selected)
        
        recordingButton.backgroundColor = .yellow
        recordingButton.layer.cornerRadius = 50
        
        recordingButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchDown)
        let size = recordingButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(recordingButton)
        recordingButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
        }
        print("recordingButtonの状態は\(recordingButton.isSelected)")
    }
    
    private func setupPauseButton() {
        pauseButton.isHidden = true
        pauseButton.setTitle("一時停止", for: .normal)
        let size = pauseButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        pauseButton.backgroundColor = .red
        addSubview(pauseButton)
        pauseButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview().offset(-windowRect.width/4)
            $0.centerY.equalToSuperview().offset(windowRect.height/4)
        }
    }
    
    private func setupStopButton() {
        stopButton.isHidden = true
        stopButton.setTitle("停止", for: .normal)
        let size: CGSize = stopButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        stopButton.backgroundColor = .cyan
        addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview().offset(windowRect.width/4)
            $0.centerY.equalToSuperview().offset(windowRect.height/4)
        }
    }
    
    @objc func recordButtonTapped() {
        if recordingButton.isSelected {
            delegate?.stop()
        } else {
            delegate?.recording()
        }
        recordingButton.isSelected = !recordingButton.isSelected
        stopButton.isHidden = false
        pauseButton.isHidden = false
    }
    
    @objc func recordAddButtonTapped() {
        delegate?.add()
    }
}


