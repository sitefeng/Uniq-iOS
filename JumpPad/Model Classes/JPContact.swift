//
//  JPContact.swift
//  Uniq
//
//  Created by Si Te Feng on 8/14/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//


internal final class JPContact: NSObject {
    
    var name: String = ""
    var email: String = ""
    var phoneNum: String = ""
    var ext: String = ""
    var website: String = ""
    var facebook: String = ""
    var twitter: String = ""
    var linkedin: String = ""
    var extraInfo: String = ""
    
    override init () {
        super.init()
    }

    convenience init(contactArray: [AnyObject]) {
        self.init()
        
        guard let dictionary = contactArray.first as? [String: AnyObject] else {
            print("dictionary cannot be found")
            return
        }
        
        name = dictionary["name"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        phoneNum = dictionary["phoneNum"] as? String ?? ""
        ext = dictionary["ext"] as? String ?? ""
        website = dictionary["website"] as? String ?? ""
        facebook = dictionary["facebook"] as? String ?? ""
        twitter = dictionary["twitter"] as? String ?? ""
        linkedin = dictionary["linkedin"] as? String ?? ""
        extraInfo = dictionary["extraInfo"] as? String ?? ""
        
    }
}
