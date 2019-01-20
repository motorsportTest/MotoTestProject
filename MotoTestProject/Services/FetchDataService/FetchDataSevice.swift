//
//  FetchDataSevice.swift
//  app
//
//  Created by Aleksey on 12/01/2019.
//  Copyright © 2019 Grapheme. All rights reserved.
//

import Foundation

enum FetchDataViewResult{
    case success(Data)
    case failure(Error)
}

protocol FetchDataService{
    func fetch(handler: @escaping (FetchDataViewResult)->())
}
