//
//  ProductClientTests.swift
//  DemoShopTests
//
//  Created by Devashish Urwar on 13/02/24.
//

import XCTest
import Combine
@testable import DemoShop

final class ProductClientTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var fetcher: APIFetcher!
    var client: ProductClient!
    
        override func setUp() {
            super.setUp()
            cancellables = Set<AnyCancellable>()
            self.fetcher = ProductAPIFetcher()
            self.client = ProductClient(fetcher: fetcher)
        }
        
        override func tearDown() {
            cancellables = nil
            fetcher = nil
            client = nil
            super.tearDown()
        }
        
        func testGetProducts() {
            // Define the expectation
            let expectation = XCTestExpectation(description: "getProducts returns the correct data")
            
            // Execute the test
            client.getProducts()
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        XCTFail("Error: \(error)")
                    case .finished:
                        expectation.fulfill()
                    }
                } receiveValue: { response in
                    XCTAssertGreaterThan(response.products.count, 0, "No product present in response")
                    XCTAssertNotNil(response, "Response found nil")
                    XCTAssertEqual(response.products[0].id, 1, "First product id should be 1")
                }
                .store(in: &cancellables)
            
            // Wait for the expectation to be fulfilled
            wait(for: [expectation], timeout: 1.0)
        }
    
    func testGetProductDetails() {
        // Prepare test data
        let testProductID = "1"
    
        // Define the expectation
        let expectation = XCTestExpectation(description: "getProductDetails returns the correct data.")
        
        // Execute the test
        client.getProductDetails(productID: testProductID)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { response in
                XCTAssertNotNil(response.id, "Response not contains essential detail.")
                XCTAssertNotNil(response, "Response found nil")
                XCTAssertEqual(response.id, 1, "Product id is not as per test data")
            }
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetCategories() {
        // Set up the test client
        let fetcher = ProductAPIFetcher()
        let client = ProductClient(fetcher: fetcher)
        
        // Define the expectation
        let expectation = XCTestExpectation(description: "getGetCategories returns the correct data")
        
        // Execute the test
        client.getCategories()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { response in
                XCTAssertGreaterThan(response.count, 0, "No category present in response")
                XCTAssertNotNil(response, "Response found nil")
            }
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetProductsByCategory() {
        // Prepare test data
        let testCategory = "smartphones"
        // Define the expectation
        let expectation = XCTestExpectation(description: "getProductsByCategory returns the correct data")
        
        // Execute the test
        client.getProductsByCategory(category: testCategory)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { response in
                XCTAssertGreaterThan(response.products.count, 0, "No product present in response")
                XCTAssertNotNil(response, "Response found nil")
                XCTAssertEqual(response.products[0].category, testCategory, "Product category is not as per test category")
            }
            .store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
}
