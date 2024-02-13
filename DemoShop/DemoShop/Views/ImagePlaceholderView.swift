//
//  ImagePlaceholderView.swift
//  DemoShop
//
//  Created by Devashish Urwar on 13/02/24.
//

import SwiftUI

struct ImagePlaceholderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(.lightGray))
                .aspectRatio(1, contentMode: .fill)

            Image(systemName: "photo")
                .resizable()
                .foregroundColor(.white)
                .scaledToFit()
                .padding()
                .frame(width: 64, height: 64)
        }
    }
}

#Preview {
    ImagePlaceholderView()
}
