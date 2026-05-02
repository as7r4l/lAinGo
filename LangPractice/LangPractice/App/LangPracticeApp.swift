

import SwiftUI

@main
struct LangPracticeApp: App {
    @State private var viewModel = LessonsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
