//
//  iPadSettingsTableViewController.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit

class iPadSettingsTableViewController: UITableViewController, UISplitViewControllerDelegate {

    let defaultCellIdentifier : String! = "defaultCell"

    
    var selectedIndex : NSIndexPath! = NSIndexPath(forRow: 0, inSection: 1)
    
    //General
    let cellTitles     : String[][] = [["Download Contents", "Notifications"],["About", "Rate Uniq on App Store", "Contact Us", "Share This App", "Authors", "Special Thanks", "Like on Facebook", "Follow on Twitter"]]
    let cellImgStrings : String[][] = [["download-75","tones-75"],["info-75","thumb_up-75","email-50","share-75","groups-75","thanks-75","facebook-50","twitter-50"]];
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
        
        
    }
    
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        

        
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.tableView(self.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1), animated: true, scrollPosition: UITableViewScrollPosition.None)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return cellTitles.count
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return cellTitles[0].count
        }
        else {
            return cellTitles[1].count
        }
        
        
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell?
    {
        var cell : UITableViewCell = tableView?.dequeueReusableCellWithIdentifier(defaultCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
//        cell.font = UIFont(name: JPFont.defaultThinFont(), size: 20)
        
        var cellTitle: String
        var cellImageName: String
        
        if indexPath!.section == 0
        {
            cellTitle = cellTitles[0][indexPath!.row]
            cellImageName = cellImgStrings[0][indexPath!.row]
        }
        else
        {
            cellTitle = cellTitles[1][indexPath!.row]
            cellImageName = cellImgStrings[1][indexPath!.row]
        }
        
        cell.textLabel.text = cellTitle
        var cellImage : UIImage = UIImage(named: cellImageName).imageWithAlignmentRectInsets(UIEdgeInsetsMake(5,5,5,5))

        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.imageView.image = cellImage
        
        return cell
    }
   
    
    
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String!
    {
        if section==0
        {
            return "Options"
        }
        else
        {
            return "General"
        }
        
    }
    
    override func tableView(tableView: UITableView!, accessoryTypeForRowWithIndexPath indexPath: NSIndexPath!) -> UITableViewCellAccessoryType
    {
        
        if (indexPath.section==1 && (indexPath.row==1||indexPath.row==2||indexPath.row==3 || indexPath.row == 6||indexPath.row==7))
        {
            return UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return UITableViewCellAccessoryType.None
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        self.tableView.deselectRowAtIndexPath(self.selectedIndex, animated: true)
        
        self.selectedIndex = indexPath
    
        var parentCV: iPadSettingsSplitViewController = self.splitViewController as iPadSettingsSplitViewController
        
        let cellTitleString = cellTitles[indexPath.section][indexPath.row]
        parentCV.changeDetailViewControllerWithName(cellTitleString)
        
    }
    
    

    override func tableView(tableView: UITableView!, shouldHighlightRowAtIndexPath indexPath: NSIndexPath!) -> Bool
    {
        return true
    }
    

    func splitViewController(svc: UISplitViewController!, shouldHideViewController vc: UIViewController!, inOrientation orientation: UIInterfaceOrientation) -> Bool
    {
        return false
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
