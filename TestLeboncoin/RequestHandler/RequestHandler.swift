//
//  RequestHandler.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
class RequestHandler {
     func fetch(url: SearchPaths, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = getURL(matching: url)
        URLSession.shared.dataTask(with: url){ data, response, error in
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
    
     private func getURL(matching searchPath: SearchPaths) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = searchPath.rawValue
        return components.url!
    }
}

enum SearchPaths: String {
    case items = "/leboncoin/paperclip/master/listing.json"
    case categories = "/leboncoin/paperclip/master/categories.json"
}
