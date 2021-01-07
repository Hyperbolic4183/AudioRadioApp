//
//  DraftView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/07.
//

import UIKit
import SnapKit

protocol DraftViewDelegate: class {
    func dissmiss()
}

class DraftView: UIView {
    
    let startButton = UIButton()
    let titleTextField = UITextField()
    let saveButton = UIButton()
    let endButton = UIButton()
    
    weak var delegate: DraftViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(255, 255, 255)
        setupStartButton()
        setupTitleTextField()
        setupSaveButton()
        setupEndButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStartButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(.red, renderingMode: .alwaysOriginal)
        startButton.setImage(image, for: .normal)
        let size = startButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.center.equalToSuperview()
        }
    }
    
    private func setupTitleTextField() {
        titleTextField.placeholder = "タイトルを入力してください"
        addSubview(titleTextField)
        titleTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(startButton.snp.bottom).offset(50)
        }
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("保存する", for: .normal)
        saveButton.backgroundColor = .green
        let size = saveButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleTextField.snp.bottom).offset(50)
        }
    }
    
    private func setupEndButton() {
        let image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default))?.withTintColor(.black, renderingMode: .alwaysOriginal)
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
    
    @objc func endButtonTapped() {
        print("test endButtonTapped")
        delegate?.dissmiss()
    }
}

