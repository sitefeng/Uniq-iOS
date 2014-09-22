//
//  iPadSettingsAboutViewController.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

//splitview controller width is 448 height is 916

import UIKit

class iPadSettingsAboutViewController: UIViewController {

    var textViewString : String = ""
    
    var aboutView : UITextView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
//        self.title = "About"
        
    }
    
    
    convenience init(nameOrNil: String?)
    {
        self.init(nibName: nil, bundle: nil)
        
        if let typeName = nameOrNil
        {
            textViewString = JPGlobal.paragraphStringWithName(typeName)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        aboutView = UITextView(frame: CGRect(x: 10, y: 10, width: 448-20, height: 980))
        
        aboutView.font = UIFont.systemFontOfSize(17)
        aboutView.text = textViewString
        aboutView.editable = false
        aboutView.selectable = false
        aboutView.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(aboutView)
        
        
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
