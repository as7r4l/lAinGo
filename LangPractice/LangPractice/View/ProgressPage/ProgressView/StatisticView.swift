
import SwiftUI

struct StatisticView: View {
    @Environment(LessonsViewModel.self) private var viewModel
    var body: some View {
        List {
            Section(header: Text("Progress")
                .foregroundStyle(.black)
                .font(.system(size: 20, weight: .bold))) {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Lessons Achieve")
                            Spacer()
                            Text("\(viewModel.totalLessonCompleted)")
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                        
                        HStack {
                            Text("Active Minutes")
                            Spacer()
                            Text("0")
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                    }
                }
            Section(header: Text("Streak")
                .foregroundStyle(.black)
                .font(.system(size: 20, weight: .bold))) {
                    VStack {
                        HStack {
                            Text("Current Streak")
                            Spacer()
                            Text("\(viewModel.currentStreak)")
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                        .background(Color("StreakBackgroundColor"))
                        .clipShape(Capsule())
                        
                        
                        HStack {
                            Text("Best Streak")
                            Spacer()
                            Text("\(viewModel.bestStreak)")
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                        .background(Color("BestStreakBackgroundColor"))
                        .clipShape(Capsule())
                    }
                }
        }
    }
}

#Preview {
    StatisticView()
        .environment(LessonsViewModel())
}
