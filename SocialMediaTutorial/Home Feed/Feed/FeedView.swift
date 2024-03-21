//
//  HomeView.swift
//  SocialMediaTutorial
//
//  Created by Eymen on 14.07.2023.
//

import SwiftUI
import YouTubePlayerKit
struct FeedView: View {
    @EnvironmentObject var vm: FeedVM
    @State var showCommentSection = false
//    @ObservedObject var postData: ReadJsonData
    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    var deviceWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    @State var current: CGFloat? = nil // << any initial
    @State var isUp = false
    @State private var translation = CGSize.zero
    @State private var prevTranslation = CGSize.zero
    @State private var lastTranslation = CGSize.zero
    @State var lastNonZeroTranslation = CGSize.zero
    @State private var peakVelocity = 0.0
    
    @State private var lastStateWasTop = false
    
//    @State private var currentPost: Post
    
    var body: some View {
        let blankPost = vm.posts[0]
        NavigationStack {
                ZStack{
                    ScrollView{
                        StoryListView() // Display the list of stories
                        PostListView(showCommentSection: false, onCommentTapped: {
                            withAnimation(.easeIn){
                            }
                        }) // Display the list of posts
                    }
                    .brightness(vm.showCommentSection ? -0.3 : 0.0)
                    .scrollDisabled(vm.showCommentSection)
                    .zIndex(0)
                    if(vm.showCommentSection){
                        VStack{
                            Spacer()
                                .frame(height: 200)
                            VStack{
                                Spacer()
                                    .frame(height: 10)
                                Text("Comments")
                                Spacer()
                                    .frame(height: 10)
                                Divider()
                                    .background(Color.gray)
                                Spacer()
                                    .frame(height: 10)
                            }
                            .background{
                                Color.white
                            }
                            .cornerRadius(40)
                            .contentShape(Rectangle())
                            .highPriorityGesture(dragGesture)
                            .offset(
                                y: lastTranslation.height + 10
                            )
                            
                            VStack {
                                GeometryReader { geometry in
                                    CommentSectionView(vm: vm.selected_post_vm ?? PostVM(post: blankPost))
                                        .frame(width: deviceWidth, height: scrollViewHeight(for: geometry))
                                        .background(Color.white)
                                        .zIndex(12)
                                }
                            }
                            .offset(y: self.lastTranslation.height)
                            
                        }
                    }
                    
                    
                }
        }
    }
        func scrollViewHeight(for geometry: GeometryProxy) -> CGFloat {
            let vStackFrame = geometry.frame(in: .global)
            let vStackTop = vStackFrame.minY
            let maxScrollViewHeight = 1/2 * deviceHeight - self.lastTranslation.height
            
            // Calculate the remaining space from the bottom of the device to the bottom of the ScrollView
            let remainingSpace = deviceHeight - maxScrollViewHeight
            
            // Adjust the ScrollView height by adding the remaining space to its maximum height
            return max(deviceHeight - vStackTop, 1/4 * deviceHeight)
        }
        var dragGesture: some Gesture {
            DragGesture()
                .onChanged { value in
                    
                    peakVelocity = max(abs(peakVelocity), abs(value.velocity.height))
                    prevTranslation = translation
                    translation.height = value.translation.height
                    lastTranslation.height += value.translation.height
                    if(abs(value.translation.height) >= 0.01){
                        lastNonZeroTranslation.height = value.translation.height
                    }
                
                    lastTranslation.height = max(-220, min(lastTranslation.height, 500)) //dont go too far off bottom of the screen

                }
                .onEnded { value in
                    
                    let velocity = value.velocity.height
                    print("Peak Velocity: " + String(Double(peakVelocity)))
                    let isSwipe = lastNonZeroTranslation.height == translation.height
                    var isUp = true;
                    isUp = prevTranslation.height < 0 && translation.height < 0
                    print(isUp ? "UP" : "DOWN")
                    print(isSwipe ? "Swipe" : "")
                    withAnimation(.easeIn){
                        if(!isUp && isSwipe && abs(peakVelocity) > 700 && lastTranslation.height < 0){
                            lastTranslation.height = 0
                        }
                        else if(!isUp && isSwipe && abs(peakVelocity) > 900) {
                            lastTranslation.height = 500
                            withAnimation(.easeOut) {
                                vm.showCommentSection = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                                    lastTranslation.height = 0
                                }
                            }

                        }
                        else if (lastTranslation.height < -92 || isUp && isSwipe) {
                            lastTranslation.height = -220
                        }
                        else{
                            lastTranslation.height = 0
                        }
                    }
                    peakVelocity = 0


                    
                }
        }
    }

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
