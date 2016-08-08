//
//  TableViewDataSource.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

final class TableViewDataSource<Model, Cell: UITableViewCell where Cell: Reusable, Cell: CellConfigurable, Model == Cell.Controller>: NSObject, UITableViewDataSource {
    
    var dataSource: [Model] = [] {
        didSet { tableView.reloadData() }
    }
    
    private unowned var tableView: UITableView
    
    init(tableView: UITableView, nib: UINib) {
        self.tableView = tableView
        tableView.registerCellFromNib(Cell.self, nib: nib)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(at: indexPath)
        cell.cellController = dataSource[indexPath.row]
        return cell
    }
}
