//
//  ProductViewModelTests.swift
//  DemoShopTests
//
//  Created by Devashish Urwar on 13/02/24.
//

import XCTest
import Combine
@testable import DemoShop

final class ProductViewModelTests: XCTestCase {

    var productViewModel: ProductViewModel!
    var cancellables: Set<AnyCancellable>!
    var fetcher: APIFetcher!
    var client: ProductClient!
    
    override func setUp() {
        super.setUp()
        self.fetcher = ProductAPIFetcher()
        self.client = ProductClient(fetcher: fetcher)
        self.productViewModel = ProductViewModel(client: client, category: nil)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        productViewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchProducts() {
        // Define the expectation
        let expectation = XCTestExpectation(description: "Get products and update in view model.")
        productViewModel.fetchProducts()

        productViewModel.$products
                    .dropFirst() // Skip the initial value
                    .sink { products in
                        XCTAssertGreaterThan(products.count, 0, "Products not fetched and updated in view model.")
                        expectation.fulfill()
                    }
                    .store(in: &cancellables)

                // Wait for the expectation to be fulfilled
                wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchProductDetails() {
        // Define test data
        let testproductID = "1"
        // Define the expectation
        let expectation = XCTestExpectation(description: "Get products and update in view model.")
        productViewModel.fetchProductDetails(productID: testproductID)

        productViewModel.$productDetail
                    .dropFirst() // Skip the initial value
                    .sink { product in
                        XCTAssertEqual(product?.id, 1, "Product detail not fetched and updated in view model.")
                        XCTAssertNotNil(product?.id, "Id can't be nil in product detail.")
                        XCTAssertNotNil(product?.title, "Title can't be nil in product detail.")
                        expectation.fulfill()
                    }
                    .store(in: &cancellables)

                // Wait for the expectation to be fulfilled
                wait(for: [expectation], timeout: 1.0)
    }

    func testFetchProductsByCategory() {
        // Define test data
        let testCategory = "smartphones"

        self.productViewModel = ProductViewModel(client: client, category: testCategory)
        // Define the expectation
        let expectation = XCTestExpectation(description: "Get products and update in view model.")

        // Testing getCategoryName()
        let currentCategoryName = productViewModel.getCategoryName()
        XCTAssertEqual(currentCategoryName, testCategory, "Category name not updated in view model.")
        
        productViewModel.fetchProductsByCategory(category: testCategory)
        productViewModel.$products
                    .dropFirst() // Skip the initial value
                    .sink { products in
                        XCTAssertGreaterThan(products.count, 0, "Products not fetched and updated in view model.")
                        expectation.fulfill()
                    }
                    .store(in: &cancellables)

                // Wait for the expectation to be fulfilled
                wait(for: [expectation], timeout: 1.0)
    }
}
