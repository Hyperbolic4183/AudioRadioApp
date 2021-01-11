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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupPlayButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        playButton.setImage(image, for: .normal)
        let size = sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(size)
        }
    }
}
