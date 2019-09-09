//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Vici Shaweddy on 9/7/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

class SearchResultController {
    private let baseURL = URL(string: "https://itunes.apple.com/search?")
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func performSearch(with searchTerm: String, for resultType: ResultType, _ completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else {
           completion(nil)
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let filterTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        let filterCountryQueryItem = URLQueryItem(name: "country", value: "us")
        let filterLimitQueryItem = URLQueryItem(name: "limit", value: "5")
        urlComponents?.queryItems = [searchTermQueryItem, filterTermQueryItem, filterCountryQueryItem, filterLimitQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion(nil)
            return
        }

        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                print("No data returned from data task")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let itemSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itemSearch.results
                print(self.searchResults, data.description)
                completion(nil)
            } catch {
                print("Unable to decode data into SearchResults object: \(error)")
            }
            completion(error)
        }.resume()
    }
}
