//
//  APIManager.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import Foundation
import Combine

// Define the protocol for fetching data from an API
protocol APIFetcher {
    func fetchData(endpoint: String) -> AnyPublisher<Data, APIError>
}

enum APIError: Error {
    case invalidUrl
    case requestFailed
    case dataNotFound
}
