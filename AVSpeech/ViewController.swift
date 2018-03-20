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
    var synth: AVSpeechSynthesizer?
//    var  utterance:AVSpeechUtterance?
//    let audioSession = AVAudioSession.sharedInstance()

    @IBAction func button(_ sender: UIButton) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // 設置語 環境，保證能朗讀出聲 (特別是剛做過語 識別，這 話必加，不然沒聲 )
            try audioSession.setCategory(AVAudioSessionCategoryPlayback) // AVAudioSessionCategoryPlayAndRecord AVAudioSessionCategoryPlayback AVAudioSessionCategoryAmbient AVAudioSessionCategorySoloAmbient
            try AVAudioSession.sharedInstance().setActive(true)
            try audioSession.setMode(AVAudioSessionModeSpokenAudio) // AVAudioSessionModeSpokenAudio AVAudioSessionModeDefault AVAudioSessionCategoryPlayback

        }catch let error as NSError {
            print(error.code)
        }

        let utterance = AVSpeechUtterance(string: "生氣了aaa")
//        utterance = AVSpeechUtterance(string: "Unity")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate // AVSpeechUtteranceDefaultSpeechRate 0.1
        utterance.pitchMultiplier = 1.0 // 0.5 ~ 2.0
        utterance.preUtteranceDelay = 0.3
        utterance.postUtteranceDelay = 0.3
        utterance.volume = 1 // default 1 0.0 ~ 1.0
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW") //zh-TW en-US
            self.synth?.speak(utterance)
//        synth?.delegate = self

    }
    
    @IBAction func btnFramework(_ sender: UIButton) {
        Speaker.speech(text: "Hello Speaker", country: .US)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        synth = AVSpeechSynthesizer()
        synth = AVSpeechSynthesizer()
//        synth?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
//        do {
//            // 設置語 環境，保證能朗讀出聲 (特別是剛做過語 識別，這 話必加，不然沒聲 )
//            //        try audioSession.setCategory(AVAudioSessionCategoryAmbient)
//            try audioSession.setCategory(AVAudioSessionCategoryPlayback) // AVAudioSessionCategoryPlayAndRecord AVAudioSessionCategoryPlayback
//            try AVAudioSession.sharedInstance().setActive(true)
////            try audioSession.setMode(AVAudioSessionModeDefault)
//
//        }catch let error as NSError {
//            print(error.code)
//        }
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

