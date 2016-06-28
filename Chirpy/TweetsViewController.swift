//
//  TweetsViewController.swift
//  Chirpy
//
//  Created by David Melvin on 6/28/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    var tweets : [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
            
            //set up table view
            
            self.tweets = tweets
//            for tweet in tweets {
//                print(tweet.text)
//            }
        }) { (error: NSError) in
                print("hometimeline error: \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
