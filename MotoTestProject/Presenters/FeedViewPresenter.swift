//
//  FeedViewProtocol.swift
//  MotoTestProject
//
//  Created by Aleksey on 17/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

protocol FeedViewPresenterProtocol {
    func selectStory(_ story: Story)
    func loadFeed()
}

protocol FeedViewProtorol: class {
    func setStories(_ stories: [Story])
     func fetchedError(_ error: Error)
     func showHUD()
     func hideHUD()
}

class FeedViewPresenter{
    typealias StoryIDs = [Int]
    
    private weak var view: FeedViewProtorol?
    private var storiesArray: StoriesArray?
    private let fetchDataService = ApiService<StoryIDs>()
    private let feed: Feed
    private var isLoading = false
    
    init(view:FeedViewProtorol, feed: Feed){
        self.view=view
        self.feed=feed
    }
    
    func selectStory(_ story: Story) {
        
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
        fetchDataService.fetch(request: request){ result in
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
}
