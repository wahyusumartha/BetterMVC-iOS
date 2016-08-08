//
//  ProductDetailUIController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation

class ProductDetailUIController {
    private unowned var viewController: ProductDetailViewController
    
    var product: Product? = nil {
        willSet(newProduct) {
            assignProductToUserInterface(newProduct!)
        }
    }
    
    init(viewController: ProductDetailViewController) {
        self.viewController = viewController
    }
}

extension ProductDetailUIController: ProductDetailDelegate {
    func assignProductToUserInterface(newProduct: Product) {
        let viewController = self.viewController
        viewController.bannerImageView.sd_setImageWithURL(newProduct.bannerURL)
        viewController.descriptionLabel.text = newProduct.description
        viewController.productNameLabel.text = newProduct.name
        viewController.startTimeFormatLabel.text = newProduct.startTimeFormatted
        viewController.sublineLabel.text = newProduct.subline
    }
}