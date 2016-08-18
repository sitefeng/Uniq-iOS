//
//  JPOfflineDataRequest.swift
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//


@objc internal protocol JPOfflineDataRequestDelegate {
    
    optional func offlineDataRequest(request: JPOfflineDataRequest, didLoadAllItemsOfType type: JPDashletType, dataArray: [AnyObject], isSuccessful: Bool)

}


/// Although it's mainly offline requests, it contains some online operations (such as firebase ratings)
internal final class JPOfflineDataRequest: NSObject, JPProgramRatingHelperDelegate {
    
    var delegate: JPOfflineDataRequestDelegate?
    
    var _cloudFavoritesHelper: JPCloudFavoritesHelper?
    
    override init() {
        super.init()
    }
    
    func requestAllFeaturedItems() -> [AnyObject] {
        let featuredPath = NSBundle.mainBundle().pathForResource("getAllFeaturedInfo", ofType: "json")!
        
        let fileData = NSFileManager.defaultManager().contentsAtPath(featuredPath)!
        do {
            let featuredJSONArray = try NSJSONSerialization.JSONObjectWithData(fileData, options: [])
            return featuredJSONArray as! [AnyObject]
        } catch {
            print("Error: cannot get featured items")
            return []
        }
        
    }
    
    func requestAllSchools() {
        
        var dataArray: [AnyObject] = []
        
        var schoolFolders = []
        do {
            schoolFolders = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(offlineDataPath())
        } catch {
            print("Cannot load local files")
            return
        }
        
        for schoolNameAny in schoolFolders {
            let schoolName = schoolNameAny as! String
            let schoolPath = offlineDataPath() + "/\(schoolName)"
            
            let schoolJSONURL = NSURL.fileURLWithPath(schoolPath + "/\(schoolName).json")
            let schoolJSONData = NSData(contentsOfURL: schoolJSONURL)
            
            do {
                var schoolDictionary = try NSJSONSerialization.JSONObjectWithData(schoolJSONData!, options: []) as! [String: AnyObject]
                replaceEmptyItemIdWithSlugIfNecessary(&schoolDictionary)
                dataArray.append(schoolDictionary)
            } catch {
                print("JSON error")
                return
            }
        }
        
        delegate?.offlineDataRequest?(self, didLoadAllItemsOfType: JPDashletType.School, dataArray: dataArray, isSuccessful: true)
    }
    
    
    // Where slug is same as the local JSON file name
    func requestAllFacultiesFromSchool(slug: String) {
        var dataArray: [AnyObject] = []
        
        let schoolName = slug
        let schoolPath = offlineDataPath() + "/\(schoolName)"
        
        var facultyFolders = []
        do {
            facultyFolders = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(schoolPath)
        } catch {
            print("Cannot load local files")
            return
        }
            
        for facultyNameOrNil in facultyFolders {
            let facultyName = facultyNameOrNil as! String
            
            // Remove the json data for school itself
            guard !facultyName.containsString(".json") else {
                continue
            }
            
            let facultyPath = schoolPath + "/\(facultyName)"
            
            let facultyJSONURL = NSURL(fileURLWithPath: facultyPath + "/\(facultyName).json")
            let facultyJSONDataOrNil = NSData(contentsOfURL: facultyJSONURL)
            
            guard let facultyJSONData = facultyJSONDataOrNil else {
                print("matching faculty json does not exist in the faculty folder")
                return
            }
            
            do {
                var facultyDictionary = try NSJSONSerialization.JSONObjectWithData(facultyJSONData, options: []) as! [String: AnyObject]
                replaceEmptyItemIdWithSlugIfNecessary(&facultyDictionary)
                dataArray.append(facultyDictionary)
            } catch {
                return
            }
        }
        
        delegate?.offlineDataRequest?(self, didLoadAllItemsOfType: JPDashletType.Faculty, dataArray: dataArray, isSuccessful: true)
    }
    
    
    func requestAllProgramsFromFaculty(schoolSlug: String, facultySlug: String) {
        var dataArray: [AnyObject] = []
        
        let facultyPath = self.offlineDataPath() + "/\(schoolSlug)/\(facultySlug)"
        
        var programNames = []
        do {
            programNames = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(facultyPath)
        } catch {
            print("Cannot load local files")
            return
        }
        
        for programNameOrNil in programNames {
            let programName = programNameOrNil as! String
            
            // Remove the json data for school itself
            guard !programName.containsString("\(facultySlug).json") else {
                continue
            }
            
            let programJSONURL = NSURL(fileURLWithPath: facultyPath + "/\(programName)")
            let programJSONData = NSData(contentsOfURL: programJSONURL)
            
            do {
                var programDictionary = try NSJSONSerialization.JSONObjectWithData(programJSONData!, options: []) as! [String: AnyObject]
                replaceEmptyItemIdWithSlugIfNecessary(&programDictionary)
                dataArray.append(programDictionary)
            } catch {
                return
            }
        }
        
        delegate?.offlineDataRequest?(self, didLoadAllItemsOfType: JPDashletType.Program, dataArray: dataArray, isSuccessful: true)
    }
    
    // MARK: - Serialized Requests
    
    //MARK: Request for school location
    func requestLocationForSchool(schoolSlug: String) -> JPLocation {
        guard schoolSlug != "" else {
            print("School Slug cannot be empty")
            return JPLocation()
        }

        let schoolName = schoolSlug
        let schoolJSONPath = offlineDataPath() + "/\(schoolName)/\(schoolName).json"
        
        let schoolJSONURL = NSURL(fileURLWithPath: schoolJSONPath)
        let schoolJSONData = NSData(contentsOfURL: schoolJSONURL)
        
        var schoolDictionary = [:]
        do {
            schoolDictionary = try NSJSONSerialization.JSONObjectWithData(schoolJSONData!, options: []) as! NSDictionary
        } catch {
            return JPLocation()
        }
        
        let schoolLocationDict = schoolDictionary.objectForKey("location") as! [NSObject: AnyObject]
        let location = JPLocation(locationDict: schoolLocationDict)
        return location
    }
    
    // For when program doesn't have a specific contact info
    func requestContactForSchool(schoolSlug: String) -> JPContact {
        guard schoolSlug != "" else {
            print("School Slug cannot be empty")
            return JPContact()
        }
        
        let schoolJSONPath = offlineDataPath() + "/\(schoolSlug)/\(schoolSlug).json"
        
        return _getContactFromJSONFilePath(schoolJSONPath)
    }

    
    
    // For when program doesn't have a specific contact info
    func requestContactForFaculty(schoolSlug: String, facultySlug: String) -> JPContact {
        guard schoolSlug != "" && facultySlug != "" else {
            print("Faculty Slug cannot be empty")
            return JPContact()
        }
        
        let facultyJSONPath = offlineDataPath() + "/\(schoolSlug)/\(facultySlug)/\(facultySlug).json"
        return _getContactFromJSONFilePath(facultyJSONPath)
    }
    
    private func _getContactFromJSONFilePath(path: String) -> JPContact {
        
        // naming: Pretend getting contact for faculty
        let facultyJSONURL = NSURL(fileURLWithPath: path)
        let facultyJSONDataOrNil = NSData(contentsOfURL: facultyJSONURL)
        
        guard let facultyJSONData = facultyJSONDataOrNil else {
            print("Faculty JSON data cannot be found, slug given in file may not be correct")
            return JPContact()
        }
        
        var facultyDictionary = [:]
        do {
            facultyDictionary = try NSJSONSerialization.JSONObjectWithData(facultyJSONData, options: []) as? [String: AnyObject] ?? [:]
        } catch {
            return JPContact()
        }
        
        guard let facultyContactDict = facultyDictionary.objectForKey("contacts") as? [AnyObject] else {
            print("Cannot generate contact")
            return JPContact()
        }
        
        let contact = JPContact(contactArray: facultyContactDict)
        return contact
    }
    
    //MARK: - Requesting Indivitual item details
    /// Get program details in dictionary format
    func requestProgramDetails(schoolSlug: String, facultySlug: String, programSlug: String, itemUid: String, completion: ((Bool, [String: AnyObject]) -> Void)) {
        
        if itemUid.characters.count == 0 {
            NSLog("ItemUid cannot be empty");
            completion(false, [:])
        }
        
        let programPath = offlineDataPath() + "/\(schoolSlug)/\(facultySlug)/\(programSlug).json"
        
        let dictionary = dictionaryFromFilePath(programPath)
        addFavoriteCountToDictionary(itemUid, dict: dictionary) { (success1, augmentedDict) in
            
            if !success1 {
                //Continue anyway without appending favorite count to dictionary
            }
            
            // If favorite count for the program isn't found
            var augmentedFavDict = augmentedDict
            
            //Adding Ratings from Firebase
            let programRatingHelper = JPProgramRatingHelper()
            programRatingHelper.delegate = self
            programRatingHelper.downloadRatingsWithProgramUid(itemUid, getAverageValue: true) { (success2, ratings) in
                
                if ratings != nil {
                    let ratingsShortForm = ratings.getShortKeyDictionaryRepresentation()
                    let ratings = JPRatings(shortKeyDictionary: ratingsShortForm)
                    
                    let ratingsDict = ratings.getFullKeyDictionaryRepresentation()
                    augmentedFavDict["rating"] = ratingsDict
                }
                
                // Succeed event if data cannot be appended for offline mode
                completion(true, augmentedFavDict)
            }
        }
    }
    
    func requestFacultyDetails(schoolSlug: String, facultySlug: String, itemUid: String, completion: ((Bool, [String: AnyObject]) -> Void)) {
        if itemUid.characters.count == 0 {
            NSLog("ItemUid cannot be empty");
            completion(false, [:])
        }
        
        let facultyPath = offlineDataPath() + "/\(schoolSlug)/\(facultySlug)/\(facultySlug).json"
        
        let dictionary = dictionaryFromFilePath(facultyPath)
        
        addFavoriteCountToDictionary(itemUid, dict: dictionary) { (success, augmentedDict) in
            completion(success, augmentedDict)
        }
    }
    
    func requestSchoolDetails(slug: String, itemUid: String, completion: ((Bool, [String: AnyObject]) -> Void)) {
        
        if itemUid.characters.count == 0 {
            NSLog("ItemUid cannot be empty");
            completion(false, [:])
        }
        
        let schoolPath = offlineDataPath() + "/\(slug)/\(slug).json"
        
        let dictionary = dictionaryFromFilePath(schoolPath)
        addFavoriteCountToDictionary(itemUid, dict: dictionary) { (success, augmentedDict) in
            completion(success, augmentedDict)
        }
    }
    
    
    // MARK: Helpers
    private func offlineDataPath() -> String {
        let offlineDataPathOrNil = NSBundle.mainBundle().pathForResource("OfflineData", ofType: nil)
        
        guard let offlineDataPath = offlineDataPathOrNil else {
            return ""
        }
        return offlineDataPath
    }
    
    /// Getting JSON file data and turn it into a Swift dictionary
    /// If the "id" key of the JSON is empty, use the "slug" as "id"
    private func dictionaryFromFilePath(filePath: String) -> [String: AnyObject] {
        // Pretend reading a program json file
        let programJSONURL = NSURL(fileURLWithPath: filePath)
        
        guard let programJSONData = NSData(contentsOfURL: programJSONURL) else {
            print("Program URL data empty (JPOfflineDataRequest)")
            return [:]
        }
        
        var itemDictionary: [String: AnyObject] = [:]
        do {
            itemDictionary = try NSJSONSerialization.JSONObjectWithData(programJSONData, options: []) as! [String : AnyObject]
            replaceEmptyItemIdWithSlugIfNecessary(&itemDictionary)
        } catch {
            return itemDictionary
        }
        
        return itemDictionary
    }
    
    
    // When inputing JSON data manually, putting in a random itemID for each JSON file is too cumbersome,
    // so itemId can be left empty and using slug as a placeholder itemId instead
    private func replaceEmptyItemIdWithSlugIfNecessary(inout itemDictionary: [String: AnyObject]) {
        
        if let itemId = itemDictionary["id"] as? String
            where itemId != "" && !itemId.isEqual(NSNull()) {
            // If itemId exists in the dictionary, do nothing
            return
        }
        
        itemDictionary["id"] = itemDictionary["slug"]
    }
    
    
    /**
     * @param completion (success, augmentedDictionary) pass back original dictionary if the new information cannot be fetched
     */
    private func addFavoriteCountToDictionary(itemUid: String, dict: [String: AnyObject], completion: ((Bool, [String: AnyObject]) -> Void)) {
        var tempDictionary: [String: AnyObject] = dict
        _cloudFavoritesHelper = JPCloudFavoritesHelper()
        _cloudFavoritesHelper?.getItemFavCountAsyncWithUid(itemUid, completionHandler: { (success, numFavorites) in
            tempDictionary["numFavorites"] = NSNumber(integer: numFavorites)
            completion(success, tempDictionary)
        })
    }

}
