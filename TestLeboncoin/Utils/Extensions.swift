//
//  Extensions.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
import UIKit

extension UIView {
    func cornerRadius(radius: Float) {
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
    }
}


class CustomUIImageView: UIImageView {
    let imageCache = NSCache<NSString, AnyObject>()
    var imageURL: URL?
    func loadImage(url: URL) {
        imageURL = url
        image = nil
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            image = cachedImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    if self?.imageURL == url {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                }
            }
        }
    }
}

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadWithAnimation(url: URL) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {self.load(url: url)}, completion: nil)
    }
}

extension String {
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
    
    func stringToFormattedDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "fr")
        return formatter.string(from: self.stringToDate())
    }
}

extension UITableView {
    func reloadDataAnimated() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
}

extension Data {
    func decode<T: Codable>() -> T {
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: self) else {
            fatalError("failed to decode data")
        }
        return loaded
    }
}
