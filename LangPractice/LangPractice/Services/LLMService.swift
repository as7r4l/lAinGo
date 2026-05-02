import Foundation

// MARK: - Gemini API Models
// Эти структуры нужны для того, чтобы Swift мог перевести наши данные в JSON, понятный гуглу

struct GeminiRequest: Codable {
    let contents: [GeminiContent]
    let systemInstruction: GeminiSystemInstruction?
}

struct GeminiSystemInstruction: Codable {
    let parts: [GeminiPart]
}

struct GeminiContent: Codable {
    let role: String // У Gemini роли называются "user" и "model"
    let parts: [GeminiPart]
}

struct GeminiPart: Codable {
    let text: String
}

struct GeminiResponse: Codable {
    let candidates: [GeminiCandidate]?
}

struct GeminiCandidate: Codable {
    let content: GeminiContent
}


// MARK: - LLM Service
final class LLMService {
    // Вставь сюда свой ключ (его можно получить бесплатно на сайте Google AI Studio)
    private let apiKey = "AIzaSyA0OkzMmIkvJtiWH3-uKXzUJNyrY8DYuFI"
    
    // Используем быструю модель Flash
    private let modelName = "gemini-1.5-flash"
    
    func sendMessage(message: String, currentLesson: Lesson, history: [ChatMessage]) async throws -> ChatMessage {
        
        // 1. Собираем URL запроса
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/\(modelName):generateContent?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // 2. Настраиваем "мозг" репетитора (Системный промпт)
        let systemText = """
        You are a friendly and helpful English tutor. 
        The topic of our current lesson is: "\(currentLesson.title)". 
        Your goal is to help the user practice these key phrases: \(currentLesson.keyPhrases.joined(separator: ", ")).
        Keep your answers short (1-3 sentences), maintain the conversation, and always end by asking a question to keep the user talking.
        """
        let systemInstruction = GeminiSystemInstruction(parts: [GeminiPart(text: systemText)])
        
        // 3. Формируем историю переписки
        var geminiContents: [GeminiContent] = []
        
        // Переводим нашу внутреннюю историю в формат Gemini
        for chatMsg in history {
            // Игнорируем системные сообщения из истории, так как мы передаем их отдельно выше
            guard chatMsg.role != .system else { continue }
            
            let role = chatMsg.role == .user ? "user" : "model"
            geminiContents.append(GeminiContent(role: role, parts: [GeminiPart(text: chatMsg.content)]))
        }
        
        // 4. Добавляем новое (текущее) сообщение пользователя
        geminiContents.append(GeminiContent(role: "user", parts: [GeminiPart(text: message)]))
        
        // 5. Собираем итоговый "пакет" для отправки
        let requestBody = GeminiRequest(contents: geminiContents, systemInstruction: systemInstruction)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        // 6. Делаем сетевой запрос (асинхронно ждем ответа)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Проверка на ошибки сервера (например, если API ключ неверный)
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            print("Server error: \(httpResponse.statusCode)")
            if let errorText = String(data: data, encoding: .utf8) { print("Details: \(errorText)") }
            throw URLError(.badServerResponse)
        }
        
        // 7. Декодируем JSON-ответ обратно в Swift-объекты
        let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
        
        // 8. Достаем сам текст ответа из сложной структуры JSON
        guard let responseText = geminiResponse.candidates?.first?.content.parts.first?.text else {
            throw NSError(domain: "LLMService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response from model"])
        }
        
        // 9. Возвращаем сообщение в нашем родном формате ChatMessage
        return ChatMessage(role: .assistant, content: responseText)
    }
}
