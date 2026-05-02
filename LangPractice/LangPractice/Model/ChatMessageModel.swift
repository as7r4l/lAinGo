import Foundation

// Модель одного сообщения в чате
struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let role: Role
    let content: String
    
    enum Role {
        case user      // То, что сказал пользователь
        case assistant // То, что ответил ИИ
        case system    // Скрытое сообщение с настройками для ИИ (например: "Ты репетитор английского...")
    }
}
