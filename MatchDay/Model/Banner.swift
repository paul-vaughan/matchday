//
//  Banner.swift
//  MatchDay
//
//  Created by Paul Vaughan on 29/05/2023.
//

import Foundation

struct Banner: Decodable {
    var id: Int
    var width: Int
    var height: Int
    var sortOrder: Int
    var websiteUrl: String
    var imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case sortOrder = "sort_order"
        case websiteUrl = "website_url"
        case imageUrl = "image_url"
    }
}
