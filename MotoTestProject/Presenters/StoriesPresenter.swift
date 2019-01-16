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
}

class StoriesPresenter: StoriesPresenterProtocol{
    
    private weak var view: StoriesView?
    
    init(view:StoriesView){
        self.view=view
    }
    
    func selectStory(_ story: Story) {
        
    }
    
    func selectFeed(_ feed: Feed) {
        
    }
    
}
