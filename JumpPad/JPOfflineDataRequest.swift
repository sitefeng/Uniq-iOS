//
//  JPOfflineDataRequest.swift
//  Uniq
//
//  Created by Si Te Feng on 8/13/16.
//  Copyright © 2016 Si Te Feng. All rights reserved.
//


@objc internal protocol JPOfflineDataRequestDelegate {
    
    func offlineDataRequest(request: JPOfflineDataRequest, didLoadAllItemsOfType type: JPDashletType, dataArray: [AnyObject], isSuccessful: Bool)
    
}


internal final class JPOfflineDataRequest: NSObject {
    
    var delegate: JPOfflineDataRequestDelegate?
    
    override init() {
        super.init()
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
                let schoolDictionary = try NSJSONSerialization.JSONObjectWithData(schoolJSONData!, options: [])
                dataArray.append(schoolDictionary)
            } catch {
                print("JSON error")
                return
            }
        }
        
        delegate?.offlineDataRequest(self, didLoadAllItemsOfType: JPDashletType.School, dataArray: dataArray, isSuccessful: true)
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
            let facultyJSONData = NSData(contentsOfURL: facultyJSONURL)
            
            do {
                let facultyDictionary = try NSJSONSerialization.JSONObjectWithData(facultyJSONData!, options: [])
                dataArray.append(facultyDictionary)
            } catch {
                return
            }
            
        }
        
        delegate?.offlineDataRequest(self, didLoadAllItemsOfType: JPDashletType.Faculty, dataArray: dataArray, isSuccessful: true)
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
                let programDictionary = try NSJSONSerialization.JSONObjectWithData(programJSONData!, options: [])
                dataArray.append(programDictionary)
            } catch {
                return
            }
        }
        
        delegate?.offlineDataRequest(self, didLoadAllItemsOfType: JPDashletType.Program, dataArray: dataArray, isSuccessful: true)
    }
    
    // MARK: - Serialized Requests
    
    //MARK: Request for school location
    func requestLocationForSchool(schoolSlug: String) -> JPLocation {
        assert(schoolSlug != "", "School Slug cannot be empty")

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
    
    
    /// Get program details in dictionary format
    func requestProgramDetails(schoolSlug: String, facultySlug: String, programSlug: String) -> [String: AnyObject] {
        
        let programPath = offlineDataPath() + "/\(schoolSlug)/\(facultySlug)/\(programSlug).json"
        
        let programJSONURL = NSURL(fileURLWithPath: programPath)
        let programJSONData = NSData(contentsOfURL: programJSONURL)!
        
        var programDict: [String: AnyObject] = [:]
        do {
            programDict = try NSJSONSerialization.JSONObjectWithData(programJSONData, options: []) as! [String : AnyObject]
        } catch {
            return programDict
        }
        
        return programDict
    }
    
    
    // MARK: Helpers
    func offlineDataPath() -> String {
        let offlineDataPathOrNil = NSBundle.mainBundle().pathForResource("OfflineData", ofType: nil)
        
        guard let offlineDataPath = offlineDataPathOrNil else {
            return ""
        }
        return offlineDataPath
    }

}
