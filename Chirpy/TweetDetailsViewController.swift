//
//  TweetDetailsViewController.swift
//  Chirpy
//
//  Created by David Melvin on 6/29/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    var tweet : Tweet! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImageView.setImageWithURL(tweet.user!.profileImageURL!)
        usernameLabel.text = tweet.user!.name
        screennameLabel.text = tweet.user!.screenname
        timestampLabel.text = tweet.absoluteTimestamp
        likesCountLabel.text =  "\(tweet.favoritesCount!)"
        retweetCountLabel.text = "\(tweet.retweetsCount!)"
        tweetTextLabel.text = tweet.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
