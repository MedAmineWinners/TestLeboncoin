//
//  TestHomeViewController.swift
//  TestLeboncoinTests
//
//  Created by Stimlog on 08/10/2020.
//

import XCTest
@testable import TestLeboncoin

class TestHomeViewController: XCTestCase {
    var requestHandler: RequestHandler!
    let session = NetworkSessionMock()
    let homeViewController = HomeViewController()
    var items = [Item]()
    var categories = [ItemCategory]()
    override func setUp() {
        super.setUp()
        let itemPath = "file://"+Bundle(for: type(of: self)).path(forResource: "Items", ofType: "json")!
        guard let itemExpectedData = try? Data(contentsOf: URL(string: itemPath)!) else {
            fatalError("No data for url \(itemPath)")
        }
        let categoriesPath = "file://"+Bundle(for: type(of: self)).path(forResource: "Categories", ofType: "json")!
        guard let categoriesExpectedData = try? Data(contentsOf: URL(string: categoriesPath)!) else {
            fatalError("No data for url \(categoriesPath)")
        }
        items = itemExpectedData.decode()
        categories = categoriesExpectedData.decode()
        homeViewController.items = items
        homeViewController.categories = categories
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testShowItemsForCategory(){
        homeViewController.showItems(for: categories[0])
        XCTAssertTrue(homeViewController.filteredItems.count > 0)
        XCTAssertFalse(homeViewController.homeView.filterStackView.isHidden)
        XCTAssertTrue(homeViewController.filteredItems.allSatisfy{$0.category_id == categories[0].id})
    }
}
