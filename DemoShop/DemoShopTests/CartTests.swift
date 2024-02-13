//
//  CartTests.swift
//  DemoShopTests
//
//  Created by Devashish Urwar on 13/02/24.
//

import XCTest
@testable import DemoShop

final class CartTests: XCTestCase {
    var cart: Cart!

        override func setUp() {
            super.setUp()
            cart = Cart()
        }

        override func tearDown() {
            cart = nil
            super.tearDown()
        }

        func testAddProduct() {
            let product = Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])

            cart.addProduct(product)

            XCTAssertEqual(cart.items.count, 1)
            XCTAssertEqual(cart.items.first?.product, product)
            XCTAssertEqual(cart.items.first?.count, 1)
        }
    
    func testAddSameProductAgain() {
        let testProduct = Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])

        cart.addProduct(testProduct)
        cart.addProduct(testProduct)
        cart.addProduct(testProduct)
        
        XCTAssertEqual(cart.items.count, 1, "Same product | No nead of new cart item | Product count should increase only, Cart is not showing desired cart item count 1")
        XCTAssertEqual(cart.items.first?.product, testProduct, "Same product | No nead of new cart item | Product count should increase only, First cart item's prodcut is not similar to test product")
        XCTAssertEqual(cart.items.first?.count, 3, "Same product | No nead of new cart item | Product count should increase only, First cart item's product count is not similar to desired count 3")
    }
    
    func testCartWholeFunctionality() {
        let testProduct1 = Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])
        let testProduct2 = Product(id: 2, title: "iPhone X", description: "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...", price: 899, discountPercentage: 17.94, rating: 4.44, stock: 34, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/2/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/2/1.jpg","https://cdn.dummyjson.com/product-images/2/2.jpg","https://cdn.dummyjson.com/product-images/2/3.jpg","https://cdn.dummyjson.com/product-images/2/thumbnail.jpg"])
        
        cart.addProduct(testProduct1)
        cart.addProduct(testProduct1)
        
        XCTAssertEqual(cart.items.count, 1, "Same product | No nead of new cart item | Product count should increase only, Cart is not showing desired cart item count 1")
        XCTAssertEqual(cart.items.first?.product, testProduct1, "Same product | No nead of new cart item | Product count should increase only, First cart item's prodcut is not similar to test product")
        XCTAssertEqual(cart.items.first?.count, 2, "Same product | No nead of new cart item | Product count should increase only, First cart item's product count is not similar to desired count 2")
        
        cart.addProduct(testProduct2)
        
        XCTAssertEqual(cart.items.count, 2, "Different product | Need to add new cart item | Cart item count should increase, Cart is not showing desired cart item count 2")
        XCTAssertEqual(cart.items.first?.product, testProduct1, "Different product | Need to add new cart item | Cart item count should increase, First cart item's product is not similar to test product 1")
        XCTAssertEqual(cart.items[1].product, testProduct2, "Different product | Need to add new cart item | Cart item count should increase, Second cart item's product is not similar to test product 2")
        XCTAssertEqual(cart.items.first?.count, 2, "Different product | Need to add new cart item | Cart item count should increase, First cart item's product count is not equal to desired count 2")
        XCTAssertEqual(cart.items[1].count, 1, "Different product | Need to add new cart item | Cart item count should increase, Second cart item's product count is not equal to desired count 1")
        
        // Testing itemExistInCart()
        let isProcuctAlreadyExistInCart = cart.itemExistInCart(testProduct2)
        XCTAssertEqual(isProcuctAlreadyExistInCart, true, "Test product 2 already added in cart, but cart is not showing true for its existance.")
        
        // Testing getItemCount()
        let product2CountInCart = cart.getItemCount(testProduct2)
        XCTAssertEqual(product2CountInCart, 1, "Test product 2 only added once, so count should be 1, but cart is not showing desired count 1.")
        
        // Testing removeProduct() | for existing multiples
        cart.removeProduct(testProduct1)
        XCTAssertEqual(cart.items.count, 2, "Only one unit of product 1 removed from cart, cart still has 2 different items, Cart is not showing desired cart item count 2")
        XCTAssertEqual(cart.items.first?.product, testProduct1, "Only one unit of product 1 removed from cart, cart still has 2 different items, First cart item's product is not similar to test product 1")
        XCTAssertEqual(cart.items[1].product, testProduct2, "Only one unit of product 1 removed from cart, cart still has 2 different items, Second cart item's product is not similar to test product 2")
        XCTAssertEqual(cart.items.first?.count, 1, "Only one unit of product 1 removed from cart, 1 unit still in cart, First cart item's product count is not equal to desired count 1")
        XCTAssertEqual(cart.items[1].count, 1, "No change in second cart item | Second cart item's product count is not equal to desired count 1")
        
        // Testing removeProduct() | for single different product
        cart.removeProduct(testProduct2)
        XCTAssertEqual(cart.items.count, 1, "Product 2 removed from cart, cart only has product 1 item, Cart is not showing desired cart item count 1")
        XCTAssertEqual(cart.items.first?.product, testProduct1, "Product 2 removed from cart, cart only has product 1 item, First cart item's product is not similar to test product 1")
        XCTAssertEqual(cart.items.first?.count, 1, "Product 2 removed from cart, cart only has product 1 item x 1 unit, First cart item's product count is not equal to desired count 1")
        
        // Testing clearCart()
        cart.clearCart()
        XCTAssertEqual(cart.items.count, 0, "Cart is not clreared, still has something.")
        
        let product1CountInCart = cart.getItemCount(testProduct1)
        XCTAssertEqual(product1CountInCart, 0, "Cart already been clreared, but cart is not showing desired count 0.")
    }

        func testClearCart() {
            let product = Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])

            cart.addProduct(product)
            cart.clearCart()

            XCTAssertEqual(cart.items.count, 0, "Cart is not clreared, still has something.")
        }
}
