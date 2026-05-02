import Observation
import Foundation

@Observable
final class LessonsViewModel {
    var lessons: [Lesson] = []
    var progress: UserProgress
    var isLoading: Bool = false
    
    private var lessonsService: LessonsService
    private var progressService: ProgressService
    
    var currentStreak: Int {
        progress.streak
    }
    var bestStreak: Int {
        progress.bestStreak
    }
    var totalLessonCompleted: Int {
        progress.totalLessonsCompleted
    }
    
    init(
        lessonsServices: LessonsService = LessonsService(),
        progressServices: ProgressService = ProgressService()) {
            self.lessonsService = lessonsServices
            self.progressService = progressServices
            
            self.progress = progressServices.loadProgress()
            
            loadLessons()
        }
    
    func loadLessons() {
        isLoading = true
        lessons = lessonsService.loadLessons()
        isLoading = false
    }
    
    func completeLesson(_ lessonID: Lesson.ID) {
        
    }
    
}

