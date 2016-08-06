//
//  Parser.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation
import Gloss

protocol Mappable {
    static func mapToModel(object: AnyObject) -> Result<Self, Error>
}

func parseArrayObject<T: Mappable>(data: NSData,
    completion: Result<[T], Error> -> Void) {
    let decodedData: Result<AnyObject, Error> = decodeData(data)
    
    switch decodedData {
    case .success(let result):
        guard let array = result as? [AnyObject] else { completion(.failure(.parser("object is not array"))); return }
        let result: Result<[T], Error> = arrayToModels(array)
        completion(result)
    case .failure:
        completion(.failure(.parser("fail to serialize json from nsdata")))
    }
}

func parseSingleObject<T: Mappable>(data: NSData,
                       completion: Result<T, Error> -> Void) {
    let decodedData: Result<AnyObject, Error> = decodeData(data)
    switch decodedData {
    case .success(let object):
        let result: Result<T, Error> = T.mapToModel(object)
        completion(result)
    case .failure:
        completion(.failure(.parser("fail to serialize json from nsdata")))
    }
}

private func arrayToModels<T: Mappable>(objects: [AnyObject]) -> Result<[T], Error> {
    var convertAndCleanArray: [T] = []
    
    for object in objects {
        guard case .success(let model) = T.mapToModel(object) else { continue }
        convertAndCleanArray.append(model)
    }

    return .success(convertAndCleanArray)
}


private func decodeData(data: NSData) -> Result<AnyObject, Error> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data,
                                                              options: NSJSONReadingOptions()) 
        return .success(json)
    } catch {
        return .failure(.parser("fail to serialize json from nsdata"))
    }
}