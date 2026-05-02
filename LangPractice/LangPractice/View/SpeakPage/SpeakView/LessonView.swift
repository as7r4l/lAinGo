import SwiftUI

struct LessonView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: PracticeSessionViewModel
    @State private var inputText: String = ""
    
    // Анимация "пульсации" для кнопки микрофона
    @State private var isRecording: Bool = false
    
    init(lesson: Lesson) {
        _viewModel = State(wrappedValue: PracticeSessionViewModel(lesson: lesson))
    }
    
    // Находим последнее сообщение от ИИ для крупных субтитров
    var currentAIText: String {
        viewModel.messages.last(where: { $0.role == .assistant })?.content ?? "..."
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 1. Верхняя панель: Прогресс или Название
            HStack {
                Button(action: {
                    viewModel.stopLesson()
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundStyle(.gray)
                        .padding()
                }
                Spacer()
                Text(viewModel.currentLesson.title)
                    .font(.headline)
                    .bold()
                Spacer()
                // Пустая вьюха для баланса HStack
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.top)
            
            Spacer()
            
            // 2. Центральная часть: Аватар и Субтитры
            VStack(spacing: 30) {
                // Аватар репетитора (можно заменить на твою картинку)
                ZStack {
                    Circle()
                        .fill(viewModel.isThinking ? Color.blue.opacity(0.2) : Color.clear)
                        .frame(width: 150, height: 150)
                        .scaleEffect(viewModel.isThinking ? 1.2 : 1.0)
                        .animation(viewModel.isThinking ? .easeInOut(duration: 1).repeatForever() : .default, value: viewModel.isThinking)
                    
                    Image(systemName: "face.smiling.fill") // Заглушка аватара
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.blue)
                        .background(Circle().fill(.white))
                }
                
                // Субтитры ИИ
                if viewModel.isThinking {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding(.top, 20)
                } else {
                    Text(currentAIText)
                        .font(.system(size: 24, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .animation(.easeInOut, value: currentAIText)
                }
            }
            
            Spacer()
            
            // 3. Зона управления (Голос)
            VStack(spacing: 20) {
                // Кнопка микрофона
                Button(action: {
                    // В будущем здесь будет старт/стоп записи голоса
                    isRecording.toggle()
                }) {
                    ZStack {
                        Circle()
                            .fill(isRecording ? Color.red.opacity(0.3) : Color.blue.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .scaleEffect(isRecording ? 1.3 : 1.0)
                            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isRecording)
                        
                        Circle()
                            .fill(isRecording ? Color.red : Color.blue)
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "mic.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                }
                .disabled(viewModel.isThinking)
                
                Text(isRecording ? "Listening..." : "Tap to Speak")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                // 4. ВРЕМЕННАЯ ЗОНА ДЛЯ ТЕСТОВ (Пока нет микрофона)
                HStack {
                    TextField("Test input...", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Send") {
                        viewModel.sendMessage(inputText)
                        inputText = ""
                    }
                    .disabled(inputText.isEmpty || viewModel.isThinking)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    let dummyLesson = Lesson(id: 1, title: "At the Cafe", description: "", keyPhrases: [], emoji: "☕️")
    LessonView(lesson: dummyLesson)
}
