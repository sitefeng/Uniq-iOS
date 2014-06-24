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
    
    var _authorsInfo : Dictionary<String, String>[] = Array()
    
    var _selectedIndexPath : NSIndexPath?
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization

        self.tableView.registerClass(iPadProgramCoursesTableViewCell.self, forCellReuseIdentifier: authorsCellIdentifier)
        self.tableView.allowsMultipleSelection = false;
            
        _authorsInfo = [
            ["name": "Si Te Feng", "position": "iOS Developer", "description" : "Si Te is a 2nd year student studying at University of Waterloo Mechatronics Engineering program."],
            ["name": "Christopher Luc", "position": "Server Developer", "description" : "Christopher is a 2nd year student studying at University of Waterloo Software Engineering program."],
            ["name": "Andre Lee", "position": "Web Developer", "description" : "Andre is a 2nd year student studying at University of Waterloo Mechatronics program."],
            ["name": "Jack Yang", "position": "Server Developer", "description" : "Jack is a 3rd year student studying at University of Waterloo Computer Science program."],
            ["name": "Aaron Te", "position": "UI Designer", "description" : "Aaron is a 2nd year student studying at University of Waterloo."],
            ["name": "Wesley Fisher", "position": "Android Developer", "description" : "Wesley is a 2nd year student studying at University of Waterloo Mechatronics Engineering program."],
        ]
        
        
        
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

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
        
        var cell : iPadProgramCoursesTableViewCell! = tableView!.dequeueReusableCellWithIdentifier(authorsCellIdentifier, forIndexPath: indexPath) as? iPadProgramCoursesTableViewCell

        if(!cell)
        {
            cell = iPadProgramCoursesTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: authorsCellIdentifier)
        }
        
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

    
    
    
    
    
    
    
    
    
    


}
