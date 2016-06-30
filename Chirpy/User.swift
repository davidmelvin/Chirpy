//
//  User.swift
//  Chirpy
//
//  Created by David Melvin on 6/27/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    static let ScreennameKey = "screen_name"
    static let UserNameKey = "name"
    static let ProfileImageUrlKey = "profile_image_url_https"
    static let TaglineKey = "description"
    
    //    var name: NSString?
    //    var screenname: NSString?
    //    var profileUrl: NSURL?
    //    var tagline: NSString?
    //
    //    var dictionary : NSDictionary?
    var mutDictionary: NSMutableDictionary!
    //
    //    init(dictionary: NSDictionary) {
    //        self.dictionary = dictionary
    //        name = dictionary["name"] as? String
    //        screenname = dictionary["screen_name"] as? String
    //
    //        let profileURLString = dictionary["profile_image_url_https"] as? String
    //        if let profileURLString = profileURLString {
    //            profileUrl = NSURL(string: profileURLString)
    //        }
    //        tagline = dictionary["description"] as? String
    //    }
    
    convenience override init() {
        self.init( dictionary: NSMutableDictionary())
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        mutDictionary = dictionary as? NSMutableDictionary
    }
    
    static var _currentUser : User?
    
    var name : String? {
        get {
            return mutDictionary[User.UserNameKey] as? String
        }
        set(arg) {
            mutDictionary[User.UserNameKey] = arg
        }
    }
    
    var screenname : String? {
        get {
            return mutDictionary[User.ScreennameKey] as? String
        }
        set(arg) {
            mutDictionary[User.ScreennameKey] = arg
        }
    }
    
    var tagline : String? {
        get {
            return mutDictionary[User.TaglineKey] as? String
        }
        set(arg) {
            mutDictionary[User.TaglineKey] = arg
        }
    }
    
    var profileImageURL : NSURL? {
        get {
            if let string = mutDictionary[User.ProfileImageUrlKey] as? String {
                return NSURL(string: string)
            }
            else {
                return nil
            }
        }
        set(arg) {
            mutDictionary[User.ProfileImageUrlKey] = arg
        }
    }
        
    class var currentUser : User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.mutDictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }
            else {
                defaults.setObject(nil, forKey: "currentUserData'")
            }
            
            defaults.synchronize()
            
        }
    }
}
