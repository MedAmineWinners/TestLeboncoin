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
        var sortedItems = items.sorted(by:  { ($0.creation_date?.stringToDate())! > ($1.creation_date?.stringToDate())! })
        sortedItems.sort { $0.is_urgent! && !$1.is_urgent! }
        view?.showItems(items: sortedItems)
    }
    
    func categoriesFetchedWithSuccess(categories: [Category]) {
        view?.setCategories(categories: categories)
        interactor?.fetchItems()
    }
    
    func categoriesFetchedWithFailure(error: String) {
        
    }
        
    func itemsFetchedWithFailure(error: String) {
        view?.showError(error: error)
    }
}
