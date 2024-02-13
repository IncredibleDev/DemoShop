//
//  CartView.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import SwiftUI
//import SDWebImageSwiftUI

struct CartView: View {
    @EnvironmentObject var cart: Cart
    @State private var showingAlert = false
    
    private var cartCount: String {
        return "\(cart.items.map({ $0.count }).reduce(0, +))"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if cart.items.count > 0 {
                    List(cart.items) { cartItem in
                        NavigationLink(destination: ProductDetailView(productDetail: cartItem.product)) {
                            HStack(alignment: .center, content: {
//                                WebImage(url: URL(string: cartItem.product.thumbnail))
//                                    .resizable()
//                                    .placeholder(content: {
//                                        ImagePlaceholderView()
//                                    })
//                                    .frame(width: 64, height: 64)
//                                    .border(Color.gray, width: 0.5)
                                AsyncImage(url: URL(string: cartItem.product.thumbnail)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ImagePlaceholderView()
                                }
                                .frame(width: 64, height: 64)
                                .border(Color.gray, width: 0.5)
                                VStack(alignment: .leading) {
                                    Text(cartItem.product.title)
                                        .font(.headline)
                                    Text(cartItem.product.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("Count: \(cartItem.count)")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                    Text("Total Price: \(cartItem.totalPrice, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                            })
                        }
                    }
                    .navigationBarTitle(Text(TabConstants.cart + " (\(cartCount))"), displayMode: .inline)
                    VStack {
                        HStack {
                            Text("Total Items: \(cartCount)")
                                .font(.headline)
                            Spacer()
                            Text("Total Price: \(cart.items.map({ $0.totalPrice }).reduce(0, +), specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                        .padding()
                        Button("Buy Now") {
                            showingAlert = true
                        }
                        .alert("Thanks for shopping in DemoShope.", isPresented: $showingAlert) {
                            Button("Continue", role: .cancel) {
                                cart.clearCart()
                            }
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                    }
                    
                } else {
                    Text("Cart is empty")
                        .navigationBarTitle(Text(TabConstants.cart), displayMode: .inline)
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()
        
        cart.addProduct(Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]))
        cart.addProduct(Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"]))
        
        return CartView()
            .environmentObject(cart)
    }
}
