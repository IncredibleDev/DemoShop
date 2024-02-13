//
//  ProductClient.swift
//  DemoShop
//
//  Created by Devashish Urwar on 13/02/24.
//

import Foundation
import Combine

// Use the ProductAPIFetcher in a client class
class ProductClient {
    let fetcher: APIFetcher

    init(fetcher: APIFetcher) {
        self.fetcher = fetcher
    }

    func getProducts() -> AnyPublisher<ProductResponse, APIError> {
        let endpoint = "products"
        return fetcher.fetchData(endpoint: endpoint)
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }

    func getProductDetails(productID: String) -> AnyPublisher<Product, APIError> {
        let endpoint = "products/\(productID)"
        return fetcher.fetchData(endpoint: endpoint)
            .decode(type: Product.self, decoder: JSONDecoder())
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }
    
    func getCategories() -> AnyPublisher<[String], APIError> {
        let endpoint = "products/categories"
        return fetcher.fetchData(endpoint: endpoint)
            .decode(type: [String].self, decoder: JSONDecoder())
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }
    
    func getProductsByCategory(category: String) -> AnyPublisher<ProductResponse, APIError> {
        let endpoint = "products/category/\(category)"
        return fetcher.fetchData(endpoint: endpoint)
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .mapError { _ in APIError.requestFailed }
            .eraseToAnyPublisher()
    }
}
