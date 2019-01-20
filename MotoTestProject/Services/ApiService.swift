//
//  ApiService.swift
//  MotoTestProject
//
//  Created by Aleksey on 16/01/2019.
//  Copyright © 2019 Motosport. All rights reserved.
//

import Foundation

enum ApiServerResult<T: Decodable>{
    case success(T)
    case failure(Error)
}

class ApiService<T: Decodable>{
    
    private let networkFetchDataService: NetworkFetchDataService
    private let dataMappingObjectService: DataMappingObjectService<T>
    
    init(){
        self.networkFetchDataService = NetworkFetchDataService()
        self.dataMappingObjectService = JsonDataMappingObjectService<T>()
    }
    
    func fetch(request: URLRequest, handler: @escaping (ApiServerResult<T>) -> ()) {
        networkFetchDataService.fetch(request: request){ result in
            switch result {
            case .success(let result):
                do{
                    let t = try self.dataMappingObjectService.mappingObject(source: result)
                    DispatchQueue.main.async{
                        handler(.success(t))
                    }
                }catch(let error){
                    DispatchQueue.main.async{
                        handler(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async{
                    handler(.failure(error))
                }
            }
        }
    }
    
    func cancel(){
        networkFetchDataService.currentDataTask?.cancel()
    }
    
    func getCurrentDataTast()->URLSessionDataTask?{
        return networkFetchDataService.currentDataTask
    }
    
}


