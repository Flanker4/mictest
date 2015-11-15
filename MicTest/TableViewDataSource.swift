//
//  MicDataSource.swift
//  MicTest
//
//  Created by Boyko Andrey on 11/15/15.
//  Copyright © 2015 LOL. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol TableViewModel {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell;
}

extension NSArray: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let item = self[indexPath.row] as! TableViewModel
        return item.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
}

extension Array where Element: TableViewModel{
    func tableViewDataSource()->UITableViewDataSource {
        return self
    }
}

