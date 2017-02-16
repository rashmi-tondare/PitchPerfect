//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Rashmi Tondare on 15/02/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var audioDuration: UILabel!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioPlayer: AVAudioPlayer!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        try! audioPlayer = AVAudioPlayer.init(contentsOf: recordedAudioURL)
        // format duration to hh:mm:ss
        displayDuration()
    }
    
    func displayDuration() {
        let x = round(audioPlayer.duration)
        let seconds = Int(x.truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60))
        let minutes = Int(round(x.truncatingRemainder(dividingBy: 3600) / 60))
        let hours = Int(round(x/3600))
        audioDuration.text = String(hours) + ":" + String(minutes) + ":" + String(seconds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
