import Foundation
import Observation

@Observable
final class PracticeSessionViewModel {
    var messages: [ChatMessage] = []
    var isThinking: Bool = false
    
    private var llmService = LLMService()
    private var speechService = SpeechService()
    
    let currentLesson: Lesson
    init(lesson: Lesson) {
        self.currentLesson = lesson
        
        let welcomeText = "Hello! Ready to practice your English? Let's talk about \(lesson.title)"
        messages.append(ChatMessage(role: .assistant, content: welcomeText))
        speechService.speak(text: welcomeText)
    }
    
    func sendMessage(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        let userMessage = ChatMessage(role: .user, content: trimmedText)
        messages.append(userMessage)
        isThinking = true
        
        Task {
            do {
                let aiResponse = try await llmService.sendMessage(message: trimmedText,
                                                                  currentLesson: currentLesson,
                                                                  history: messages)
                await MainActor.run {
                    self.messages.append(aiResponse)
                    self.isThinking = false
                    
                    speechService .speak(text: aiResponse.content)
                }
            } catch {
                print("Request error to Gemini: \(error)")
                
                await MainActor.run {
                    self.isThinking = false
                    self.messages.append(ChatMessage(role: .assistant, content: "Oops, connection error. Please try again."))
                }
            }
            
        }
    }
    
    func stopLesson() {
        speechService.stopSpeaking()
    }
    
}
