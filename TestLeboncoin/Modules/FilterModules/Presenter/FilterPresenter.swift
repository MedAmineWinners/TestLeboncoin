//
//  FilterPresenter.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
class FilterPresenter: FilterViewToPresenterProtocol {
    var view: FilterPresenterToViewProtocol?
    
    var interactor: FilterPresenterToInteractorProtocol?
    
    var router: FilterPresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchCategories()
    }
}

extension FilterPresenter: FilterInteractorToPresenterProtocol {
    func categoriesFetchedWithSuccess(categories: [ItemCategory]) {
        
    }
    
    func categoriesFetchedWithFailure(error: String) {
        
    }
}
