//
//  ProductsController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation

enum UIState {
    case loading
    case success([Product])
    case failure(Error)
}

protocol ProductListDelegate: class {
    var state: UIState { get  set }
}

protocol ProductListHandler: class {
    var delegate: ProductListDelegate? { get set }
    func fetchProducts()
}

final class ProductListController: ProductListHandler {
    private let connectable: Connectable
    var delegate: ProductListDelegate?
    
    init(connectable: Connectable) {
        self.connectable = connectable
    }
    
    func fetchProducts() {
        guard let delegate = self.delegate else { fatalError("forget to set productlistdelegate") }
        
        delegate.state = .loading
        let resource = Resource(path: "/cms/dont-delete/programming_task/data.json",
                                method: .GET)
        let parsingCompletion = createParsingCompletion(fromDelegate: delegate)
        let networkCompletion = createNetworkCompletion(fromDelegate: delegate,
                                                        completion: parsingCompletion)
        self.connectable.makeConnection(resource,
                                        completion: networkCompletion)
    }
}

private typealias parseCompletion = Result<[Product], Error> -> Void
private typealias networkCompletion = Result<NSData, Error> -> Void

private func createParsingCompletion(fromDelegate delegate: ProductListDelegate) -> parseCompletion {
    return { productsResult in
        dispatch_async(dispatch_get_main_queue(), { 
            switch productsResult {
            case .success(let products):
                delegate.state = .success(products)
            case .failure(let error):
                delegate.state = .failure(error)
            }
        })
    }
}

private func createNetworkCompletion(fromDelegate delegate: ProductListDelegate,
                                                  completion: parseCompletion) -> networkCompletion {
    return { dataResult in
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), { 
            switch dataResult {
            case .success(let data):
                parseArrayObject(data,
                    completion: completion)
            case .failure(let error):
                delegate.state = .failure(error)
            }
        })
    }
}