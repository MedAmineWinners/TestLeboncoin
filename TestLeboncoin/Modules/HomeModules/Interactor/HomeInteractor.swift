//
//  HomeInteractor.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation

class HomeInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    var requestHandler = RequestHandler()
    func fetchItems() {
        requestHandler.loadData(from: .items) { result in
            switch result {
            case .success(let result):
                let items: [Item] = result.decode()
                self.presenter?.itemsFetchedWithSuccess(items: items)
            case .failure(let error):
                self.presenter?.itemsFetchedWithFailure(error: error.localizedDescription)
            }
        }
    }
    
    func fetchCategories() {
        requestHandler.loadData(from: .categories) { result in
            switch result {
            case .success(let result):
                let categories: [ItemCategory] = result.decode()
                self.presenter?.categoriesFetchedWithSuccess(categories: categories)
            case .failure(let error):
                self.presenter?.categoriesFetchedWithFailure(error: error.localizedDescription)
            }
        }
    }
}
