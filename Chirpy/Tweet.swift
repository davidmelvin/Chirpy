//
//  Tweet.swift
//  Chirpy
//
//  Created by David Melvin on 6/27/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit
import SwiftDate

//class TweetOld: NSObject {
//    var text: NSString?
//    var timestamp: NSDate?
//    var retweetCount: Int = 0
//    var favoritesCount: Int = 0
//    
//    init(dictionary: NSDictionary) {
//        text = dictionary["text"] as? String
//        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
//        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
//        
//        let timestampString = dictionary["created_at"] as? String
//        if let timestampString = timestampString {
//            let formatter = NSDateFormatter()
//            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//            timestamp = formatter.dateFromString(timestampString)
//        }
//    }
//    
//    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
//        var tweets = [Tweet]()
//    
//        for dictionary in dictionaries {
//            let tweet = Tweet(dictionary: dictionary)
//            tweets.append(tweet)
//        }
//        
//        return tweets
//    }
//}

class Tweet : NSObject {
    static let TextKey = "text"
    static let RetweetKey = "retweet_count"
    static let FavoritesKey = "favourites_count"
    static let TimestampKey = "created_at"
    static let TimestapDateFormat = "EEE MMM d HH:mm:ss Z y"
    static let UserKey = "user"
    
    
    private var tweetDictionary: NSMutableDictionary!
    
    private init(dictionary: NSDictionary) {
        super.init()
        tweetDictionary = NSMutableDictionary(dictionary: dictionary)
        //tweetDictionary = dictionary as! NSMutableDictionary
    }
    
    //What is this and should I use an empty NSDictionary here?
    convenience override init() {
        self.init( dictionary: NSDictionary() )
    }
    
    class func tweetsFromArray( tweetsDictionaries: [NSDictionary]) -> [Tweet] {
        return tweetsDictionaries.map( { Tweet(dictionary: $0) } )
    }
    
//    class func tweetsWithArrayVerbose(dictionaries: [NSDictionary]) -> [Tweet]{
//        var tweets : [Tweet] = []
//        
//        for dictionary in dictionaries {
//            let tweet = Tweet(dictionary: dictionary)
//            tweets.append(tweet)
//        }
//        
//        return tweets
//    }
//    var screenname : String? {
//        get {
//            return tweetDictionary[Tweet.UserKey]![Tweet.ScreennameKey] as? String
//        }
//        set(arg) {
//            tweetDictionary[Tweet.UserKey][Tweet.ScreennameKey] = arg
//        }
//    }
//    
//    var text : String? {
//        get {
//            return tweetDictionary[Tweet.TextKey] as? String
//        }
//        set(arg) {
//            tweetDictionary[Tweet.TextKey] = arg
//        }
//    }
    var user : User? {
        get {
            return User(dictionary: tweetDictionary[Tweet.UserKey] as! NSDictionary)
        }
        set(arg) {
            tweetDictionary[Tweet.UserKey] = arg
        }
    }
    var text : String? {
        get {
            return tweetDictionary[Tweet.TextKey] as? String
        }
        set(arg) {
            tweetDictionary[Tweet.TextKey] = arg
        }
    }
    
    var retweetsCount : Int? {
        get {
            return (tweetDictionary[Tweet.RetweetKey] as? Int) ?? 0
        }
        set(arg) {
            tweetDictionary[Tweet.RetweetKey] = arg
        }
    }
    
    
    var favoritesCount : Int? {
        get {
            return (tweetDictionary[Tweet.FavoritesKey] as? Int) ?? 0
        }
        set(arg) {
            tweetDictionary[Tweet.FavoritesKey] = arg
        }
    }
    
    var timestamp : String? {
        get {
            let timestampUnformatted = tweetDictionary[Tweet.TimestampKey] as? String
            let date: NSDate
            if let timestampUnformatted = timestampUnformatted {
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                date = formatter.dateFromString(timestampUnformatted)!
                return date.toRelativeString(abbreviated: true, maxUnits: 1)
            }
            else {
                return "long ago"
            }
        }
        set(arg) {
            tweetDictionary[Tweet.TimestampKey] = arg
        }
    }

}
