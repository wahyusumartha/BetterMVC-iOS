//
//  ProductDetailController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 08/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation

protocol ProductDetailDelegate: class {
    var product: Product? { get set }
}

protocol ProductDetailHandler: class {
    var delegate: ProductDetailDelegate? { get set }
    func bindProduct()
}

class ProductDetailController: ProductDetailHandler {
    
    private let product: Product
    var delegate: ProductDetailDelegate?
    
    init(product: Product) {
        self.product = product
    }
    
    func bindProduct() {
        guard let delegate = self.delegate else { fatalError("forget to set ProductDetailDelegate") }
        delegate.product = self.product
    }
}
