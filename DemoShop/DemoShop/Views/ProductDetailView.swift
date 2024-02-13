//
//  ProductDetailView.swift
//  DemoShop
//
//  Created by Devashish Urwar on 12/02/24.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cart: Cart
    let productDetail: Product
    
    private var buttonTitle: String {
            if cart.itemExistInCart(productDetail) {
                return "+"
            } else {
                return "Add to cart"
            }
        }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                TabView {
                    ForEach(productDetail.images, id: \.self) { imageUrl in
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ImagePlaceholderView()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 200)
                
                Text(productDetail.title)
                    .font(.title)
                    .bold()
                Text("Price: \(productDetail.price)")
                    .font(.headline)
                Text("Discount: \(productDetail.discountPercentage, specifier: "%.2f")%")
                    .font(.headline)
                Text("Rating: \(productDetail.rating, specifier: "%.2f")")
                    .font(.headline)
                Text("Stock: \(productDetail.stock)")
                    .font(.headline)
                Text("Brand: \(productDetail.brand)")
                    .font(.headline)
                Text("Category: \(productDetail.category.capitalized)")
                    .font(.headline)
                Text("Description:")
                    .font(.headline)
                Text(productDetail.description)
                    .font(.body)
                Spacer()
                HStack(alignment: .center, spacing: 10) {
                    if cart.getItemCount(productDetail) > 0 {
                        Spacer()
                        Button(action: {
                            cart.removeProduct(productDetail)
                        }) {
                            Text("-")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        Spacer()
                        Text("\(cart.getItemCount(productDetail))")
                            .font(.body)
                    }
                    Spacer()
                    Button(action: {
                        cart.addProduct(productDetail)
                    }) {
                        Text(buttonTitle)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Spacer()
                }
            }
            .padding()
            .navigationBarTitle(Text(productDetail.title.capitalized), displayMode: .inline)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()
        let previewProduct = Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 96, brand: "Apple", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg", images: ["https://cdn.dummyjson.com/product-images/1/1.jpg","https://cdn.dummyjson.com/product-images/1/2.jpg","https://cdn.dummyjson.com/product-images/1/3.jpg","https://cdn.dummyjson.com/product-images/1/4.jpg","https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"])
        
        return ProductDetailView(productDetail: previewProduct)
            .environmentObject(cart)
    }
}
