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
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
//        self.title = "About"
        
    }
    
    
    convenience init(nameOrNil: String?)
    {
        self.init(nibName: nil, bundle: nil)
        
        if let typeName = nameOrNil
        {
            if typeName == "About"
            {
                textViewString = "Overview:\nAll of us who went through the painful college application process can remember just how hard it was to select the right programs from thousands of choices and making sure each one of the applications was submitted on time. Is it really necessary to go through so much anxiety and effort? At Uniq, we are creating the next generation mobile college application guide specifically made for high school students. The app can save an enormous amount of time by delivering the exact information that students are looking for with just a few taps.\n\nOur Mobile App Solution: \nUniq is a unique mobile application(appropriately named) for iOS and Android that brings the college researching and application process into one unified app. It allows high school students to explore and compare schools and programs within seconds. Uniq will use your information and adapt to what you value most in a school or program to provide personal recommendations, notifications, and deadlines alerts to guide you through the application process. With Uniq, students can significantly improve the quality of their college research while using less time than traditional methods."
            }
            else if typeName == "Special Thanks"
            {
                textViewString = "Thanks to everyone who provided valuable feedbacks along the way. It's been a cool journey. Thanks to Jack Yang from University of Waterloo has kindly provided help with PHP server code in the early stages and helped to shape the app that we see today. Aaron brought in his amazing talent in design, and shaped how the app look would look like. \n\nThere're websites/artworks/libraries/code snippets that provided value to the app, here are the ones that we'd like to thank:\n\n- Nick Lockwood and his AsyncImageView, available on Github: https://github.com/nicklockwood/AsyncImageView\n\n - Core Plot open sourced graph plotting library\n\n - XYFeng and his XYPieChart\n\n - Pierre Dulac and his DPMeterView\n\n - Wonil Kim (@wonkim99) and RPRadarChart\n\n - Javier Berlana (@jberlana) and JBParallaxCell\n\n - Thomas Winkler and SFGaugeView\n\n - luyf and VolumeBar\n\n"
            }
            else
            {
                textViewString = "Information Not Available at the moment"
            }
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
