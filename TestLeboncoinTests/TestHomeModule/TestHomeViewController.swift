//
//  TestHomeViewController.swift
//  TestLeboncoinTests
//
//  Created by Stimlog on 08/10/2020.
//

import XCTest
@testable import TestLeboncoin

class TestHomeViewController: XCTestCase {
    var requestHandler: RequestHandler?
    let session = NetworkSessionMock()
    let homeViewController = HomeViewController()
    var items = [Item]()
    var categories = [ItemCategory]()
    override func setUp() {
        super.setUp()
        
        guard let bundle = Bundle(for: type(of: self)).path(forResource: "Items", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let itemExpectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        guard let categoryBundle = Bundle(for: type(of: self)).path(forResource: "Categories", ofType: "json") else {
            fatalError("wrong category bundle")
        }
        guard let categoryUrl = URL(string: "file://"+categoryBundle) else{
            fatalError("wrong category url")
        }
        guard let categoriesExpectedData = try? Data(contentsOf: categoryUrl) else {
            fatalError("No data for url \(categoryUrl)")
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
