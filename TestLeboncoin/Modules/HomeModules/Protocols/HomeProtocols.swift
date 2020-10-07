//
//  HomeProtocols.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation
import UIKit

protocol PresenterToViewProtocol: class{
    func showItems(items: [Item], categories: [Category])
    func showCategories(categories: [Category])
    func showError(error: String)
}

protocol InteractorToPresenterProtocol: class {
    func itemsFetchedWithSuccess(items: [Item], categories: [Category])
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
}

protocol PresenterToRouterProtocol {
    static func createModule() -> UIViewController
}
