//
//  ProductView.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import SwiftUI
//import SDWebImageSwiftUI

struct ProductView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    private var title: String {
        if let categoryName = viewModel.getCategoryName() {
            return categoryName.capitalized
        } else {
            return TabConstants.product
        }
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView(productDetail: product)) {
                    HStack(alignment: .center, content: {
//                        WebImage(url: URL(string: product.thumbnail))
//                            .resizable()
//                            .placeholder(content: {
//                                ImagePlaceholderView()
//                            })
//                            .frame(width: 64, height: 64)
//                            .border(Color.gray, width: 0.5)
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ImagePlaceholderView()
                        }
                        .frame(width: 64, height: 64)
                        .border(Color.gray, width: 0.5)
                        
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text(product.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    })
                }
            }
            .navigationTitle(title)
            .navigationBarTitle(Text(title), displayMode: .inline)
            .overlay(viewModel.isLoading ? ProgressView() : nil)
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let fetcher = ProductAPIFetcher()
        let client = ProductClient(fetcher: fetcher)
        let viewModel = ProductViewModel(client: client, category: nil)
        
        return ProductView(viewModel: viewModel)
    }
}
