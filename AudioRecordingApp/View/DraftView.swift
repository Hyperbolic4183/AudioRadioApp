//
//  DraftView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/07.
//

import UIKit
import SnapKit

class DraftView: UIView {
    
    let startButton = UIButton()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let saveButton = UIButton()
    let endButton = UIButton()
    
    weak var delegate: RecordingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(15,53,74)
        titleTextField.delegate = self
        setupStartButton()
        setuptitleLabel()
        setupTitleTextField()
        setupSaveButton()
        setupEndButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStartButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        startButton.setImage(image, for: .normal)
        startButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        let size = startButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
    }
    
    private func setupTitleTextField() {
        titleTextField.placeholder = "タイトルを入力してください"
        titleTextField.textColor = .white
        titleTextField.borderStyle = .roundedRect
        titleTextField.backgroundColor = .black
        addSubview(titleTextField)
        titleTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
        }
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("保存する", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = UIColor(255,189,40)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let size = saveButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.width.equalTo(size.width+80)
            $0.height.equalTo(size.height+30)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleTextField.snp.bottom).offset(50)
        }
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
    
    private func setuptitleLabel() {
        titleLabel.text = "タイトル"
        titleLabel.textColor = .white
        let size = titleLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.top.equalTo(startButton.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func endButtonTapped() {
        print("test endButtonTapped")
        delegate?.dismiss()
    }
    
    @objc func playButtonTapped() {
        print("playButtonTapped")
        delegate?.play()
    }
    
    @objc func saveButtonTapped() {
        print("saveButtonTapped")
        delegate?.save()
    }
}

extension DraftView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
