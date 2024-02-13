//
//  CategoryViewModel.swift
//  DemoShop
//
//  Created by Devashish Urwar on 12/02/24.
//

import Foundation
import Combine

// ViewModel for the Category
class CategoryViewModel: ObservableObject {
    private let client: ProductClient
//    @Published private(set) var products: [Product] = []
    @Published private(set) var categories: [String] = []
    @Published private(set) var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init(client: ProductClient) {
        self.client = client
    }
    
    func fetchCategories() {
            client.getCategories()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                    case .finished:
                        break
                    }
                } receiveValue: { categories in
                    self.categories = categories
                }
                .store(in: &cancellables)
        }
}
