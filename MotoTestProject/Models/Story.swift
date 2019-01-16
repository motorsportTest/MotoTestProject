//
//  Story.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

struct Story: Decodable {
    let id: Int
}

struct StoriesArray {
    
    let stories: [Story]
    
    init(ids: [Int]) {
        stories = ids.map{Story(id: $0)}
    }
    
}
