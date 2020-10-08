//
//  FilterInteractor.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
class FilterInteractor: FilterPresenterToInteractorProtocol {
    var presenter: FilterInteractorToPresenterProtocol?
    var requestHandler = RequestHandler()
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
