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
    
    private weak var view: StoriesView?
    private let fetchDataService: NetworkFetchDataService!
    
    init(view:StoriesView){
        self.view=view
        fetchDataService = NetworkFetchDataService()
    }
    
    func selectStory(_ story: Story) {
        
    }
    
    func selectFeed(_ feed: Feed) {
        guard let request = MyURLRequest.feed(feed).request else {
            return
        }
        fetchDataService.fetch(request: request){ result in
            switch result{
            case .success(let data):
                do{
//                    print(String(data: data, encoding: .utf8) ?? "")
                    let result = try JSONDecoder().decode([Int].self, from: data)
                    let storiesArray = StoriesArray(ids: result)
                    DispatchQueue.main.async {
                        self.view?.setStories(storiesArray.stories)
                    }
                }
                catch{
                    print(error)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.fetchedError(error)
                }
            }
        }
    }
    
}
