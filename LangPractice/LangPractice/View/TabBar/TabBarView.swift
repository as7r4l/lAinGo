import SwiftUI

struct TabBarView: View {
    @State private var selection: String = "Home"
    let tabBarItems = ["Home", "Progress"]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selection) {
                SpeakView()
                .tag("Home")
                StatisticView()
                .tag("Progress")
            }
            
            HStack {
                Spacer()
                ForEach(tabBarItems, id: \.self) { item in
                    TabBarItem(tab: item, selected: $selection)
                    Spacer()
                }
            }
            .padding(.top, 18)
            .background(.white)
        }
    }
}

#Preview {
    TabBarView()
}
