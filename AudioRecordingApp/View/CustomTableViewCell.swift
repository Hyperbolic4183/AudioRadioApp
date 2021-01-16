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
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIView()
        setupcellLabel()
        setupDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUIView() {
        print("contentViewは\(contentView.frame)")
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
        titleLabel.text = "ssssあ"
        let size = titleLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(size)
        }
    }
    private func setupDateLabel() {
        dateLabel.text = "あああああああああああ"
        let size = dateLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        backView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(titleLabel.snp.right).offset(50)
            $0.size.equalTo(size)
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
