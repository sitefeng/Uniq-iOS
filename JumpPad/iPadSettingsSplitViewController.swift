//
//  iPadSettingsSplitViewController.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit
import MessageUI

class iPadSettingsSplitViewController: UISplitViewController, MFMailComposeViewControllerDelegate
{

    var _navController: UINavigationController!
    
    
    var originalTabBarController : UITabBarController?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
//        self.originalTabBarController = self.storyboard.instantiateViewControllerWithIdentifier("MainTabBarController") as? UITabBarController
//        self.originalTabBarController!.selectedIndex = 4
        
        
        //Navigation Controller
        var tableController : iPadSettingsTableViewController = iPadSettingsTableViewController(style: UITableViewStyle.Grouped)
        tableController.title = "Settings"

        let dismissBarButtonItem: UIBarButtonItem! = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.Done, target: self, action: "dismissButtonPressed")
        tableController.navigationItem.setLeftBarButtonItem(dismissBarButtonItem, animated: false)
        self.delegate = tableController
        
        _navController = UINavigationController(rootViewController: tableController)
        
        //Detail View Controller
        var aboutController = iPadSettingsAboutViewController(nibName: nil, bundle: nil)
        
        var detailNavController: UINavigationController! = UINavigationController(rootViewController: aboutController)
        
        
        self.viewControllers = [_navController, detailNavController]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
    }

    
    
    func dismissButtonPressed() {
        
        var app = UIApplication.sharedApplication().delegate as UIApplicationDelegate!
        
        var currentController : UIViewController! = app.window!.rootViewController
        app.window!.rootViewController = self.originalTabBarController
        app.window!.rootViewController = currentController
        
        UIView.transitionWithView(self.view.window, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations:
            {
                () in
                app.window!.rootViewController = self.originalTabBarController
            }, completion: nil)
        

        
    }
    
    
    
    
    func changeDetailViewControllerWithName(name: String!)
    {
        
        var detailNavController: UINavigationController!
        
        if name == "Authors" {
            var detailController = iPadSettingsAuthorsTableViewController(style: UITableViewStyle.Plain)
            detailController.title = name
            detailNavController = UINavigationController(rootViewController: detailController)
        }
        else if name == "About" || name=="Special Thanks"
        {
            var detailController = iPadSettingsAboutViewController(nameOrNil: name)
            detailController.title = name
            detailNavController = UINavigationController(rootViewController: detailController)

        }
        else if name == "Contact"
        {
            if MFMailComposeViewController.canSendMail()
            {
                var mailController : MFMailComposeViewController!  = MFMailComposeViewController()
                mailController.mailComposeDelegate = self
                var recipient = "technochimera@gmail.com"
            
                mailController.setToRecipients([recipient])
                self.presentViewController(mailController, animated: true, completion: nil)
            }
            else
            {
               UIAlertView(title: "Cannot Send Message", message: "Your can setup your mail account in the Settings application", delegate: nil, cancelButtonTitle: "Okay").show()
            }

        }
        else
        {
            var detailController: UIViewController! = UIViewController(nibName: nil, bundle: nil)
            detailController.title = name
            detailNavController = UINavigationController(rootViewController: detailController)
        }
        
        
        self.viewControllers = [_navController, detailNavController]

        
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
