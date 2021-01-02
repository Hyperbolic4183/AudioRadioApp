//
//  Extensions.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import UIKit

extension UIButton {
    func backgroundColor(_ color: UIColor?, for state: UIControl.State) {
        let backgroundColor = color?.image
        if self.state == .normal {
            setBackgroundImage(backgroundColor, for: state)
        } else if self.state == .selected {
            setBackgroundImage(backgroundColor, for: state)
        }
    }
}

extension UIColor {
    var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
