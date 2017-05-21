//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Dung Pham on 5/20/17.
//  Copyright © 2017 Dung Pham. All rights reserved.
//

import UIKit
import AVFoundation // This is essential to build recording apps


class SoundViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRecorder()
    }
    func setupRecorder() {
        do {
        
        //Create an audio session
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.overrideOutputAudioPort(.speaker)
        try session.setActive(true)
        
        //Create URL for the audio file
    
        //Create Setting for Audio recorder
        
        //Create AudioRecorder Oject
        
        audioRecorder = AVAudioRecorder(url: <#T##URL#>, settings: <#T##[String : Any]#>)
        } catch let error as NSError
            print(error)
        }
        
    }
    @IBAction func addTapped(_ sender: Any) {
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func recordTapped(_ sender: Any) {
    }
   
}
