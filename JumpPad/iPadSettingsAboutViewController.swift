//
//  iPadSettingsAboutViewController.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

//splitview controller width is 448 height is 916

import UIKit

class iPadSettingsAboutViewController: UIViewController, UISplitViewControllerDelegate {

    var textViewString : String = ""
    
    var aboutView : UITextView!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
        textViewString = "As an alternative to subscripting, use a dictionary’s updateValue(forKey:) method to set or update the value for a particular key. Like the subscript examples above, the updateValue(forKey:) method sets a value for a key if none exists, or updates the value if that key already exists. Unlike a subscript, however, the updateValue(forKey:) method returns the old value after performing an update.\n\n This enables you to check whether or not an update took place The updateValue(forKey:) method returns an optional value of the dictionary’s value type. For a dictionary that stores String values, for example, the method returns a value of type String?, or optional String. This optional value contains the old value for that key if one existed before the update, or nil if no value existed:\n\nYou can also use subscript syntax to retrieve a value from the dictionary for a particular key. Because it is possible to request a key for which no value exists, a dictionary’s subscript returns an optional value of the dictionary’s value type. If the dictionary contains a value for the requested key, the subscript returns an optional value containing the existing value for that key. Otherwise, the subscript returns nil:"
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        aboutView = UITextView(frame: CGRect(x: 10, y: 10+Int(kiPadStatusBarHeight)+Int(kiPadNavigationBarHeight), width: 448-20, height: 916-20))
        
        aboutView.font = UIFont.systemFontOfSize(15)
        aboutView.text = textViewString
        
        aboutView.backgroundColor = UIColor.blueColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func splitViewController(svc: UISplitViewController!, shouldHideViewController vc: UIViewController!, inOrientation orientation: UIInterfaceOrientation) -> Bool
    {
        return false
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
