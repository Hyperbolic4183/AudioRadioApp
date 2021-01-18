import UIKit

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

let b = Int().time(second: 123)
