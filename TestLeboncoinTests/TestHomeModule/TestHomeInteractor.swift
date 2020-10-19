//
//  TestHomeInteractor.swift
//  TestLeboncoinTests
//
//  Created by Stimlog on 08/10/2020.
//

import XCTest
@testable import TestLeboncoin

class TestHomeInteractor: XCTestCase {
    var requestHandler: RequestHandler?
    let session = NetworkSessionMock()
    let homeInteractor = HomeInteractor()
    let presenter = HomePresenterMock()
    override func setUp() {
        super.setUp()
        requestHandler = RequestHandler(session: session)
        homeInteractor.presenter = presenter
        homeInteractor.requestHandler = requestHandler!
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchItems() {

        guard let bundle = Bundle(for: type(of: self)).path(forResource: "Items", ofType: "json") else {
            fatalError("wrong bundle")
        }
        guard let url = URL(string: "file://"+bundle) else{
            fatalError("wrong url")
        }
        guard let itemExpectedData = try? Data(contentsOf: url) else {
            fatalError("No data for url \(url)")
        }
        //Test fetchItems with success
        session.data = itemExpectedData
        session.error = nil
        homeInteractor.fetchItems()
        XCTAssertTrue(presenter.itemFetchedWithSuccessCalled)
        
        //Test fetchItems with failure
        session.data = nil
        session.error = NetworkingError.internalError
        homeInteractor.fetchItems()
        XCTAssertTrue(presenter.itemFetchedWithFailureCalled)
        

        guard let categoryBundle = Bundle(for: type(of: self)).path(forResource: "Categories", ofType: "json") else {
            fatalError("wrong category bundle")
        }
        guard let categoryUrl = URL(string: "file://"+categoryBundle) else{
            fatalError("wrong category url")
        }
        guard let categoriesExpectedData = try? Data(contentsOf: categoryUrl) else {
            fatalError("No data for url \(categoryUrl)")
        }
        //Test fetchCategories with success
        session.data = categoriesExpectedData
        session.error = nil
        homeInteractor.fetchCategories()
        XCTAssertTrue(presenter.categorieFetchedWithSuccessCalled)
        
        //Test fetchCategories with failure
        session.data = nil
        session.error = NetworkingError.internalError
        homeInteractor.fetchCategories()
        XCTAssertTrue(presenter.categorieFetchedWithFailureCalled)
    }
}

class HomePresenterMock: InteractorToPresenterProtocol {
    var categorieFetchedWithSuccessCalled = false
    var categorieFetchedWithFailureCalled = false
    var itemFetchedWithSuccessCalled = false
    var itemFetchedWithFailureCalled = false
    func categoriesFetchedWithSuccess(categories: [ItemCategory]) {
        categorieFetchedWithSuccessCalled = true
    }
    
    func itemsFetchedWithSuccess(items: [Item]) {
        itemFetchedWithSuccessCalled = true
    }
    
    func itemsFetchedWithFailure(error: String) {
        itemFetchedWithFailureCalled = true
    }
    
    func categoriesFetchedWithFailure(error: String) {
        categorieFetchedWithFailureCalled = true
    }
}
