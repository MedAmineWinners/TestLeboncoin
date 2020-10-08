//
//  Extensions.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
import UIKit

extension UIView {
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
    func cornerRadius(radius: Float) {
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
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
        let date = dateFormatter.date(from: self)!
        return date
    }
    
    func stringToFormattedDate() -> String {
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
