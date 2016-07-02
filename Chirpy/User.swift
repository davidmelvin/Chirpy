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
    static let followersCountKey = "followers_count"
    static let followingCountKey = "friends_count"
    static let locationKey = "location"
    static let profileBanneyKey = "profile_banner_url"
    static let tweetCountKey = "statuses_count"
    static let userIDKey = "id_str"
    
    var mutDictionary: NSMutableDictionary!
    
    convenience override init() {
        self.init( dictionary: NSMutableDictionary())
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        mutDictionary = dictionary as? NSMutableDictionary
    }
    
    static var _currentUser : User?
    
    var id : String? {
        get {
            return mutDictionary[User.userIDKey] as? String
        }
    }
    
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
    
    var profileBannerImageURL : NSURL? {
        get {
            if let string = mutDictionary[User.profileBanneyKey] as? String {
                return NSURL(string: string)
            }
            else {
                //use a default background image
                return NSURL(string: "https://pbs.twimg.com/profile_banners/6253282/1431474710/mobile_retina")
            }
        }
    }
    
    var location : String? {
        get {
            return mutDictionary[User.locationKey] as? String
        }
        
    }
    
    var followersCount : Int {
        get {
            return (mutDictionary[User.followersCountKey] as? Int)!
        }
    }
    
    var follwingCount : Int {
        get {
            return (mutDictionary[User.followingCountKey] as? Int)!
        }
    }
    
    var tweetCount : Int {
        get {
            return (mutDictionary[User.tweetCountKey] as? Int)!
        }
    }
    
//    var tweets : [Tweet]? {
//        get {
//            var tweetArray : [Tweet] = []
//                        return tweetArray
//        }
//    }
    
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
