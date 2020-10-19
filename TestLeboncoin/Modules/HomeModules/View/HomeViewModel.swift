//
//  HomeViewModel.swift
//  TestLeboncoin
//
//  Created by Mohamed Lamine Belfekih on 19/10/2020.
//

import Foundation

class ArticleListViewModel {
    var articlesViewModel: [ArticleViewModel]
    var isFiltered = false
    init() {
        self.articlesViewModel = [ArticleViewModel]()
    }
    
    func sortItems(articlesViewModel: [ArticleViewModel]) -> [ArticleViewModel] {
        let dateFormatter = DateFormatter()
        var sortedItems = articlesViewModel.sorted(by:  { ($0.creationDate.stringToDate(with: dateFormatter)) > ($1.creationDate.stringToDate(with: dateFormatter)) })
        sortedItems.sort { $0.isUrgent && !$1.isUrgent }
        return sortedItems
    }
    
    func articleViewModel(at index: Int) -> ArticleViewModel {
        return self.articlesViewModel[index]
    }
}

struct ArticleViewModel {
    let item: Item
    let category: ItemCategory?
    let dateFormatter = DateFormatter()
}

extension ArticleViewModel {
    var categoryName: String {
        return self.category?.name ?? ""
    }
    
    var title: String {
        return self.item.title ?? ""
    }
    
    var description: String {
        return self.item.description ?? ""
    }
    
    var price: String {
        return "\(self.item.price ?? 0.0)€"
    }
    
    var smallImage: URL? {
        if let url = URL(string: self.item.images_url?.small ?? "") {
            return url
        }
        return nil
    }
    
    var bigImage: URL? {
        if let url = URL(string: self.item.images_url?.thumb ?? "") {
            return url
        }
        return nil
    }
    
    var creationDate: String {
        return self.item.creation_date
    }
    
    var isUrgent: Bool {
        return self.item.is_urgent
    }
}
