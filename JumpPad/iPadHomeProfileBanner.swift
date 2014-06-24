//
//  iPadHomeProfileBanner.swift
//  Uniq
//
//  Created by Si Te Feng on 6/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit

class iPadHomeProfileBanner: UIView {

    var homeViewController: UIViewController?
    
    var userImage: UIImage! {
    get{
        let retImg = userImageView.image
        return retImg
    }
    set(imageToSet){
        self.userImageView.image = imageToSet
    }
    
    }
    
    var userImageView: UIImageView!
    
    var userNameLabel: UILabel!
    var userLocationLabel: UILabel!
    
    
    var userAverage: Float {
    get{
        return self.averageProgressView.progress*100.0
    }
    set (average) {
//        self.averageLabel.text = "\(average)%"
        self.averageProgressView.progress = average/100.0
    }
    
    }
    
    var averageProgressView: LDProgressView!
//    var averageLabel : UILabel!
    
    var backgroundView: UIView!
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        //Background View
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        var backgroundImgView : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: backgroundView.frame.size.width, height: backgroundView.frame.size.height))
        
        backgroundImgView.image = UIImage(named: "defaultProgram")
        backgroundImgView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundView.addSubview(backgroundImgView)
        
        var backgroundWhiteCoverView: UIView = UIView(frame: backgroundImgView.frame)
        backgroundWhiteCoverView.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        
        backgroundView.addSubview(backgroundWhiteCoverView)
        self.addSubview(backgroundView)
        
        //User Image View
        userImageView = UIImageView(frame: CGRect(x: 60, y: 40, width: 200, height: 200))
        self.addSubview(userImageView)
        
        //UILabels
        userNameLabel = UILabel(frame: CGRect(x: 280, y: 60, width: 300, height: 40))
        userNameLabel.font = UIFont(name: JPFont.defaultThinFont(), size: 38)
        self.addSubview(userNameLabel)
        
        var userLocationButton = UIButton(frame: CGRect(x: 280, y: 100, width: 100, height: 30))
        userLocationButton.font = UIFont(name: JPFont.defaultFont(), size: 22)
        userLocationButton.setTitle("Location:", forState: UIControlState.Normal)
        userLocationButton.addTarget(self.homeViewController, action: "locationButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        userLocationButton.setTitleColor(JPStyle.colorWithHex("0007CF", alpha: 1), forState: UIControlState.Normal)
        userLocationButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.addSubview(userLocationButton)
        
        userLocationLabel = UILabel(frame: CGRect(x: 280 + 100, y: 100, width: 300, height: 30))
        userLocationLabel.font = userLocationButton.font
        self.addSubview(userLocationLabel)
        
        
        //Average Progress View 
        var avgTitle = UILabel(frame: CGRect(x: 280, y: 150, width: 300, height: 30))
        avgTitle.font = UIFont(name: JPFont.defaultThinFont(), size: 22)
        avgTitle.text = "Overall Average"
        self.addSubview(avgTitle)
        
        self.averageProgressView = LDProgressView(frame: CGRect(x: 280, y: 185, width: 340, height: 27))
        self.averageProgressView.color = JPStyle.colorWithName("green")
        self.averageProgressView.flat = true
        self.averageProgressView.animate = false
        self.addSubview(self.averageProgressView)
        
        
        
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















