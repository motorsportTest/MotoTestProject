//
//  ViewController.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {

    @IBOutlet private weak var storyTableView: UITableView!
    @IBOutlet private weak var storiesSegmentControl: UISegmentedControl!
    
    
    private let storiesFeed = StoriesFeedEnum.allCases
    private var storiesPresenter: StoriesPresenterProtocol!
    
    private let reuseCellIdentifier = "Cell"
    private var stories = [Story](){
        didSet{
            storyTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateController()
        configurateSegmentControl()
        storiesPresenter.selectFeed(storiesFeed[storiesSegmentControl.selectedSegmentIndex].feed)
    }
    
    //MARK: Configurate
    
    private func configurateController(){
        storiesPresenter = StoriesPresenter(view: self)
    }
    
    private func configurateSegmentControl(){
        storiesSegmentControl.removeAllSegments()
        for i in 0..<storiesFeed.count{
            storiesSegmentControl.insertSegment(withTitle: storiesFeed[i].feed.name, at: i, animated: false)
        }
        storiesSegmentControl.selectedSegmentIndex = 0
    }
    
    //MARK: Actions
    
    @IBAction func feedChanged(_ sender: UISegmentedControl) {
        storiesPresenter.selectFeed(storiesFeed[sender.selectedSegmentIndex].feed)
    }

}

extension StoriesViewController: StoriesView{
    func setStories(_ stories: [Story]) {
        self.stories = stories
    }
}

extension StoriesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! StoryTableViewCell
        cell.configurate(story: stories[indexPath.row])
        return cell
    }
    
}

extension StoriesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        storiesPresenter.selectStory(stories[indexPath.row])
    }
}
