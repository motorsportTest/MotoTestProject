//
//  FeedView.swift
//  MotoTestProject
//
//  Created by Aleksey on 17/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit

class FeedView: XIBView {

    @IBOutlet private weak var storiesActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var storyTableView: UITableView!
    
    private let reuseCellIdentifier = "Cell"
    private var feedViewPresenter: FeedViewPresenter!
    private var stories = [Story](){
        didSet{
            storyTableView.reloadData()
        }
    }
    
    init(frame: CGRect, feed: Feed) {
        super.init(frame: frame)
        self.feedViewPresenter = FeedViewPresenter(view: self, feed: feed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didLoad() {
        storyTableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: reuseCellIdentifier)
    }
    
    func select(){
        feedViewPresenter.loadFeed()
    }
    
}

extension FeedView: FeedViewProtorol{
    
    func showHUD() {
        storyTableView.isHidden = true
        storiesActivityIndicator.isHidden = false
        storiesActivityIndicator.startAnimating()
    }
    
    func hideHUD() {
        storyTableView.isHidden = false
        storiesActivityIndicator.stopAnimating()
    }
    
    func setStories(_ stories: [Story]) {
        self.stories = stories
    }
    
    func fetchedError(_ error: Error) {

    }
}

extension FeedView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! StoryTableViewCell
        cell.configurate(story: stories[indexPath.row])
        return cell
    }
    
}

extension FeedView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        feedViewPresenter.selectStory(stories[indexPath.row])
    }
}

