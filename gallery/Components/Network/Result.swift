//
//  Result.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation

enum Result<T, E: ErrorType> {
    case success(T)
    case failure(E)
}