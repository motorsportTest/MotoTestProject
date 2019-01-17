//
//  StoriesPresenter.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

protocol StoriesPresenterProtocol {

}

protocol StoriesView: class {

}

class StoriesPresenter: StoriesPresenterProtocol{
    
    private weak var view: StoriesView?
    
    init(view:StoriesView){
        self.view=view
    }
    
}
