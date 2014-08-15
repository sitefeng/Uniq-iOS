//
//  iPadSettingsAuthorsTableViewController.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit

class iPadSettingsAuthorsTableViewController: UITableViewController {

    let authorsCellIdentifier : String! = "reuseIdentifier"
    
    var _authorsInfo : [Dictionary<String, String>] = Array()
    
    var _selectedIndexPath : NSIndexPath?
    var _deviceType: UIUserInterfaceIdiom!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization

        _deviceType = UIDevice.currentDevice().userInterfaceIdiom
        
        self.tableView.registerClass(JPProgramCoursesTableViewCell.self, forCellReuseIdentifier: authorsCellIdentifier)
        self.tableView.allowsMultipleSelection = false;
        
        _authorsInfo = [
            ["name": "Si Te Feng", "position": "iOS Developer", "description" : "Si Te is a 2nd year student studying at University of Waterloo Mechatronics Engineering program."],
            ["name": "Christopher Luc", "position": "Server Developer", "description" : "Christopher is a 2nd year student studying at University of Waterloo Software Engineering program."],
            ["name": "Andre Lee", "position": "Web Developer", "description" : "Andre is a 2nd year student studying at University of Waterloo Mechatronics program."],
            ["name": "Jack Yang", "position": "Server Developer", "description" : "Jack is a 3rd year student studying at University of Waterloo Computer Science program."],
            ["name": "Aaron Te", "position": "UI Designer", "description" : "Aaron is a 2nd year student studying at University of Waterloo."],
            ["name": "Wesley Fisher", "position": "Android Developer", "description" : "Wesley is a 2nd year student studying at University of Waterloo Mechatronics Engineering program."],
            ["name": "Richard Lee", "position": "App Icon Designer", "description" : "Richard is a graphics designer who loves to make games for Flash and iOS. He is currently working at Avoca Technologies as an iOS Developer."],
        ]
        
        
        
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
//MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return _authorsInfo.count
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        
        var cell : JPProgramCoursesTableViewCell! = tableView!.dequeueReusableCellWithIdentifier(authorsCellIdentifier, forIndexPath: indexPath) as? JPProgramCoursesTableViewCell

        if(!cell)
        {
            cell = JPProgramCoursesTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: authorsCellIdentifier)
        }
        
        cell.deviceType = self._deviceType
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // Configuring the cell
        cell.courseCode = _authorsInfo[indexPath!.row]["name"]
        cell.courseNameLabel.text = _authorsInfo[indexPath!.row]["position"]
        cell.courseDescriptionView.text = _authorsInfo[indexPath!.row]["description"]
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
        if let selectedPathNotNil = _selectedIndexPath
        {
            if selectedPathNotNil == indexPath {
                return 190;
            }
        }
       
        return 80;
        
    }
    
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if let selectedPathNotNil = _selectedIndexPath
        {
           if selectedPathNotNil != indexPath
           {
                _selectedIndexPath = indexPath
            }
            
        }
        else
        {
            _selectedIndexPath = indexPath;
        }
        
        self.tableView.reloadData();
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
