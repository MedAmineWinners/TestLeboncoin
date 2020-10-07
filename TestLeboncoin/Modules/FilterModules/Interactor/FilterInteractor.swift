//
//  FilterInteractor.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
class FilterInteractor: FilterPresenterToInteractorProtocol {
    var presenter: FilterInteractorToPresenterProtocol?
    
    func fetchCategories() {
        let requestHandler = RequestHandler()
        requestHandler.fetch(url: .categories) { result in
            switch result {
            case .success(let result):
                if let categories = try? JSONDecoder().decode([Category].self, from: result){
                    self.presenter?.categoriesFetchedWithSuccess(categories: categories)
                }
                
            case .failure(let error):
                self.presenter?.categoriesFetchedWithFailure(error: error.localizedDescription)
            }
        }
    }
}
