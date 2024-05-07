import SwiftUI
struct CustomTabBarView: View {
    @State private var scrollPosition: CGPoint = .zero

    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        tabBarVersion2
            .onChange(of: selection, perform: { value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    print("TAB THING IS CHANGING")
                    localSelection = value
                }
            })
    }
}
extension CustomTabBarView {
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))

        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(localSelection == tab ? tab.color.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
    
    private var tabBarVersion1: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    tabView(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                }
            }
            //.padding(6)
            .background(Color.white.ignoresSafeArea(edges: .bottom))
        }.scrollIndicators(.hidden)
    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
    
}

extension CustomTabBarView {

    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            VStack{
                Image(systemName: tab.iconName)
                    .font(.system(size: 25))
                    .frame(height: 25)
                
                Text(tab.title)
                    //.font(.system(size: 15, weight: .semibold, design: .rounded))                    
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
            }
            .frame(width: 40, height: 50)
            if(localSelection == tab){
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 45, height: 2)
                    .matchedGeometryEffect(id: "background_rectangle", in: namespace)

            }
            else{
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 45, height: 2)
            }
            

        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
//        .background(
//            ZStack {
//                if localSelection == tab {
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(tab.color.opacity(0.2))
//                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
//                        .padding(-5)
//                        .frame(width : 70)
//
//                }
//            }
//        )
    }
    
    private var tabBarVersion2: some View {
        ScrollViewReader{ reader in
            ScrollView(.horizontal){
                HStack {
                    ForEach(tabs.indices, id: \.self) { index in
                        let tab = tabs[index]
                        tabView2(tab: tab)
                            .id(index)
                            .onTapGesture {
                                switchToTab(tab: tab)
                                
                                withAnimation{
                                    reader.scrollTo(2)
                                }
                                
                                
                            }
                        
                        Spacer()
                            .frame(width: 30)
                    }
                    Spacer()
                        .frame(width: 200)
                }
                
                .padding(6)
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                print("SCROLL POSITION")
                print(value.x)
                self.scrollPosition = value
            }
        }
            
    }
    
}
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
