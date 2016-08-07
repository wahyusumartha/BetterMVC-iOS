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
    private unowned var tableView: UITableView
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
        self.tableView = tableView
        self.activityIndicatorView = activityIndicator
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.tableViewDataSource = TableViewDataSource<ProductCellController, ProductTableViewCell>(tableView: self.tableView, nib: nib)
        self.tableView.dataSource = self.tableViewDataSource
        
        self.tableViewDelegate = TableViewDelegate(tableView: tableView)
        self.tableViewDelegate.rowHeight = 92
        self.tableView.delegate = self.tableViewDelegate
        
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
        case (.loading, .failure(let error)):
            self.loadingToError(error)
        default: fatalError("Not yet implemented \(state) to \(newState)")
        }
    }
    
    func loadingToLoading() {
        self.tableView.hidden = true
        self.activityIndicatorView.hidden = false
        self.activityIndicatorView.startAnimating()
    }
    
    func loadingToSuccess(products: [Product]) {
        self.activityIndicatorView.hidden = true
        self.activityIndicatorView.stopAnimating()
        self.tableView.hidden = false
        self.tableViewDataSource.dataSource = products.map(ProductCellController.init)
    }
    
    func loadingToError(let error: Error) {
        dispatch_async(dispatch_get_main_queue()) {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidden = true
            showAlertInViewController(title: "Error",
                                      message: "\((error as NSError).localizedDescription)")
        }
    }
}