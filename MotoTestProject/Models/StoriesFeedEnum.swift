//
//  StoriesFeed.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation


enum StoriesFeedEnum: CaseIterable{
    
    case top
    case new
    case best
    
    var feed: Feed{
        switch self {
        case .top:
            return Feed(name: "Top", path: "topstories")
        case .new:
            return Feed(name: "New", path: "newstories")
        case .best:
            return Feed(name: "Best", path: "beststories")
        }
    }
}
