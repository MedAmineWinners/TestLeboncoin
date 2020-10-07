//
//  HomeInteractor.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation

class HomeInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    func fetchItems() {
        fetchItems { result in
            switch result {
            case .success(let result):
                if let items = try? JSONDecoder().decode([Item].self, from: result) {
                    self.fetchCategories { result in
                        switch result {
                        case .success(let result):
                            if let categories = try? JSONDecoder().decode([Category].self, from: result){
                                self.presenter?.itemsFetchedWithSuccess(items: items, categories: categories)
                            }
                        case .failure(let error):
                            self.presenter?.itemsFetchedWithFailure(error: error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                self.presenter?.itemsFetchedWithFailure(error: error.localizedDescription)
            }
        }
    }
    
    func fetchCategories() {
        fetchCategories { result in
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
    
    func fetchItems(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
        URLSession.shared.dataTask(with: url!){ data, response, error in
            if let data = data {
                completion(.success(data))
                return
            }
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.failure(NetworkingError.internalError))
        }.resume()
    }
    
    func fetchCategories(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")
        URLSession.shared.dataTask(with: url!){ data, response, error in
            if let data = data {
                completion(.success(data))
                return
            }
            if error != nil {
                completion(.failure(error!))
                return
            }
            completion(.failure(NetworkingError.internalError))
        }.resume()
    }
}


enum NetworkingError: Error {
    case internalError
    
    var localizedDescription: String {
        switch self {
        case .internalError:
            return "An error occured, please try later"
        }
    }
}
