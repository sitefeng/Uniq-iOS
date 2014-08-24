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
    var userImageAddButton: UIButton!
    
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
    
    var setEditing: Selector!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        
        //Background View
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        var backgroundImgView : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: backgroundView.frame.size.width, height: backgroundView.frame.size.height))
        
//        backgroundImgView.image = UIImage(named: "defaultProgram")
        backgroundImgView.image = UIImage(named: "edgeBackground")
        backgroundImgView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundView.addSubview(backgroundImgView)
        
        var backgroundWhiteCoverView: UIView = UIView(frame: backgroundImgView.frame)
        backgroundWhiteCoverView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
        backgroundView.addSubview(backgroundWhiteCoverView)
        self.addSubview(backgroundView)
        
        //User Image View
        userImageView = UIImageView(frame: CGRect(x: 60, y: 40, width: 200, height: 200))
        userImageView.layer.cornerRadius = 15
        userImageView.layer.masksToBounds = true
        userImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(userImageView)
        
        userImageAddButton = UIButton(frame: CGRect(x: userImageView.frame.origin.x+50, y: userImageView.frame.origin.y+50, width: 100, height: 100))
        userImageAddButton.setImage(UIImage(named: "addButtonIcon"), forState: UIControlState.Normal)
        userImageAddButton.setImage(UIImage(named: "addButtonIcon").imageWithAlpha(0.5), forState: UIControlState.Highlighted);
        userImageAddButton.addTarget(self, action: "imageAddButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        userImageAddButton.hidden = true
        self.addSubview(userImageAddButton)
        
        
        //UILabels
        userNameLabel = UITextField(frame: CGRect(x: 280, y: 60, width: 300, height: 44))
        userNameLabel.font = UIFont(name: JPFont.defaultThinFont(), size: 38)
        userNameLabel.userInteractionEnabled = false
        userNameLabel.clearsOnBeginEditing = true
        userNameLabel.autocapitalizationType = UITextAutocapitalizationType.Words
        userNameLabel.autocorrectionType = UITextAutocorrectionType.No
        self.addSubview(userNameLabel)
        
        var userLocationButton = UIButton(frame: CGRect(x: 280, y: 100, width: 100, height: 30))
        userLocationButton.titleLabel.font = UIFont(name: JPFont.defaultFont(), size: 22)
        userLocationButton.setTitle("Location:", forState: UIControlState.Normal)
        userLocationButton.addTarget(self, action: "locationButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        userLocationButton.setTitleColor(JPStyle.interfaceTintColor(), forState: UIControlState.Normal)
        userLocationButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.addSubview(userLocationButton)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 280 + 100, y: 100, width: 30, height: 30))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.addSubview(activityIndicator)
        
        userLocationLabel = UILabel(frame: CGRect(x: 280 + 100, y: 100, width: 300, height: 30))
        userLocationLabel.font = userLocationButton.titleLabel.font
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
    
    
    func setEditing(editing: Bool)
    {
        userImageAddButton.hidden = !editing
        self.userNameLabel.userInteractionEnabled = editing;
    }
    
    
    func imageAddButtonPressed(button: UIButton)
    {
        self.homeViewController.profileImageAddButtonPressed(button)

    }
    
    
    func locationButtonPressed(button: UIButton)
    {
        activityIndicator.startAnimating()
        self.homeViewController.locationButtonPressed(button)
    }
    
    
    func stopAnimatingActivityIndicator()
    {
        activityIndicator.stopAnimating()
    }
    


}





