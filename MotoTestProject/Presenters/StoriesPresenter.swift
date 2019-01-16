//
//  StoriesPresenter.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

protocol StoriesPresenterProtocol {
    func selectStory(_ story: Story)
    func selectFeed(_ feed: Feed)
}

protocol StoriesView: class {
    func setStories(_ stories: [Story])
    func fetchedError(_ error: Error)
}

class StoriesPresenter: StoriesPresenterProtocol{
    typealias StoryIDs = [Int]
    
    private weak var view: StoriesView?
    private let fetchDataService = ApiService<StoryIDs>()
    
    init(view:StoriesView){
        self.view=view
    }
    
    func selectStory(_ story: Story) {
        
    }
    
    func selectFeed(_ feed: Feed) {
        guard let request = MyURLRequest.feed(feed).request else {
            return
        }
        fetchDataService.fetch(request: request){ result in
            switch result{
            case .success(let storiesID):
                let storiesArray = StoriesArray(ids: storiesID)
                self.view?.setStories(storiesArray.stories)
            case .failure(let error):
                self.view?.fetchedError(error)
            }
        }
    }
    
}
