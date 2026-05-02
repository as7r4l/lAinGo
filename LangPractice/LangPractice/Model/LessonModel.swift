
import Foundation

struct Lesson: Identifiable, Codable {
    var id: Int
    let title: String
    let description: String
    let keyPhrases: [String]
    let emoji: String
}
