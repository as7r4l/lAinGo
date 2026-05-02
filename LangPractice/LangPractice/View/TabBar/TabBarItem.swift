import SwiftUI
import Foundation

struct TabBarItem: View {
    @State var tab: String
    @Binding var selected: String
    var body: some View {
        ZStack {
            Button(action: {
                selected = tab
            }) {
                VStack {
                    Image(tab)
                        .resizable()
                        .frame(width: 27, height: 25)
                    Text(tab)
                        .foregroundStyle(.black)
                        .font(.system(size: 14))
                }
            }
            
            
        }
        .opacity(selected == tab ? 1 : 0.5)
        
        
    }
}

