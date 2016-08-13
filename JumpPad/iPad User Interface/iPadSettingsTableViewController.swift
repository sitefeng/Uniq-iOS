//
//  iPadSettingsTableViewController.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit
import MessageUI
import Social

class iPadSettingsTableViewController: UITableViewController, UISplitViewControllerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate
{

    let defaultCellIdentifier : String! = "defaultCell"

    var _mailController: MFMailComposeViewController!
    
    var selectedIndex : NSIndexPath! = NSIndexPath(forRow: 0, inSection: 1)
    
    //General
    let cellTitles     : [[String]] = [[],["About", "Rate Uniq on App Store", "Send Feedback", "Share This App", "Authors", "Special Thanks", "Like on Facebook", "Follow on Twitter", "Visit Our Website"]]
    let cellImgStrings : [[String]] = [[],["info-75","thumb_up-75","email-50","share-75","groups-75","thanks-75","facebook-50","twitter-50", "safari-50"]]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
        
        
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return cellTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return cellTitles[0].count
        }
        else {
            return cellTitles[1].count
        }
        
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {

        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(defaultCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        var cellTitle: String
        var cellImageName: String
        
        if indexPath.section == 0
        {
            cellTitle = cellTitles[0][indexPath.row]
            cellImageName = cellImgStrings[0][indexPath.row]
        }
        else
        {
            cellTitle = cellTitles[1][indexPath.row]
            cellImageName = cellImgStrings[1][indexPath.row]
        }
        
        cell.textLabel?.text = cellTitle
        let cellImage : UIImage? = UIImage(named: cellImageName)?.imageWithAlignmentRectInsets(
            UIEdgeInsetsMake(5,5,5,5))

        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        cell.imageView?.image = cellImage
        
        return cell
    }
   
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String
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

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.tableView.deselectRowAtIndexPath(self.selectedIndex, animated: true)
        let row:Int = indexPath.row;
        
        if indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 5
        {
            self.selectedIndex = indexPath
            var parentCV: iPadSettingsSplitViewController = self.splitViewController as! iPadSettingsSplitViewController
            let cellTitleString = cellTitles[indexPath.section][indexPath.row]
            parentCV.changeDetailViewControllerWithName(cellTitleString)

        }
        else if(row == 1)
        {
            let url: NSURL = NSURL(string: "http://uniq.url.ph")!
            UIApplication.sharedApplication().openURL(url)
        }
        else if(row == 2)
        {
            if MFMailComposeViewController.canSendMail()
            {
                _mailController = MFMailComposeViewController();
                _mailController.setToRecipients(["technochimera@gmail.com"])
                _mailController.delegate = self
                self.presentViewController(_mailController, animated: true, completion: nil)
            }
            else
            {
                SVStatusHUD.showWithImage(UIImage(named: "noEmailHUD"), status: "Email Not Set")
            }
        }
        else if(row == 3)
        {
            let actionSheet = UIActionSheet(title: "Share Uniq", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Share on Facebook", "Post on Twitter")
        }
        else if(row == 6)
        {
            var url: NSURL = NSURL(string: "http://uniq.url.ph")!
            
            UIApplication.sharedApplication().openURL(url)
        }
        else if(row == 7)
        {
            var url: NSURL = NSURL(string: "http://uniq.url.ph")!
            UIApplication.sharedApplication().openURL(url)
        }
        else if(row == 8)
        {
            var url: NSURL = NSURL(string: "http://uniq.url.ph")!
            UIApplication.sharedApplication().openURL(url)
        }
        
    }


    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }


    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool
    {
        return false
    }
    
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        
        let message : String! = "Checkout Uniq for iOS. College Info Reimagined."
        var image:UIImage! = UIImage(named:"appIcon-152")
        
        var link: NSURL! = NSURL(string: "http://uniq.url.ph")
        
        if(buttonIndex==0)//facebook
        {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
            {
                var facebook : SLComposeViewController!  = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebook.setInitialText(message)
                facebook.addImage(image)
                facebook.addURL(link)
                self.presentViewController(facebook, animated: true, completion: nil)
            
            }
            else {
                UIAlertView(title: "Cannot Share Yet", message: "Please login to Facebook first in the Settings app", delegate: nil, cancelButtonTitle: "Cancel").show()
            }
        }
        else if(buttonIndex == 1)
        {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
            {
                var facebook : SLComposeViewController!  = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                facebook.setInitialText(message)
                facebook.addImage(image)
                facebook.addURL(link)
                self.presentViewController(facebook, animated: true, completion: nil)
                
            }
            else {
                UIAlertView(title: "Cannot Share Yet", message: "Please login to Twitter first in the Settings app", delegate: nil, cancelButtonTitle: "Cancel").show()
            }
        }
       
        actionSheet .dismissWithClickedButtonIndex(buttonIndex, animated: true)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
