//
//  MasterViewController.swift
//  MicTest
//
//  Created by Boyko Andrey on 11/15/15.
//  Copyright © 2015 LOL. All rights reserved.
//

import UIKit
import AVFoundation

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var microphones = [AVAudioSessionDataSourceDescription]()
    lazy var audioService = AudioService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            microphones = try audioService.microphones()
        }catch _ {
            
        }
        
        self.tableView.dataSource = microphones.tableViewDataSource()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
     
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showRecordPage", sender: nil)
    }
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRecordPage" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = microphones[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.dataSource = object
                controller.audioService = audioService
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View


}

