//
//  CategoriesView.swift
//  NpaMockApp
//
//  Created by Samuel Wang on 4/27/24.
//

import SwiftUI
import NukeUI
struct CategoryView: View {
    let item_url: String
    let text: String
    let amount: String

    var body: some View {
        VStack(alignment: .leading){
//            Spacer()
//                .frame(height: 10)
            
            LazyImage(url: URL(string:item_url)) { phase in
              if let image = phase.image {
                image // Displays the loaded image.
                      .resizable()
                      .scaledToFill()
                      .frame(width: 140, height: 175)
                      .clipped()
                      .roundedCorner(8, corners: .topLeft)
                      .roundedCorner(8, corners: .topRight)
                      .roundedCorner(8, corners: .bottomLeft)
                      .roundedCorner(8, corners: .bottomRight)
                      
                  
              } else {
                  LoadingView(width: 140, height: 175)
              }
               
            }

            .overlay(alignment: .bottomTrailing){
                VStack{
                    Text(text.uppercased())
                        .bold()
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(5)
                        .background{
                            Color.blue.opacity(0.5)
                                .blur(radius: 5)
                                .offset(x: -5)
                        }
                    Spacer()
                        .frame(height: 10)
                }
            }
            
            
//            Button {
//                
//            } label: {
//                Text("View 5.9K")
//                    .foregroundStyle(.white)
//                    .padding(
//                    .background{
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.blue)
//                    }
//                    .padding(.leading, 10)
//
//
//            }


        }
        
//        .background{
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.blue.opacity(0.1))
//
//                .shadow(color: Color(UIColor.lightGray).opacity(0.7),radius: 3)                .mask(Rectangle().padding(.bottom, -30))
//                .shadow(color: Color.gray, radius: 1)
//
//
//            
//        }
    }
}

#Preview {
    CategoryView(item_url: "https://thehill.com/wp-content/uploads/sites/2/2023/10/williamsjada_111822ap_high-school-athletes-nil.jpg?strip=1", text: "Athletes", amount: "5.3K" )
}
