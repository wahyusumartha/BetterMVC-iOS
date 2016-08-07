//
//  AlertController.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import UIKit

func showAlertInViewController(viewController: UIViewController = (UIApplication.sharedApplication().delegate as! AppDelegate).window!.rootViewController!,
                               title: String,
                               message: String) {
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .Alert)
    let alertAction = UIAlertAction(title: "OK",
                                    style: .Cancel,
                                    handler: nil)
    alertController.addAction(alertAction)
    viewController.presentViewController(alertController,
                                         animated: true,
                                         completion: nil)
}
