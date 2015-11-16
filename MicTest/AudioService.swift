//
//  File.swift
//  MicTest
//
//  Created by Boyko Andrey on 11/15/15.
//  Copyright © 2015 LOL. All rights reserved.
//

import Foundation
import AVFoundation

class AudioService {
    
    private var _sharedAudioSession:AVAudioSession?
    private var _currentRecorder: AVAudioRecorder?
    internal var isRecording:Bool {
        guard let recorder = _currentRecorder else {
            return false
        }
        return recorder.recording
    }
    
    private func sharedAudioSession() throws -> AVAudioSession {
        if let session = _sharedAudioSession {
            return session;
        }
    
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryRecord)
        _sharedAudioSession = session;
        return session;
    }
    
    
    private func availableInput() throws -> AVAudioSessionPortDescription {
        guard let ports = try self.sharedAudioSession().availableInputs else {
            // if there is exception or there is no value
            throw NSError(domain: "Can't found available inputs", code: 0, userInfo: nil)
        }
        
        guard let input:AVAudioSessionPortDescription = ports.first else{
            throw NSError(domain: "Can't found available input", code: 0, userInfo: nil)
        }
        return input;
    }
    
    private func recordFilePath() throws -> NSURL{
        let now = NSDate()
        let directoryURL = try NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL:nil, create:true)
        return directoryURL.URLByAppendingPathComponent(now.description).URLByAppendingPathExtension("caf");
    }
    
    internal func microphones() throws -> [AVAudioSessionDataSourceDescription] {
        let input = try self.availableInput()
        guard let mics = input.dataSources else{
            throw NSError(domain: "Can't found available data sources", code: 0, userInfo: nil)
        }
        return mics;
    }
    
    internal func prepareRecorder(selectedDataSource:AVAudioSessionDataSourceDescription) throws {
        
        self.stopRecord()
        
        let input = try self.availableInput()
        try input.setPreferredDataSource(selectedDataSource);
        
        let recordSettings:[String:AnyObject] =
            [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]

        let recorder = try AVAudioRecorder(URL: try self.recordFilePath(), settings: recordSettings)
        recorder.prepareToRecord()
        _currentRecorder = recorder;
    }
    
    internal func startRecord(){
        _currentRecorder?.record()
    }
    
    internal func stopRecord()->NSURL?{
        var url:NSURL?
        if (isRecording){
            url = _currentRecorder?.url
            _currentRecorder?.stop()
            _currentRecorder = nil
        }
        return url
    }
    
    func playAudio(url:NSURL) throws {
        guard isRecording==true else{
            throw NSError(domain: "Can't play audio", code: 0, userInfo: nil)
        }
        
        let audioPlayer = try AVAudioPlayer(contentsOfURL: url)
        audioPlayer.play()
    }
}