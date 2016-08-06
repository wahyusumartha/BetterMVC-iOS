//
//  Resource.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation

struct Resource {
    let path: String
    let method: Method
}

enum Method: String {
    case GET
    case POST
}

extension Resource {
    func toRequest(from baseURL: NSURL) -> NSURLRequest {
        let components = NSURLComponents(URL: baseURL,
                                         resolvingAgainstBaseURL: false)
        components?.path = path
        let finalURL = components?.URL ?? baseURL
        let request = NSMutableURLRequest(URL: finalURL)
        request.HTTPMethod = method.rawValue
        return request
    }
}

