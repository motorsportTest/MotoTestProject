//
//  NetworkFwetchDataService.swift
//  app
//
//  Created by Aleksey on 12/01/2019.
//  Copyright © 2019 Grapheme. All rights reserved.
//

import Foundation

class NetworkFetchDataService: FetchDataService{
 
    enum NetworkError: String, LocalizedError{
        case missingData = "Fetched missing data"
        case errorServerCode = "Fetched server error"
        case responseError = "Response error"
        
        var errorDescription: String? {
            return self.rawValue
        }
    }
    
    private var request: URLRequest?
    var currentDataTask: URLSessionDataTask?
    
    init(request: URLRequest? = nil){
        self.request = request
    }
    
    func fetch(request: URLRequest, handler: @escaping (FetchDataViewResult) -> ()){
        self.request = request
        fetch(handler: handler)
    }
    
    func fetch(handler: @escaping (FetchDataViewResult) -> ()) {
        guard let request = request else{ return }
        currentDataTask = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                handler(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                guard (200..<300).contains(httpResponse.statusCode) else{
                    handler(.failure(NetworkError.errorServerCode))
                    return
                }
                guard let data = data else {
                    handler(.failure(NetworkError.missingData))
                    return
                }
                handler(.success(data))
            }else{
                handler(.failure(NetworkError.responseError))
            }
        }
        currentDataTask?.resume()
    }
}
