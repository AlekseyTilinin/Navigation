//
//  MusicViewController.swift
//  Navigation
//
//  Created by Aleksey on 13.12.2022.
//

import Foundation
import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {
    
    var musicPlayer = AVAudioPlayer()
    var track = 0
    
    private lazy var trackImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "artwork")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLable : UILabel = {
        let lable = UILabel()
        lable.text = ""
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()

    private lazy var stopButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stop), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        return button
    }()

    private lazy var prevButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(prevTrack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Music"
        view.backgroundColor = .systemBackground
        addViews()
        addConstraints()
    }

    private func addViews() {
        view.addSubview(trackImage)
        view.addSubview(titleLable)
        view.addSubview(stackView)
        stackView.addArrangedSubview(prevButton)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(nextButton)
    }
       
    private func addConstraints() {
        NSLayoutConstraint.activate([

            trackImage.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            trackImage.centerYAnchor.constraint(equalTo: super.view.centerYAnchor, constant: -100),
            trackImage.heightAnchor.constraint(equalToConstant: 250),
            trackImage.widthAnchor.constraint(equalToConstant: 250),
            
            titleLable.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            titleLable.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 25),
            
            stackView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 25),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func addTrack(track: String) {
        do {
            guard let path = Bundle.main.path(forResource: track, ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
    }

    @objc
    func play() {
        trackImage.image = UIImage(named: MusicModel().trackImage[track])
        titleLable.text = MusicModel().music[track]
        stopButton.isEnabled = true

        if musicPlayer.isPlaying {
            musicPlayer.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            addTrack(track: MusicModel().music[track])
            musicPlayer.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }

    @objc
    func stop() {
        if musicPlayer.currentTime != .zero {
            musicPlayer.stop()
            musicPlayer.currentTime = .zero
            stopButton.isEnabled = false
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            titleLable.text = ""
            trackImage.image = UIImage(named: "artwork")
        }
    }

    @objc
    func nextTrack() {
        stop()
        track += 1
        play()

        prevButton.isEnabled = true

        if track == MusicModel().music.count-1 {
            nextButton.isEnabled = false
        }
    }

    @objc
    func prevTrack() {
        track = track - 1
        stop()
        play()

        nextButton.isEnabled = true

        if track == 0 {
            prevButton.isEnabled = false
        }
    }
}

