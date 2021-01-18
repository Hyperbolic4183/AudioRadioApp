//
//  CustomTableViewCell.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/16.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let backView = UIView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIView()
        setupcellLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        print("setHighlighted")
        
    }
    
    private func setupUIView() {
        backView.backgroundColor = UIColor(255,189,40)
        backView.layer.cornerRadius = 5
        addSubview(backView)
        backView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.9)
            $0.center.equalToSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        super.touchesBegan(touches, with: event)
        backView.backgroundColor = UIColor(233,201,54)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        backView.backgroundColor = UIColor(255,189,40)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        backView.backgroundColor = UIColor(255,189,40)
    }
    
    private func setupcellLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(50)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        print("selected")
        addSubview(backView)
    }
}
