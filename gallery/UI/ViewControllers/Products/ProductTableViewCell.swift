//
//  ProductTableViewCell.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var navigationImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sublineLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var cellController: ProductCellController? {
        didSet {
            guard let controller = cellController  else { return }
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
            
            self.nameLabel.text = controller.name
            self.sublineLabel.text = controller.subline
            self.navigationImageView.sd_setImageWithURL(controller.navigationURL) { (image, error, cacheType, url) in
                if let _ = image {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidden = true
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension ProductTableViewCell: Reusable {}
extension ProductTableViewCell: CellConfigurable {}