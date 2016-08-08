//
//  ProductViewController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    private let productsHandler: ProductListHandler
    private var productListUIController: ProductListUIController!
    
    
    init(productsHandler: ProductListHandler) {
        self.productsHandler = productsHandler
        super.init(nibName: "ProductViewController",
                   bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product List"

        self.productListUIController = ProductListUIController(view: self.view,
                                                               tableView: self.tableView, activityIndicator: self.loadingActivityIndicator)
        self.productsHandler.delegate = self.productListUIController
        self.productsHandler.fetchProducts()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ProductViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let product = self.productListUIController.products[indexPath.row]
        let productDetailController = ProductDetailController(product: product)
        let productDetailViewController = ProductDetailViewController(productDetailHandler: productDetailController)
        self.navigationController?.pushViewController(productDetailViewController,
                                                      animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 92
    }
    
    
}