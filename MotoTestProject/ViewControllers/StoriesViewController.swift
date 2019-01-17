//
//  ViewController.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {

    
    @IBOutlet private weak var feedsScrollView: UIScrollView!
    @IBOutlet private weak var feedsSegmentControl: UISegmentedControl!
    
    private let storiesFeed = StoriesFeedEnum.allCases
//    private var storiesPresenter: StoriesPresenterProtocol!
    private var feedViews = [FeedView]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateController()
        configurateSegmentControl()
        createFeeds()
        changeFeed(to: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutFeedViews()
    }

    private func layoutFeedViews() {
        let bounds = feedsScrollView.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        
        feedsScrollView.contentSize = CGSize(width: CGFloat(feedViews.count) * width, height: height)
        feedsScrollView.delegate = self
        
        for i in 0..<feedViews.count {
            let originX: CGFloat = CGFloat(i) * width
            feedViews[i].frame = CGRect(x: originX, y: 0, width: width, height: height)
        }
    }
    
    //MARK: Configurate
    
    private func configurateController(){
//        storiesPresenter = StoriesPresenter(view: self)
    }
    
    private func configurateSegmentControl(){
        feedsSegmentControl.removeAllSegments()
        for i in 0..<storiesFeed.count{
            feedsSegmentControl.insertSegment(withTitle: storiesFeed[i].feed.name, at: i, animated: false)
        }
    }
    
    private func createFeeds(){
        for i in 0..<storiesFeed.count{
            let feedView = FeedView(frame: feedsScrollView.bounds, feed: storiesFeed[i].feed)
            feedsScrollView.addSubview(feedView)
            feedViews.append(feedView)
        }
    }
    
    //MARK: Change feed
    
    func changeFeed(to index:Int){
        feedsScrollView.setContentOffset(CGPoint(x:feedsScrollView.bounds.width*CGFloat(index), y:0), animated: true)
        feedsSegmentControl.selectedSegmentIndex = index
        feedViews[feedsSegmentControl.selectedSegmentIndex].select()
    }
    
    //MARK: Actions
    
    @IBAction func feedChanged(_ sender: UISegmentedControl) {
        changeFeed(to: sender.selectedSegmentIndex)
    }

}

// MARK: - UIScrollViewDelegate
extension StoriesViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        changeFeed(to: index)
    }
}
