//
//  Error.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation
enum Error: ErrorType {
    case network(String)
    case parser
}