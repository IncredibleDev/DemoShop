//
//  DemoShopApp.swift
//  DemoShop
//
//  Created by Devashish Urwar on 07/02/24.
//

import SwiftUI
import Combine

@main
struct DemoShopApp: App {
    let cart = Cart()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
            .environmentObject(cart)
        }
    }
}
