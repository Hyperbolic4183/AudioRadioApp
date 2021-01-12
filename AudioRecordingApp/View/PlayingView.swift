//
//  PlayingView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit
import SnapKit

class PlayingView: UIView {
    let playButton = UIButton()
    let testLabel = UILabel()
    let title: String
    let path: String
    let model = OperationOfPlayback()
    
    init(frame: CGRect, title: String, path: String) {
        self.title = title
        self.path = path
        super.init(frame: frame)
        backgroundColor = .yellow
        setupPlayButton()
        setupTestLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        playButton.setImage(image, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        let size = playButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
    }
    
    private func setupTestLabel() {
        testLabel.text = path
        let size = sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }
    }
    
    @objc func playButtonTapped() {
        model.changeCategoryToPlay()
        model.play(audioName: path)
    }
}
