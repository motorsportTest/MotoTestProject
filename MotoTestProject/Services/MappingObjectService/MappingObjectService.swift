//
//  MappingObjectService.swift
//  app
//
//  Created by Aleksey on 12/01/2019.
//  Copyright © 2019 Grapheme. All rights reserved.
//

import Foundation

protocol MappingObjectService {
    associatedtype Source
    associatedtype MappingObject
    func mappingObject(source: Source) throws -> MappingObject
}
