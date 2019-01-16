//
//  DecodableJsonDataMappingObjectService.swift
//  app
//
//  Created by Aleksey on 12/01/2019.
//  Copyright © 2019 Grapheme. All rights reserved.
//

import Foundation

class JsonDataMappingObjectService<T: Decodable>:DataMappingObjectService<T>{
    
    let encoder: JSONDecoder
    
    convenience override init(){
        self.init(encoder: JSONDecoder())
    }
    
    init(encoder: JSONDecoder){
        self.encoder = encoder
    }
    
    override func mappingObject(source: Data) throws -> T {
        let result = try encoder.decode(T.self, from: source)
        return result
    }
}
