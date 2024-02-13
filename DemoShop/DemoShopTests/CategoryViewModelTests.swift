//
//  CategoryViewModelTests.swift
//  DemoShopTests
//
//  Created by Devashish Urwar on 13/02/24.
//

import XCTest
import Combine
@testable import DemoShop

final class CategoryViewModelTests: XCTestCase {

    var categoryViewModel: CategoryViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let fetcher = ProductAPIFetcher()
        let client = ProductClient(fetcher: fetcher)
        categoryViewModel = CategoryViewModel(client: client)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        categoryViewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCategories() {
        // Define the expectation
                let expectation = XCTestExpectation(description: "Get categories and update in view model.")
                categoryViewModel.fetchCategories()

                categoryViewModel.$categories
                    .dropFirst() // Skip the initial value
                    .sink { categories in
                        XCTAssertGreaterThan(categories.count, 0, "Categories not fetched and updated in view model.")
                        expectation.fulfill()
                    }
                    .store(in: &cancellables)

                // Wait for the expectation to be fulfilled
                wait(for: [expectation], timeout: 1.0)
    }
}
