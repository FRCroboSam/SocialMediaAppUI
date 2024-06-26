//
//  ShopScrollView.swift
//  NpaMockApp
//
//  Created by Samuel Wang on 4/12/24.
//

import SwiftUI

struct CategoryScrollView: View {
    @EnvironmentObject var podcastVM: PodcastVM
    @State private var currentIndex = 0
    @State private var maxPodcastViewHeight: CGFloat = 380
    let filters = [
        "Sport",
        "League",
        "Location",
        "Ages",
        "Private-Only",
        "Group"
    ]
    @State private var urls = [
        "https://thehill.com/wp-content/uploads/sites/2/2023/10/williamsjada_111822ap_high-school-athletes-nil.jpg?strip=1",
        "https://online.jwu.edu/wp-content/uploads/2023/06/sports20agent.jpg",
        "https://d3on3ztz3vi4v9.cloudfront.net/uploads/2013/06/25155356/Concentration-629x419-1.jpg",
        "https://www.shape.com/thmb/Hcvt02WmCFLvv3A6o2CGhYOPWLI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Heavy-vs-Light-Weights-GettyImages-946365998-4cabfff802b145c09c9d0dcc6d655267.jpg",
    ]

    @State private var titles = [
        "Athlete Bios",
        "Recruitment",
        "Coaching",
        "Fitness"
    ]
    @State private var amounts = [
        "34.3K",
        "1.2K",
        "567",
        "4.2K"
    ]
    
    let athleteFilters = [
        "All",
        "Private Lessons",
        "Group Lessons",
        "Clubs"
    ]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack {
                Spacer()
                    .frame(width: 20)
                ForEach(urls.indices, id: \.self) { index in
                    NavigationLink{
                        if(index == 0){
                            AthleteStoryContentView()
                        }
                        else if(index == 1){
                            RecruitmentContentView()
                        }
                        else if(index == 2){
                            CoachingContentView()
                        }
                    }label: {CategoryView(item_url: urls[index], text: titles[index], amount: amounts[index])
                            .padding(.vertical, 10)
                        Spacer()
                            .frame(width: 10)
                    }
                }
            }
        }
        
        
//        ScrollView(.horizontal, showsIndicators: false){
//            HStack(spacing: 10){
//                Spacer()
//                    .frame(width: 10)
//                EventCardVertical(event_url: "https://www.footballcamps.com/media/fbcamps360webcmscom/photos/1458/1458_3.jpg")
//
//                EventCardVertical(event_url:
//                            "https://www.ussportscamps.com/media/images/soccer/nike/camps/soxdal_gallerypic3_950x516.jpg"
//                )
//
//                EventCardVertical(event_url:
//                            "https://ymcagbw.org/sites/default/files/2019-03/by_thank_you_reception_cover_shot.jpg"
//                )
//                EventCardVertical(event_url:
//                            "https://ymcagbw.org/sites/default/files/2019-03/by_thank_you_reception_cover_shot.jpg"
//                )
//
////                .scaleEffect(0.8)
//
//
////                .scaleEffect(0.8)
//
//            }
//        }.scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryScrollView()
        .environmentObject(PodcastVM())
}
