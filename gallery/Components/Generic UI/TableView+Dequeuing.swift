//
//  TableView+Dequeuing.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(Self) }
}

extension UITableView {
    func registerReusableCell<T: UITableViewCell where T: Reusable>(_: T.Type) {
        registerClass(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerCellFromNib<T: UITableViewCell where T: Reusable>(_: T.Type, nib: UINib?) {
        registerNib(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: Reusable>(at indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(T.reuseIdentifier,
                                                 forIndexPath: indexPath) as! T
    }
}