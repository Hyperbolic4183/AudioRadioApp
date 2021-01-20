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
    let titleTextField = UITextField()
    let saveButton = UIButton()
    let endButton = UIButton()
    
    weak var delegate: RecordingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(15,53,74)
        titleTextField.delegate = self
        setupStartButton()
        setupTitleTextField()
        setupSaveButton()
        setupEndButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStartButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        startButton.setImage(image, for: .normal)
        startButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        let size = startButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    private func setupTitleTextField() {
        titleTextField.attributedPlaceholder = NSAttributedString(string: "タイトルを入力してください", attributes: [NSAttributedString.Key.foregroundColor : UIColor(101,126,149)])
        titleTextField.textColor = .white
        titleTextField.borderStyle = .roundedRect
        titleTextField.backgroundColor = .black
        addSubview(titleTextField)
        titleTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(startButton.snp.bottom).offset(50)
        }
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("保存する", for: .normal)
        saveButton.setTitleColor(.gray, for: .normal)
        saveButton.isEnabled = false
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
        saveButton.layer.cornerRadius = 5.0
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
        delegate?.save(title: titleTextField.text ?? "新規作成")
        print("入力されたタイトルは\(titleTextField.text)")
        //テキストを渡す
    }
    func textFieldInputted() {
        if titleTextField.text == "" {
            saveButton.titleLabel?.tintColor = .gray
            print("何も入力されていない")
        } else {
            print("何か入力されている")
            saveButton.titleLabel?.tintColor = .black
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textLength = (textField.text! as NSString).replacingCharacters(in: range, with: string).count
        if textLength > 0 && textLength < 25 {
            saveButton.setTitleColor(.black, for: .normal)
            saveButton.isEnabled = true
            return true
        } else {
            saveButton.setTitleColor(.gray, for: .normal)
            saveButton.isEnabled = false
            return true
        }
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
