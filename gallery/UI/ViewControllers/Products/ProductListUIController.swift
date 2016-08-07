//
//  ProductListUIController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

class ProductListUIController {
    private unowned var view: UIView
    private unowned var activityIndicatorView: UIActivityIndicatorView
    private let tableViewDataSource: TableViewDataSource<ProductCellController, ProductTableViewCell>
    private let tableViewDelegate: TableViewDelegate
    
    var state: UIState = .loading {
        willSet(newState) {
            update(newState)
        }
    }

    init(view: UIView,
         tableView: UITableView,
         activityIndicator: UIActivityIndicatorView) {
        self.view = view
        self.activityIndicatorView = activityIndicator
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.tableViewDataSource = TableViewDataSource<ProductCellController, ProductTableViewCell>(tableView: tableView, nib: nib)
        tableView.dataSource = self.tableViewDataSource
        self.tableViewDelegate = TableViewDelegate(tableView: tableView)
        self.tableViewDelegate.rowHeight = 92
        tableView.delegate = self.tableViewDelegate
        update(state)
    }
}

extension ProductListUIController: ProductListDelegate {
    func update(newState: UIState) {
        switch (state, newState) {
        case (.loading, .loading):
            self.loadingToLoading()
        case (.loading, .success(let products)):
            self.loadingToSuccess(products)
        default: fatalError("Not yet implemented \(state) to \(newState)")
        }
    }
    
    func loadingToLoading() {
        activityIndicatorView.hidden = false
        activityIndicatorView.startAnimating()
    }
    
    func loadingToSuccess(products: [Product]) {
        activityIndicatorView.hidden = true
        activityIndicatorView.stopAnimating()
        self.tableViewDataSource.dataSource = products.map(ProductCellController.init)
    }
}