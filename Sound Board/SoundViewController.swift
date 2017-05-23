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

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
    }
    func setupRecorder() {
        do {
        
        //Create an audio session
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.overrideOutputAudioPort(.speaker)
        try session.setActive(true)
        
        //Create URL for the audio file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponens = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponens)!

          
        //Create Setting for Audio recorder
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
        //Create AudioRecorder Oject
        
        audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
        audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
        
    }
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sound = Sound(context: context)
        sound.name = nameTextField.text
        sound.audio = NSData(contentsOf: audioURL!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
         navigationController!.popViewController(animated: true)
        

    
}

    @IBAction func playTapped(_ sender: Any) {
        do {
            
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {}
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder!.isRecording {
            // Stop the recording
            audioRecorder?.stop()
            // Change button title to Record
            recordButton.setTitle("Record", for: .normal)
            
            playButton.isEnabled = true
            addButton.isEnabled = true
            
        } else {
            // start recording
            audioRecorder?.record()
            
            //change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
            addButton.isEnabled = false
            
        }
        
    }
   
}
