//
//  iPadHomeToolbarView.swift
//  Uniq
//
//  Created by Si Te Feng on 6/15/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit

class iPadHomeToolbarView: UIView {

    var settingsButton: UIButton!
    
    weak var delegate: UIViewController!
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.backgroundColor = UIColor.whiteColor()
        
        settingsButton = UIButton(frame: CGRect(x: frame.width - 50, y: 3, width: 44, height: 44))
        settingsButton.setImage(UIImage(named: "settingsIcon"), forState: UIControlState.Normal)
        settingsButton.addTarget(self.delegate, action: "settingsButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(settingsButton)
        
    }

    

    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
