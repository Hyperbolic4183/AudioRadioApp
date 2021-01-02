//
//  RecordingView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit
import SnapKit

protocol RecordingViewDelegate: class {
    func recording()
    func stop()
}

class RecordingView: UIView {
    let recordingButton = UIButton()
    let titleTextfield = UITextField()
    weak var delegate: RecordingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRecordingButton()
        setupRecordingTitleTextfield()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupRecordingButton() {
        
        recordingButton.setTitleColor(.black, for: .normal)
        recordingButton.setTitle("録音する", for: .normal)
        recordingButton.setTitleColor(.white, for: .normal)
        recordingButton.backgroundColor(.red, for: .normal)
        
        recordingButton.setTitle("停止する", for: .selected)
        recordingButton.setTitleColor(.black, for: .selected)
        recordingButton.backgroundColor(.yellow, for: .selected)
        
        recordingButton.backgroundColor = .yellow
        recordingButton.layer.cornerRadius = 50
        
        recordingButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchDown)
        addSubview(recordingButton)
        recordingButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        print("recordingButtonの状態は\(recordingButton.isSelected)")
    }
    
    @objc func recordButtonTapped() {
        if recordingButton.isSelected {
            delegate?.stop()
        } else {
            delegate?.recording()
        }
        recordingButton.isSelected = !recordingButton.isSelected
    }
    
    private func setupRecordingTitleTextfield() {
        titleTextfield.placeholder = "タイトルを入力してください"
        addSubview(titleTextfield)
        titleTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(recordingButton.snp.top)
        }
        
    }
}


