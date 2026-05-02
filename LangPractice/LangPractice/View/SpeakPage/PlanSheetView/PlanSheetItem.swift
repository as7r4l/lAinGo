
import SwiftUI

struct PlanSheetItem: View {
    let title: String = "Empty lesson"
    let lessonAchieve: Bool = true
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18))
            Spacer()
            
            Image(systemName: lessonAchieve ? "checkmark.square.fill" : "square")
                .foregroundStyle(lessonAchieve ? .green : .gray)
                .padding(.horizontal)
        }
        
    }
}

#Preview {
    PlanSheetItem()
}
