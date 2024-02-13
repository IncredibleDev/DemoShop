//
//  CategoryView.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var categoryViewModel: CategoryViewModel
    
    let config = [
        GridItem(.flexible(minimum: 50, maximum: 300)),
        GridItem(.flexible(minimum: 50, maximum: 300)),
        GridItem(.flexible(minimum: 50, maximum: 300))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: config, spacing: 20) {
                    ForEach(categoryViewModel.categories, id: \.self) { item in
                        let fetcher = ProductAPIFetcher()
                        let client = ProductClient(fetcher: fetcher)
                        let viewModel = ProductViewModel(client: client, category: item)
                        NavigationLink(destination: ProductView(viewModel: viewModel)) {
                            Text(String(item.capitalized))
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .padding()
                        .onAppear {
                            viewModel.fetchProductsByCategory(category: item)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle(Text(TabConstants.category), displayMode: .inline)
            .overlay(categoryViewModel.isLoading ? ProgressView() : nil)
            .onAppear {
                categoryViewModel.fetchCategories()
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let fetcher = ProductAPIFetcher()
        let client = ProductClient(fetcher: fetcher)
        let viewModel = CategoryViewModel(client: client)
 
        return CategoryView(categoryViewModel: viewModel)
    }
}
