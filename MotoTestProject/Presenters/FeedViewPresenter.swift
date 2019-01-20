//
//  FeedViewProtocol.swift
//  MotoTestProject
//
//  Created by Aleksey on 17/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import UIKit

protocol FeedViewPresenterProtocol {
    func selectStory(_ story: Story)
    func loadFeed()
    func fetchStoryData(_ story: Story)
}

protocol FeedViewProtorol: class {
    func setStories(_ stories: [Story])
    func didFetchedStoryData(_ StoryData: StoryData)
    func fetchedError(_ error: Error)
    func showHUD()
    func hideHUD()
}

class FeedViewPresenter{
    typealias StoryIDs = [Int]
    
    private var router: Router!
    private weak var view: FeedViewProtorol?
    private var storiesArray: StoriesArray?
    private let apiService = ApiService<StoryIDs>()
    private let feed: Feed
    private var isLoading = false
    private var activeDownloader = [Story: StoryDownloader]()
    
    init(view:FeedViewProtorol, feed: Feed, viewController:UIViewController){
        self.view=view
        self.feed=feed
        self.router = Router(viewController: viewController)
    }
    
    func selectStory(_ story: Story) {
        guard story.storyData != nil else {
            return
        }
        router.openStory(story)
    }
    
    func loadFeed() {
        if let storiesArray = storiesArray{
            self.view?.setStories(storiesArray.stories)
            return
        }
        guard let request = MyURLRequest.feed(feed).request else {
            return
        }
        guard !isLoading else{
            return
        }
        isLoading=true
        self.view?.showHUD()
        apiService.fetch(request: request){ result in
            self.view?.hideHUD()
            switch result{
            case .success(let storiesID):
//                print(self.feed.name, "success")
                let storiesArray = StoriesArray(ids: storiesID)
                self.storiesArray = storiesArray
                self.view?.setStories(storiesArray.stories)
            case .failure(let error):
//                print(self.feed.name, error.localizedDescription)
                self.view?.fetchedError(error)
            }
            self.isLoading=false
        }
    }
    
    func fetchStoryData(_ story: Story){
        guard activeDownloader[story] == nil else {
            return
        }
        if let request = MyURLRequest.story(id: story.id).request{
            let apiService = ApiService<StoryData>()
            apiService.fetch(request: request){result in
                switch result{
                case .success(let storyData):
                    self.view?.didFetchedStoryData(storyData)
                case .failure(let error):
                    print(story.id, error.localizedDescription)
                }
                self.activeDownloader[story] = nil
            }
            if let dataTask = apiService.getCurrentDataTast(){
               activeDownloader[story] = StoryDownloader(dataTask: dataTask)
            }
        }
    }
}
