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

    private func sharedAudioSession() throws -> AVAudioSession {
        if let session = _sharedAudioSession {
            return session;
        }
    
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryRecord)
        _sharedAudioSession = session;
        return session;
    }
    
    internal func microphones() throws -> [AVAudioSessionDataSourceDescription] {
        guard let ports = try self.sharedAudioSession().availableInputs else {
            // if there is exception or there is no value
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        
        guard let mics = ports.first?.dataSources else{
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return mics;
    }
}