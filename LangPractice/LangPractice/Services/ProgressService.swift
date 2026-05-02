import Foundation

final class ProgressService {
    
    private let userDefaults = UserDefaults.standard
    private let progressKey = "userProgress"
    
    
    func loadProgress() -> UserProgress {
        if let data = userDefaults.data(forKey: progressKey) {
            do {
                let decoder = JSONDecoder()
                let progress = try decoder.decode(UserProgress.self, from: data)
                return progress
                
            } catch {
                print("Error loading progress: \(error)")
                return defaultProgress()
            }
        }
        
        
        return defaultProgress()
    }
    
    
    
    func saveProgress(_ progress: UserProgress) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(progress)
            userDefaults.set(data, forKey: progressKey)
        } catch {
            print("Error saving progress: \(error)")
        }
    }
    
    
    func markLessonCompleted(_ lessonId: Lesson.ID, in progress: inout UserProgress) {
        
        progress.completedLessons.insert(lessonId)
        progress.totalLessonsCompleted = progress.completedLessons.count
        
        updateStreakOnCompletion(in: &progress)
        
        saveProgress(progress)
    }
    
    
    private func updateStreakOnCompletion(in progress: inout UserProgress) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        guard let lastDate = progress.lastLessonDay else {
            progress.streak = 1
            progress.bestStreak = 1
            progress.lastLessonDay = today
            
//            saveProgress(progress)
            return
        }
        
        let lastDay = calendar.startOfDay(for: lastDate)
        let daysDifference = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
        
        if daysDifference == 0 {
            return
        } else if daysDifference == 1 {
            progress.streak += 1
            
            if progress.streak > progress.bestStreak {
                progress.bestStreak = progress.streak
            }
            progress.lastLessonDay = today
        } else {
            progress.streak = 1
            progress.lastLessonDay = today
        }
        
//        saveProgress(progress)
    }
    
    
    private func defaultProgress() -> UserProgress {
        return UserProgress(
            completedLessons: [],
            streak: 0,
            bestStreak: 0,
            lastLessonDay: nil,
            totalLessonsCompleted: 0,
            totalTimeSpent: 0
        )
    }
    
    
}


