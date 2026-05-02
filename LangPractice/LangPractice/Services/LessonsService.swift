import Foundation

final class LessonsService {
    
    
    func loadLessons() -> [Lesson] {
        
        guard let url = Bundle.main.url(forResource: "Lessons", withExtension: "json") else {
            print("Lessons.json не найден")
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Не удалось прочитать Lessons.json")
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let lessons = try decoder.decode([Lesson].self, from: data)
            return lessons
            
        } catch {
            print("Error loading tasks: \(error)")
            return []
        }
        
    }
}
