//
//  MockFileHelper.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 07/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import Foundation
class MockFileHelper: NSObject {
    static let shared = MockFileHelper()
    
    func readFromFile(jsonFile: String) -> NSData? {
        if let path = NSBundle(forClass: self.dynamicType)
            .pathForResource(jsonFile, ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                return jsonData
            }
        }
        return nil
    }

}
