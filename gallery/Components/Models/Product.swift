//
//  Product.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit
import Gloss

struct Product: Decodable {
    let name: String?
    let subline: String?
    let navigationURL: NSURL?
    let description: String?
    let startTimeFormatted: String?
    let bannerURL: NSURL?
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.subline = "subline" <~~ json
        self.navigationURL = "navigation_url" <~~ json
        self.description = "description" <~~ json
        self.startTimeFormatted = "start_time_formatted" <~~ json
        self.bannerURL = "banner_url" <~~ json
    }
}

extension Product: Mappable {
    static func mapToModel(object: AnyObject) -> Result<Product, Error> {
        return .success(Product(json: object as! JSON)!)
    }
}
