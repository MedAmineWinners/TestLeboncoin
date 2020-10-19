//
//  RequestHandler.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class RequestHandler {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadData(from url: SearchPaths, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = getURL(matching: url) {
            session.loadData(from: url) { (data, error) in
                let result = data.map(Result.success) ?? .failure(error ?? NetworkingError.internalError)
                completion(result)
            }
        }else {
            completion(.failure(NetworkingError.domainError))
        }
    }
    
    private func getURL(matching searchPath: SearchPaths) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = searchPath.rawValue
        return components.url
    }
}

enum SearchPaths: String {
    case items = "/leboncoin/paperclip/master/listing.json"
    case categories = "/leboncoin/paperclip/master/categories.json"
}

enum NetworkingError: Error {
    case internalError
    case domainError
    case decodingError
}
