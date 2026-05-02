
import SwiftUI

struct PlanSheetView: View {
    @Environment(\.dismiss) var presentationMode
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                PlanSheetItem()
            }
            
            Button(action: {
                presentationMode()
            }) {
                Text("Close")
                    .foregroundStyle(Color.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(.blue)
            .clipShape(Capsule())
            

        }
    }
}

#Preview {
    PlanSheetView()
}
