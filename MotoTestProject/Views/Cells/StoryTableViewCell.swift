//
//  StoryTableViewCell.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var storyView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentsCountdateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configurate(story: Story){
        if let storyData = story.storyData{
            activityIndicatorView.stopAnimating()
            storyView.isHidden = false
            titleLabel.text = storyData.title ?? "Empty title"
            scoreLabel.text = String(storyData.score ?? 0)
            commentsCountdateLabel.text = String(storyData.commentCount ?? 0)
            authorLabel.text = storyData.authorName ?? ""
            if let date = storyData.createdAt{
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateLabel.text = dateFormatter.string(from: date)
            }else{
                dateLabel.text = ""
            }
        }else{
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
            storyView.isHidden = true
        }
    }

}
