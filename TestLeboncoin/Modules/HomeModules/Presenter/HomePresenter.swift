//
//  HomePresenter.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation
class HomePresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchItems()
    }
}

extension HomePresenter: InteractorToPresenterProtocol {
    
    func categoriesFetchedWithSuccess(categories: [Category]) {
        
    }
    
    func categoriesFetchedWithFailure(error: String) {
        
    }
    
    func itemsFetchedWithSuccess(items: [Item], categories: [Category]) {
        view?.showItems(items: items, categories: categories)
    }
    
    func itemsFetchedWithFailure(error: String) {
        view?.showError(error: error)
    }
}
