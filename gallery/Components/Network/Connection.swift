//
//  Connection.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation

protocol Connectable {
    func makeConnection(resource: Resource,
                        completion: Result<NSData, Error> -> Void)
}

final class Connection {
    private let session: NSURLSession
    private let baseURL: NSURL
    
    init(url: NSURL,
         session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())) {
        self.baseURL = url
        self.session = session
    }
}

extension Connection: Connectable {
    func makeConnection(resource: Resource,
                        completion: Result<NSData, Error> -> Void) {
        
        let request = resource.toRequest(from: self.baseURL)
        
        session.dataTaskWithRequest(request) { (data, response, error) in
            switch (data, error) {
            case (let data?, _): completion(.success(data))
            case (_, let error?): completion(.failure(.network(error.description)))
            default: break
            }
        }.resume()
    }
}