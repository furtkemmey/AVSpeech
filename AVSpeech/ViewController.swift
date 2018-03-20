//
//  ViewController.swift
//  AVSpeech
//
//  Created by KaiChieh on 20/03/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
//import AVKit

class ViewController: UIViewController {
    let synth = AVSpeechSynthesizer()
//    var  utterance:AVSpeechUtterance?
    let audioSession = AVAudioSession.sharedInstance()

    @IBAction func button(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: "Unity")
//        utterance = AVSpeechUtterance(string: "Unity")
        utterance.rate = 0.1 // AVSpeechUtteranceDefaultSpeechRate
        utterance.pitchMultiplier = 1.0 // 0.5 ~ 2.0
        utterance.preUtteranceDelay = 0.1
//        utterance?.postUtteranceDelay = 0.1
        utterance.volume = 0.1 // default 1 0.0 ~ 1.0
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") //zh-TW
        synth.speak(utterance)
        synth.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            // 設置語 環境，保證能朗讀出聲 (特別是剛做過語 識別，這 話必加，不然沒聲 )
            //        try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            try audioSession.setCategory(AVAudioSessionCategoryPlayback) // AVAudioSessionCategoryPlayAndRecord
            try AVAudioSession.sharedInstance().setActive(true)
//            try AVAudioSession.sharedInstance().setActive(false)
//            try audioSession.setMode(AVAudioSessionModeDefault)

        }catch let error as NSError {
            print(error.code)

        }
    }

}
extension ViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("Start")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        try? AVAudioSession.sharedInstance().setActive(false)
        print("Finish")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print("Speeching")
    }
}

