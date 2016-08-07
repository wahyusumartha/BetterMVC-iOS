//
//  CellConfigurable.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

protocol CellConfigurable: class {
    associatedtype Controller
    var cellController: Controller? { get set }
}