//
//  TabBarView.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case product
    case category
    case cart
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .product:
            Label(TabConstants.product, systemImage: ImageNameConstants.product)
        case .category:
            Label(TabConstants.category, systemImage: ImageNameConstants.category)
        case .cart:
            Label(TabConstants.cart, systemImage: ImageNameConstants.cart)
        }
    }
    @ViewBuilder
    var destination: some View {
        let fetcher = ProductAPIFetcher()
        let client = ProductClient(fetcher: fetcher)
        
        switch self {
        case .product:
            let productViewModel = ProductViewModel(client: client, category: nil)
            ProductView(viewModel: productViewModel)
        case .category:
            let categoryViewModel = CategoryViewModel(client: client)
            CategoryView(categoryViewModel: categoryViewModel)
        case .cart:
            CartView()
        }
    }
}

struct AppTabView: View {
    @Binding var selection: AppScreen?
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

struct TabBarView: View {
    @State private var selection: AppScreen? = .product
    var body: some View {
        AppTabView(selection: $selection)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()

        return TabBarView()
            .environmentObject(cart)
    }
}
