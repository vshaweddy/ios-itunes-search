//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Vici Shaweddy on 9/6/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

// allow us to decode the JSON data into this object, then access the actual search results through its results property
struct SearchResults: Decodable {
    let results: [SearchResult]
}
