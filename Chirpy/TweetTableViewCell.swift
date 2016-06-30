//
//  TweetTableViewCell.swift
//  Chirpy
//
//  Created by David Melvin on 6/29/16.
//  Copyright © 2016 David Melvin. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var relativeTimestampLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var tweet : Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            userNameLabel.text = tweet.user!.name
            screenameLabel.text = tweet.user!.screenname
            profileImage.setImageWithURL(tweet.user!.profileImageURL!)
            relativeTimestampLabel.text = tweet.timestamp
            favoritesLabel.text =  "\(tweet.favoritesCount!)"
            retweetsLabel.text = "\(tweet.retweetsCount!)"
            
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
