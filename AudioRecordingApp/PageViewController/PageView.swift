//
//  PageView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/07.
//

import UIKit

class PageView: UIView {

    let startButton = UIButton()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor(25, 51, 75)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
