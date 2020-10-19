//
//  HomeViewController.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterItemsProtocol {
    
    var homeView = HomeView()
    var presenter: ViewToPresenterProtocol?
    var categories = [ItemCategory]()
    var articleListViewModel = ArticleListViewModel()
    var filteredArticlesViewModel = [ArticleViewModel]()
    
    override func loadView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.closeButton.addTarget(self, action: #selector(clearFilterList), for: .touchUpInside)
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        let rightButton = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(showFiltersList))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "Articles disponibles"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articleListViewModel.isFiltered {
            return filteredArticlesViewModel.count
        }
        return articleListViewModel.articlesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        if articleListViewModel.isFiltered {
            cell.articleViewModel = filteredArticlesViewModel[indexPath.row]
        } else {
            cell.articleViewModel = articleListViewModel.articlesViewModel[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleViewModel = articleListViewModel.isFiltered ? filteredArticlesViewModel[indexPath.row] :  articleListViewModel.articlesViewModel[indexPath.row]
        let detailsViewController = DetailsRouter.createModule(articleViewModel: articleViewModel)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func clearFilterList() {
        self.articleListViewModel.isFiltered = false
        homeView.filterStackView.isHidden = true
        homeView.tableView.reloadDataAnimated()
    }
    
    @objc func showFiltersList() {
        let filterController = FilterRouter.createModule(categories: categories)
        (filterController as! FilterViewController).delegate = self
        let navigationController = UINavigationController(rootViewController: filterController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func showItems(for category: ItemCategory) {
        filteredArticlesViewModel = self.articleListViewModel.articlesViewModel.filter( {$0.categoryName == category.name})
        self.articleListViewModel.isFiltered = true
        homeView.tableView.reloadDataAnimated()
        homeView.filterStackView.isHidden = false
        homeView.categoryLabel.text = category.name
    }
}

extension HomeViewController: PresenterToViewProtocol {
    func setCategories(categories: [ItemCategory]) {
        self.categories = categories
    }
    
    func showItems(items: [Item]) {
        let articlesViewModel = items.map { item in
            ArticleViewModel(item: item, category: self.categories.first(where: { category in
                category.id == item.category_id
            })
            )}
        self.articleListViewModel.articlesViewModel = self.articleListViewModel.sortItems(articlesViewModel: articlesViewModel)
        DispatchQueue.main.async {
            self.homeView.tableView.reloadDataAnimated()
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
