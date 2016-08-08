//
//  ProductDetailViewController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startTimeFormatLabel: UILabel!
    @IBOutlet weak var sublineLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    private let productDetailHandler: ProductDetailHandler
    private var productDetailListUIController: ProductDetailUIController!
    
    init(productDetailHandler: ProductDetailHandler) {
        self.productDetailHandler = productDetailHandler
        super.init(nibName: "ProductDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productDetailListUIController = ProductDetailUIController(viewController: self)
        self.productDetailHandler.delegate = self.productDetailListUIController
        self.productDetailHandler.bindProduct()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
