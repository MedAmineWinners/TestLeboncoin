//
//  Item.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation
struct Item: Codable {
    let id: Int
    let category_id: Int?
    let title: String?
    let description: String?
    let price: Double?
    let images_url: Images_url?
    let creation_date: String
    let is_urgent: Bool
}

struct Images_url: Codable {
    let small: String?
    let thumb: String?
}
