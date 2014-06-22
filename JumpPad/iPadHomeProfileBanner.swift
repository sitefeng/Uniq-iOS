//
//  iPadHomeProfileBanner.swift
//  Uniq
//
//  Created by Si Te Feng on 6/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit

class iPadHomeProfileBanner: UIView {

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
    var userHighschoolLabel: UILabel!
    var userLocationLabel: UILabel!
    
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
        userNameLabel = UILabel(frame: CGRect(x: 280, y: 70, width: 300, height: 30))
        userNameLabel.font = UIFont(name: JPFont.defaultBoldFont(), size: 26)
        self.addSubview(userNameLabel)
        
        userHighschoolLabel = UILabel(frame: CGRect(x: 280, y: 120, width: 350, height: 30))
        userHighschoolLabel.font = UIFont(name: JPFont.defaultBoldFont(), size: 18)
        self.addSubview(userHighschoolLabel)

        userLocationLabel = UILabel(frame: CGRect(x: 280, y: 160, width: 300, height: 30))
        userLocationLabel.font = UIFont(name: JPFont.defaultBoldFont(), size: 18)
        self.addSubview(userLocationLabel)
        
        
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















