//
//  DecodableJsonDataMappingObjectService.swift
//  app
//
//  Created by Aleksey on 12/01/2019.
//  Copyright © 2019 Grapheme. All rights reserved.
//

import Foundation

class JsonDataMappingObjectService<T: Decodable>:DataMappingObjectService<T>{
    
    let decoder: JSONDecoder
    
    convenience override init(){
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        self.init(decoder: decoder)
    }
    
    init(decoder: JSONDecoder){
        self.decoder = decoder
    }
    
    override func mappingObject(source: Data) throws -> T {
//        print(String(data: source, encoding: .utf8) ?? "")
        let result = try decoder.decode(T.self, from: source)
        return result
    }
}
