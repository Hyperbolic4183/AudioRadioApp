//
//  Audio.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit

class AudioTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        print("init")
        super.init(frame: frame, style: .plain)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        delegate = self
        dataSource = self
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AudioTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
