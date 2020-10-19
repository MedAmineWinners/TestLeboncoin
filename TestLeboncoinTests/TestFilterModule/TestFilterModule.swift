//
//  TestFilterModule.swift
//  TestLeboncoinTests
//
//  Created by Stimlog on 08/10/2020.
//

import XCTest
@testable import TestLeboncoin

class TestFilterInteractor: XCTestCase {
    var requestHandler: RequestHandler?
    let session = NetworkSessionMock()
    let filterInteractor = FilterInteractor()
    let presenter = FilterPresenterMock()
    override func setUp() {
        super.setUp()
        requestHandler = RequestHandler(session: session)
        filterInteractor.presenter = presenter
        filterInteractor.requestHandler = requestHandler!
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchCategories() {
        
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
        filterInteractor.fetchCategories()
        XCTAssertTrue(presenter.categorieFetchedWithSuccessCalled)
        
        //Test fetchCategories with failure
        session.data = nil
        session.error = NetworkingError.internalError
        filterInteractor.fetchCategories()
        XCTAssertTrue(presenter.categorieFetchedWithFailureCalled)
    }
}

class FilterPresenterMock: FilterInteractorToPresenterProtocol {
    var categorieFetchedWithSuccessCalled = false
    var categorieFetchedWithFailureCalled = false
   
    func categoriesFetchedWithSuccess(categories: [ItemCategory]) {
        categorieFetchedWithSuccessCalled = true
    }
        
    func categoriesFetchedWithFailure(error: String) {
        categorieFetchedWithFailureCalled = true
    }
}
