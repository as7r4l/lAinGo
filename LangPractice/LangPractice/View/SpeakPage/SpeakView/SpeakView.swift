
import SwiftUI

struct SpeakView: View {
    @Environment(LessonsViewModel.self) private var viewModel
    @State var showPlanSheet: Bool = false
    @State var isLessonStarted: Bool = false
    var body: some View {
        VStack {
            HStack {
                Image("USA")
                    .resizable()
                    .frame(width: 60, height: 45)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                
                Spacer()
                
                Button(action: {
                    showPlanSheet.toggle()
                }) {
                        Text("Plan")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.black)
                    }
                .sheet(isPresented: $showPlanSheet) {
                    PlanSheetView()
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 60)
                .background(Color("PlanBackgroundColor"))
                .clipShape(Capsule())
                .shadow(radius: 1)
                .offset(x: 20)
                
                
                Spacer()
                
                ZStack {
                    
                    
                    
                    HStack(spacing: 0) {
                        Image("Streak")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("\(viewModel.currentStreak)")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(Color("StreakCountColor"))
                            .shadow(color: .black, radius: 1)
                    }
                    .offset(x: -6)
                    .padding(.horizontal, 15)
                    .background {
                        Capsule()
                            .frame(width: 80, height: 50)
                            .foregroundStyle(Color("StreakBackgroundColor"))
                            .opacity(0.6)
                    }
                    
                }
            }
            .padding(.top, 20)
            Spacer()
            
            VStack {
                Image("")
                
                Text(viewModel.lessons.first?.title ?? "Loading...")
                    .font(.system(size: 20))
                    .padding()
                
                Button(action: {
                    isLessonStarted.toggle()
                    
                }) {
                    Text("Start")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 25, weight: .semibold))
                }
                .fullScreenCover(isPresented: $isLessonStarted) {
                    LessonView(lesson: Lesson(id: 1, title: "At the Cafe", description: "", keyPhrases: [], emoji: "☕️"))
                }
                .padding()
                .padding(.horizontal, 60)
                .background(.blue)
                .clipShape(Capsule())
            }
            
            
            Spacer()
            
        }
    }
}

#Preview {
    SpeakView()
        .environment(LessonsViewModel())
}
