//
//  AVAudioSessionDataSourceDescriptionViewModel.swift
//  MicTest
//
//  Created by Boyko Andrey on 11/15/15.
//  Copyright © 2015 LOL. All rights reserved.
//

import AVFoundation
import UIKit

extension AVAudioSessionDataSourceDescription: TableViewModel{
    func setUpCell(cell:UITableViewCell)->UITableViewCell {
        cell.textLabel?.text = self.dataSourceName
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let ReuseId = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseId)
        guard let reusedCell = cell else{
            return self.setUpCell(UITableViewCell(style: .Default, reuseIdentifier: ReuseId))
        }
        return self.setUpCell(reusedCell)
    }
}