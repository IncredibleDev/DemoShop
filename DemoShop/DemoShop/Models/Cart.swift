//
//  CartModel.swift
//  DemoShop
//
//  Created by Devashish Urwar on 13/02/24.
//

import Foundation

struct CartItem: Identifiable {
    let id: Int
    let product: Product
    var count: Int
    var totalPrice: Double
}

class Cart: ObservableObject {
    @Published private(set) var items: [CartItem] = []

    func addProduct(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].count += 1
            items[index].totalPrice = items[index].totalPrice + product.price
        } else {
            let newItem = CartItem(id: product.id, product: product, count: 1, totalPrice: product.price)
            items.append(newItem)
        }
    }

    func removeProduct(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].count -= 1
            items[index].totalPrice = items[index].totalPrice - product.price
            if items[index].count <= 0 {
                items.remove(at: index)
            }
        }
    }

    func itemExistInCart(_ product: Product) -> Bool {
        return items.contains(where: { $0.product.id == product.id })
    }

    func getItemCount(_ product: Product) -> Int {
        return items.first(where: { $0.product.id == product.id })?.count ?? 0
    }
    
    func clearCart() {
        items.removeAll()
    }
}
