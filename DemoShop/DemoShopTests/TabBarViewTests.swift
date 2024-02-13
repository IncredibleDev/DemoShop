//
//  TabBarViewTests.swift
//  DemoShopTests
//
//  Created by Devashish Urwar on 13/02/24.
//

import XCTest
@testable import DemoShop

final class TabBarViewTests: XCTestCase {
    func testNumberOfCases() {
        let numberOfCases = AppScreen.allCases.count
        XCTAssertEqual(numberOfCases, 3, "AppScreen should have 3 cases for bottom Tab bar")
    }
}
