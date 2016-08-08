//
//  ProductCellController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//
import Foundation

protocol ProductCellRepresentable {
    var name: String { get }
    var subline: String { get }
    var navigationURL: NSURL { get }
    func selectCell(at indexPath: NSIndexPath)
}

struct ProductCellController: ProductCellRepresentable {
    let name: String
    let subline: String
    let navigationURL: NSURL
    
    init(product: Product) {
        self.name = product.name!
        self.subline = product.subline!
        self.navigationURL = product.navigationURL!
    }
    
    func selectCell(at indexPath: NSIndexPath) {
        
    }
}
