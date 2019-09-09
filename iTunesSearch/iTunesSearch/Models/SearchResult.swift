//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Vici Shaweddy on 9/6/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String?
    let creator: String?
    let image: String?
    let country: String?
    let kind: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
        case image = "artworkUrl100"
        case country = "country"
        case kind = "kind"
    }
}

// allow us to decode the JSON data into this object, then access the actual search results through its results property
struct SearchResults: Codable {
    let results: [SearchResult]
}
