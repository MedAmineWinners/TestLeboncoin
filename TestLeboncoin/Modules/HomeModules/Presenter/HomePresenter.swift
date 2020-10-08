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
        interactor?.fetchCategories()
    }
    
    func updateView(for category: Category) {
        interactor?.fetchItems()
    }
}

extension HomePresenter: InteractorToPresenterProtocol {
    func itemsFetchedWithSuccess(items: [Item]) {
        view?.showItems(items: items)
    }
    
    func categoriesFetchedWithSuccess(categories: [ItemCategory]) {
        view?.setCategories(categories: categories)
        interactor?.fetchItems()
    }
    
    func categoriesFetchedWithFailure(error: String) {
        view?.showError(error: error)
    }
        
    func itemsFetchedWithFailure(error: String) {
        view?.showError(error: error)
    }
}
