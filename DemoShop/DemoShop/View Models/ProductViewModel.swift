//
//  ProductViewModel.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import Foundation
import Combine

// ViewModel for the Product
class ProductViewModel: ObservableObject {
    private let client: ProductClient
    private let category: String?
    @Published private(set) var products: [Product] = []
    @Published private(set) var productDetail: Product?
    @Published private(set) var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init(client: ProductClient, category: String?) {
        self.client = client
        self.category = category
    }

    func getCategoryName() -> String? {
        if let category = self.category {
            return category
        }
        return nil
    }
    
    func fetchProducts() {
        if let category = self.category {
            self.fetchProductsByCategory(category: category)
        }
        else {
            client.getProducts()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        break
                    }
                } receiveValue: { response in
                    self.products = response.products
                }
                .store(in: &cancellables)
        }
    }

    func fetchProductDetails(productID: String) {
        client.getProductDetails(productID: productID)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { detail in
                self.productDetail = detail
            }
            .store(in: &cancellables)
    }
    
    func fetchProductsByCategory(category: String) {
        client.getProductsByCategory(category: category)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.products = response.products
            }
            .store(in: &cancellables)
    }
}
