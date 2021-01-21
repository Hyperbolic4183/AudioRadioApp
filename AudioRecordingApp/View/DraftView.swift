//
//  DraftView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/07.
//

import UIKit
import SnapKit

class DraftView: UIView {
    
    let playButton = UIButton()
    let pauseButton = UIButton()
    let titleTextField = UITextField()
    let saveButton = UIButton()
    let endButton = UIButton()
    
    
    weak var recordingDelegate: RecordingViewDelegate?
    weak var draftPlayingDelegate: DraftPlayingDelegate?
    
    override init(frame: CGRect) {
        //self.path = path
        super.init(frame: frame)
        self.backgroundColor = UIColor(15,53,74)
        titleTextField.delegate = self
        setupPlayButton()
        setupTitleTextField()
        setupSaveButton()
        setupEndButton()
        setupPauseButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        playButton.setImage(image, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        let size = playButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.6)
        }
    }
    private func setupPauseButton() {
        pauseButton.isHidden = true
        let image = UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        pauseButton.setImage(image, for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        let size = playButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(pauseButton)
        pauseButton.snp.makeConstraints {
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
            $0.top.equalTo(playButton.snp.bottom).offset(50)
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
        recordingDelegate?.dismiss()
    }
    
    @objc func playButtonTapped() {
        draftPlayingDelegate?.playback()
        pauseButton.isHidden = false
        playButton.isHidden = true
        
    }
    @objc func pauseButtonTapped() {
        draftPlayingDelegate?.playingPause()
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    
    @objc func saveButtonTapped() {
        recordingDelegate?.save(title: titleTextField.text ?? "新規作成")
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
