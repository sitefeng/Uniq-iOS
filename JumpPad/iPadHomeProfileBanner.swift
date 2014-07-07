//
//  iPadHomeProfileBanner.swift
//  Uniq
//
//  Created by Si Te Feng on 6/13/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

import UIKit

class iPadHomeProfileBanner: UIView {

    var homeViewController: iPadMainHomeViewController!
    
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
    
    var userNameLabel: UITextField!
    var userLocationLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView!
    var averageProgressView: LDProgressView!

    var userAverage: Float {
    get{
        return Float(self.averageProgressView.progress*100.0)
    }
    set (average) {
        self.averageProgressView.progress = CGFloat(average/100.0)
    }
    
    }
    
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
        userNameLabel = UITextField(frame: CGRect(x: 280, y: 60, width: 300, height: 44))
        userNameLabel.font = UIFont(name: JPFont.defaultThinFont(), size: 38)
        userNameLabel.userInteractionEnabled = false
        userNameLabel.clearsOnInsertion = true
        userNameLabel.autocapitalizationType = UITextAutocapitalizationType.Words
        userNameLabel.autocorrectionType = UITextAutocorrectionType.No
        self.addSubview(userNameLabel)
        
        var userLocationButton = UIButton(frame: CGRect(x: 280, y: 100, width: 100, height: 30))
        userLocationButton.font = UIFont(name: JPFont.defaultFont(), size: 22)
        userLocationButton.setTitle("Location:", forState: UIControlState.Normal)
        userLocationButton.addTarget(self, action: "locationButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        userLocationButton.setTitleColor(JPStyle.colorWithHex("0007CF", alpha: 1), forState: UIControlState.Normal)
        userLocationButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.addSubview(userLocationButton)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 280 + 100, y: 100, width: 30, height: 30))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.addSubview(activityIndicator)
        
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
    
    
    func locationButtonPressed(button: UIButton)
    {
        activityIndicator.startAnimating()
        self.homeViewController.locationButtonPressed(button)
    }
    
    
    func stopAnimatingAactivityIndicator()
    {
        activityIndicator.stopAnimating()
    }
    


}





