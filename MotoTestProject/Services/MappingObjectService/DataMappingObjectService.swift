//
//  DataMappingObjectService.swift
//  app
//
//  Created by Aleksey on 12/01/2019.
//  Copyright © 2019 Grapheme. All rights reserved.
//

import Foundation

class DataMappingObjectService<T>: MappingObjectService{
    
    typealias Source = Data
    typealias MappingObject = T
    
    func mappingObject(source: Data) throws -> T {
        preconditionFailure("Method must be overridden")
    }
}
