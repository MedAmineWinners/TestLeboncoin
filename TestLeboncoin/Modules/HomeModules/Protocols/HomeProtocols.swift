//
//  HomeProtocols.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation
import UIKit

protocol PresenterToViewProtocol: class{
    func showItems(items: [Item])
    func setCategories(categories: [Category])
    func showError(error: String)
}

protocol InteractorToPresenterProtocol: class {
    func itemsFetchedWithSuccess(items: [Item])
    func itemsFetchedWithFailure(error: String)
    func categoriesFetchedWithSuccess(categories: [Category])
    func categoriesFetchedWithFailure(error: String)
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? { get set }
    func fetchItems()
    func fetchCategories()
}

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? { get set }
    var interactor: PresenterToInteractorProtocol? { get set }
    var router: PresenterToRouterProtocol? { get set }
    func updateView()
    func updateView(for category: Category)
}

protocol PresenterToRouterProtocol {
    static func createModule() -> UIViewController
}
