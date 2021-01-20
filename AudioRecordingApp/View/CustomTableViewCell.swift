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
        self.selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        backView.backgroundColor = selected ? UIColor(255,226,146) : UIColor(255,189,40)
    }
}
