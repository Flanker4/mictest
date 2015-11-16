//
//  DetailViewController.swift
//  MicTest
//
//  Created by Boyko Andrey on 11/15/15.
//  Copyright © 2015 LOL. All rights reserved.
//

import UIKit
import AVFoundation
class DetailViewController: UIViewController {

    internal var audioService:AudioService!
    internal var dataSource:AVAudioSessionDataSourceDescription!
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tap(sender: AnyObject) {
        if (audioService.isRecording){
            audioService.stopRecord()
        }else{
            do{
                try audioService.prepareRecorder(self.dataSource)
                audioService.startRecord()
            }
            catch _{
                
            }

        }
    }

}

