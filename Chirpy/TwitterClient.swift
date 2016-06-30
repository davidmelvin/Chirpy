//
//  TwitterClient.swift
//  Chirpy
//
//  Created by David Melvin on 6/27/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string:
        "https://api.twitter.com"), consumerKey: "nhGWh8uqVGlH0sAizQZ0rMWEQ", consumerSecret: "Mbnxsn1B8d7nNrYWgrneqQnLF8VEdVCEFHVJ8S1pMMYfMUP1mu")
    
    var loginSucess : (() -> ())?
    var loginFailure : ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSucess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"chirpy://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
            print("I got a token")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize/?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
        }) { (error: NSError!) in
            print(error.localizedDescription)
            self.loginFailure?(error)
            
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            
            self.currentAccount({ (user: User) in
                User.currentUser = user
                self.loginSucess?()
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
            })
            
        }) { (error: NSError!) in
            print("Handle open Url error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            
            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsFromArray(tweetDictionaries)
            success(tweets)
            
            }, failure:  {(task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
                
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters:  nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
                print(error.localizedDescription)
        })
    }
}
