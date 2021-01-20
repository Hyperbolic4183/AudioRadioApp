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
    let pauseButton = UIButton()
    let goback10Button = UIButton()
    let goforward10Button = UIButton()
    let playingslider = UISlider()
    var isPlaying = false
    let title: String
    let path: String
    var audioDuration: TimeInterval?
    weak var delegate: PlayingDelegate?
    
    init(frame: CGRect, title: String, path: String) {
        self.title = title
        self.path = path
        super.init(frame: frame)
        backgroundColor = UIColor(15,53,74)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupPlayingSlider()
        setupPauseButton()
        setupPlayButton()
        setupForward15Button()
        setupBack15Button()
    }
    
    private func setupPlayButton() {
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        playButton.setImage(image, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        let size = playButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playingslider.snp.bottom)
        }
    }
    
    private func setupPauseButton() {
        pauseButton.isHidden = true
        let image = UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        pauseButton.setImage(image, for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        let size = pauseButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(pauseButton)
        pauseButton.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playingslider.snp.bottom)
        }
    }
    
    private func setupPlayingSlider() {
        playingslider.minimumValue = 0
        playingslider.value = 0
        playingslider.thumbTintColor = UIColor(255,189,40)
        playingslider.minimumTrackTintColor = UIColor.white
        playingslider.addTarget(self, action: #selector(sliderTouchUpedInside), for: .touchUpInside)
        playingslider.addTarget(self, action: #selector(sliderDidChangedValue), for: .valueChanged)
        addSubview(playingslider)
        playingslider.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func setSliderValue(maximumValue: TimeInterval) {
        playingslider.maximumValue = Float(maximumValue)
    }
    
    private func setupForward15Button() {
        let image = UIImage(systemName: "goforward.10", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        goforward10Button.setImage(image, for: .normal)
        goforward10Button.addTarget(self, action: #selector(forward15ButtonTapped), for: .touchUpInside)
        let size = pauseButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(goforward10Button)
        goforward10Button.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.left.equalTo(playButton.snp.right).offset(50)
            $0.centerY.equalTo(playButton.snp.centerY)
        }
    }
    
    private func setupBack15Button() {
        let image = UIImage(systemName: "gobackward.10", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))?.withTintColor(UIColor(255,189,40), renderingMode: .alwaysOriginal)
        goback10Button.setImage(image, for: .normal)
        goback10Button.addTarget(self, action: #selector(goback15ButtonTapped), for: .touchUpInside)
        let size = pauseButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        addSubview(goback10Button)
        goback10Button.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.right.equalTo(playButton.snp.left).offset(-50)
            $0.centerY.equalTo(playButton.snp.centerY)
        }
    }
    
    @objc func playButtonTapped() {
        changeButton()
        setSliderValue(maximumValue: self.audioDuration ?? 0)
        delegate?.playback()
    }
    
    @objc func pauseButtonTapped() {
        changeButton()
        delegate?.pause()
    }
    
    @objc func sliderDidChangedValue(_ sender: UISlider) {
        print(sender.value)
        delegate?.valueChanged()
    }
    
    @objc func sliderTouchUpedInside() {
        playButton.isHidden = false
        pauseButton.isHidden = true
        isPlaying = false
    }
    
    @objc func forward15ButtonTapped() {
        delegate?.forward10()
    }
    
    @objc func goback15ButtonTapped() {
        delegate?.goback10()
    }
    
    func changeButton() {
        isPlaying = !isPlaying
        if isPlaying {
            playButton.isHidden = true
            pauseButton.isHidden = false
        } else {
            playButton.isHidden = false
            pauseButton.isHidden = true
        }
    }
}
