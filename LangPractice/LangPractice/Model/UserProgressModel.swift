import Foundation

struct UserProgress: Codable {
    var completedLessons: Set<Lesson.ID>
    var streak: Int
    var bestStreak: Int
    var lastLessonDay: Date?
    var totalLessonsCompleted: Int
    var totalTimeSpent: TimeInterval
}
