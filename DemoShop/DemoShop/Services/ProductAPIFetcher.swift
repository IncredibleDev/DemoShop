//
//  ProductAPIFetcher.swift
//  DemoShop
//
//  Created by Devashish Urwar on 13/02/24.
//

import Foundation
import Combine

// Implement the protocol for fetching product data from a specific API
class ProductAPIFetcher: APIFetcher {
    let baseURL = "https://dummyjson.com/"

    func fetchData(endpoint: String) -> AnyPublisher<Data, APIError> {
        let urlPath = baseURL + endpoint
        guard let url = URL(string: urlPath) else {
            return Fail(error: APIError.invalidUrl).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.requestFailed
                }
                return data
            }
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }
}
