//
//  HomeInteractor.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation

class HomeInteractor: PresenterToInteractorProtocol {

    var presenter: InteractorToPresenterProtocol?
    
    func fetchItems() {
        let requestHandler = RequestHandler()
        requestHandler.fetch(url: .items) { result in
            switch result {
            case .success(let result):
                if let items = try? JSONDecoder().decode([Item].self, from: result) {
                    self.presenter?.itemsFetchedWithSuccess(items: items)
                }
            case .failure(let error):
                self.presenter?.itemsFetchedWithFailure(error: error.localizedDescription)
            }
        }
    }
    
    func fetchCategories() {
        let requestHandler = RequestHandler()
        requestHandler.fetch(url: .categories) { result in
            switch result {
            case .success(let result):
                if let categories = try? JSONDecoder().decode([Category].self, from: result) {
                    self.presenter?.categoriesFetchedWithSuccess(categories: categories)
                }
            case .failure(let error):
                self.presenter?.itemsFetchedWithFailure(error: error.localizedDescription)
            }
        }
    }
}

enum NetworkingError: Error {
    case internalError
    
    var localizedDescription: String {
        switch self {
        case .internalError:
            return "An error occured, please try later"
        }
    }
}
