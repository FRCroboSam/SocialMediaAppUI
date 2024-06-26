//
//  ExploreCategoryView.swift
//  NpaMockApp
//
//  Created by Samuel Wang on 6/9/24.
//

import SwiftUI

struct ExploreCategoryView: View {
    @State var imageName: String?
    @State var textName: String?
    var body: some View {
        VStack(spacing: 5){
            Image(imageName ?? "sports_shop_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .padding(20)
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(UIColor.systemGray4).opacity(0.12))
                        .shadow(radius: 1.0)
                    
                }
            Text(textName ?? "Sports Gear")
                .font(.caption)
                .bold()
                .foregroundStyle(.black.opacity(0.6))
            Spacer()
        }
        .frame(width: 90)

    }
}

#Preview {
    ExploreCategoryView()
}
