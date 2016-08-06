//
//  ProductTests.swift
//  gallery
//
//  Created by Wahyu Sumartha  on 06/08/2016.
//  Copyright © 2016 Wahyu Sumartha . All rights reserved.
//

import XCTest
@testable import gallery

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testProductJSONParse() {
        let data = self.readFromFile("product")
        let json = try? NSJSONSerialization.JSONObjectWithData(data!,
                                                               options: NSJSONReadingOptions()) as! [String: AnyObject]
        let product = Product(json: json!)
        XCTAssertEqual(product?.name, "Die moderne KÃ¼che")
        XCTAssertEqual(product?.subline, "Geradliniges Design fÃ¼r Puristen")
        XCTAssertEqual(product?.navigationURL, NSURL(string: "https://static.westwing.de/c/c-die-moderne-kueche2-05131-n.jpg"))
        XCTAssertEqual(product?.description, "FÃ¼r Trends haben Sie ein sicheres GespÃ¼r und Ihr Interior wirkt immer zeitgemÃ¤ÃŸ? HÃ¶chste Zeit auch die eigene KÃ¼che auf dem neuesten Stand zu halten! Und deshalb haben wir fÃ¼r Sie moderne, hochwertige Produkte ausgewÃ¤hlt: Vom Kochgeschirr Ã¼ber KÃ¼chenutensilien bis hin zum Aufbewahrungshelfer â€“ hier finden Sie alles, um Ihrer KÃ¼che die erste Haube aufzusetzen!")
        XCTAssertEqual(product?.startTimeFormatted, "Heute")
        XCTAssertEqual(product?.bannerURL, NSURL(string: "https://static.westwing.de/c/c-die-moderne-kueche2-05131-ml.jpg"))
    }
    
    private func readFromFile(jsonFile: String) -> NSData? {
        if let path = NSBundle(forClass: self.dynamicType)
            .pathForResource(jsonFile, ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                return jsonData
            }
        }
        return nil
    }

}
