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
        let data = MockFileHelper.shared.readFromFile("product")
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
    
    func testArrayProductJSONParse() {
        let data = MockFileHelper.shared.readFromFile("products")
        let parseCompletion = self.parseArrayCompletion()
        parseArrayObject(data!,
                         completion: parseCompletion)
    }
    
    func testSingleProductJSONParse() {
        let data = MockFileHelper.shared.readFromFile("product")
        let parseCompletion = self.parseSingleObjectCompletion()
        parseSingleObject(data!,
                          completion: parseCompletion)
    }
    
    private func parseArrayCompletion() -> Result<[Product], Error> -> Void {
        return { productsResult in
            switch productsResult {
            case .success(let products):
                XCTAssertEqual(products.count, self.calculateProductsMockDataSize())
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        }
    }
    
    private func parseSingleObjectCompletion() -> Result<Product, Error> -> Void {
        return { productResult in
            switch productResult {
            case .success(let product):
                XCTAssertEqual(product.name, "Die moderne KÃ¼che")
                XCTAssertEqual(product.subline, "Geradliniges Design fÃ¼r Puristen")
                XCTAssertEqual(product.navigationURL, NSURL(string: "https://static.westwing.de/c/c-die-moderne-kueche2-05131-n.jpg"))
                XCTAssertEqual(product.description, "FÃ¼r Trends haben Sie ein sicheres GespÃ¼r und Ihr Interior wirkt immer zeitgemÃ¤ÃŸ? HÃ¶chste Zeit auch die eigene KÃ¼che auf dem neuesten Stand zu halten! Und deshalb haben wir fÃ¼r Sie moderne, hochwertige Produkte ausgewÃ¤hlt: Vom Kochgeschirr Ã¼ber KÃ¼chenutensilien bis hin zum Aufbewahrungshelfer â€“ hier finden Sie alles, um Ihrer KÃ¼che die erste Haube aufzusetzen!")
                XCTAssertEqual(product.startTimeFormatted, "Heute")
                XCTAssertEqual(product.bannerURL, NSURL(string: "https://static.westwing.de/c/c-die-moderne-kueche2-05131-ml.jpg"))
            case .failure(let error):
                XCTFail("Failed \(error)")
            }
        }
    }
    
    private func calculateProductsMockDataSize() -> Int {
        let data = MockFileHelper.shared.readFromFile("products")
        let jsonData = try? NSJSONSerialization.JSONObjectWithData(data!,
                                                                   options: NSJSONReadingOptions())
        return jsonData!.count
    }
    

}
