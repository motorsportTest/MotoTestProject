//
//  MyURLRequest.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

enum MyURLRequest{
    
    static let baseURL = "https://hacker-news.firebaseio.com/v0/"
    static let endOfURL = ".json"
    
    case feed(Feed)
    
    var request: URLRequest?{
        guard let url = self.url else {
            return nil
        }
        print(url.absoluteString)
        let request = URLRequest(url: url)
        return request
    }
    
    var url: URL?{
        switch self {
        case .feed(let value):
            return URL(string: MyURLRequest.baseURL + value.path+MyURLRequest.endOfURL)
        }
    }
    
}
