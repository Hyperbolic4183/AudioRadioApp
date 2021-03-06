//
//  Extensions.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import UIKit

extension UIColor {

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int = 255) {
        let rgba = [red, green, blue, alpha].map { i -> CGFloat in
            switch i {
            case let i where i < 0:
                return 0
            case let i where i > 255:
                return 1
            default:
                return CGFloat(i) / 255
            }
        }
        self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
}

extension Int {
    func multi(num: Int) -> Int {
        return num * 2
    }
    func time(second: Int) -> String {
        var second = second
        let hour = second / 3600
        second %= 3600
        let minute = second / 60
        second %= 60
        
        if hour == 0 {
            if minute == 0 {
                return "\(second)秒"
            } else {
                return "\(minute)分\(second)秒"
            }
        } else {
            if minute == 0 {
                return "\(hour)時間\(second)秒"
            } else {
                return "\(hour)時間\(minute)分\(second)秒"
            }
        }
    }
}
