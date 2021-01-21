//
//  MainView.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit
import SnapKit



class MainView: UIView {
    
    let addButton = UIButton()
    private(set) var audioTableView = AudioTableView()
    weak var delegate: MainViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        audioTableView.audioTableViewDelegate = self
        seutpAudioTableView()
        setupAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func seutpAudioTableView() {
        addSubview(audioTableView)
        audioTableView.snp.makeConstraints {
            $0.size.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    private func setupAddButton() {
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default))?.withTintColor(UIColor(15,53,74), renderingMode: .alwaysOriginal)
        addButton.backgroundColor = .orange
        addButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        addButton.setImage(image, for: .normal)
        addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-30)
            $0.width.equalTo(70)
            $0.height.equalTo(70)
        }
        self.addButton.layer.masksToBounds = true
        self.addButton.layer.cornerRadius = CGFloat(35)
    }
    
    @objc func plusButtonTapped() {
        delegate?.plusButtonTapped()
    }
}

extension MainView:AudioTableViewDelegate {
    func didSelectedRow(title: String, audioPath: String) {
        delegate?.didSelectedRow(title: title, audioPath: audioPath)
    }
}
