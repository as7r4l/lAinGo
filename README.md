# LangPractice — AI English Tutor iOS App

[![Swift](https://img.shields.io/badge/Swift-5.9%2B-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0%2B-blue.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-red.svg)](https://developer.apple.com/xcode/swiftui/)
[![Gemini](https://img.shields.io/badge/AI-Google%20Gemini%201.5%20Flash-brightgreen.svg)](https://ai.google.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**LangPractice** — нативное iOS-приложение для интерактивной разговорной практики английского языка в реальном времени. Приложение имитирует живой диалог с дружелюбным репетитором на базе **Google Gemini API**, озвучивает ответы с помощью **AVSpeechSynthesizer** и помогает вырабатывать ежедневную привычку через систему стриков и отслеживание прогресса.

---

## Ключевые возможности

- 🤖 **Интеллектуальный AI-репетитор:** Интеграция с быстрой моделью `gemini-1.5-flash` через REST API. Промпт удерживает контекст темы, контролирует использование ключевых фраз урока и задает вовлекающие вопросы.
- 🔊 **Озвучивание реплик (Text-to-Speech):** Синтез речи репетитора на лету с использованием нативного фреймворка `AVFoundation`.
- 📚 **Тематические сценарии:** Каталог практических тем повседневного общения (кафе, знакомство, аэропорт, покупки, визит к врачу) с опорными фразами.
- 🔥 **Геймификация и Streak-трекер:** Учет ежедневной активности пользователя, подсчет текущего и рекордного стрика (ударного режима) с сохранением в `UserDefaults`.
- ⚡️ **Современный стек SwiftUI:** Использование макроса `@Observable` (Observation framework), реактивное управление состоянием и кастомный таббар.

---

## Стек технологий и архитектура

- **Язык & UI:** Swift, SwiftUI (iOS 17+)
- **Управление состоянием:** Observation Framework (`@Observable`)
- **Архитектура:** MVVM (Model-View-ViewModel) + Service Layer
- **ИИ / LLM:** Google Gemini API (`gemini-1.5-flash`) via `URLSession` async/await
- **Аудио:** `AVFoundation` (`AVSpeechSynthesizer`, `AVSpeechUtterance`)
- **Хранение данных:** `UserDefaults` (для сохранения `UserProgress`) и бандл JSON (`Lessons.json`)

---

## Структура проекта

```text
LangPractice/
├── App/
│   └── LangPracticeApp.swift         # Точка входа приложения
├── Models/
│   ├── LessonModel.swift             # Модель данных урока (ID, title, phrases, emoji)
│   ├── ChatMessageModel.swift        # Модель сообщения в чате (роли user/assistant/system)
│   └── UserProgressModel.swift       # Модель прогресса, стриков и затраченного времени
├── Services/
│   ├── LLMService.swift              # Сетевой клиент к Google Gemini API
│   ├── SpeechService.swift           # Озвучивание текста (AVSpeechSynthesizer)
│   ├── LessonsService.swift          # Загрузка доступных уроков из JSON
│   └── ProgressService.swift         # Логика обновления и персистенции прогресса
├── ViewModels/
│   ├── LessonsViewModel.swift        # Глобальное состояние каталога и стрика
│   └── PracticeSessionViewModel.swift# Состояние активной сессии диалога с ИИ
├── Views/
│   ├── ContentView.swift             # Корневой контейнер
│   ├── TabBarView.swift              # Кастомная навигационная панель
│   ├── TabBarItem.swift              # Элемент кастомного таббара
│   ├── SpeakView.swift               # Главный экран старта практики
│   ├── LessonView.swift              # Интерактивный экран диалога с ИИ
│   ├── StatisticView.swift           # Экран статистики и стриков
│   ├── PlanSheetView.swift           # Модальное окно учебного плана
│   └── PlanSheetItem.swift           # Элемент пункта учебного плана
└── Resources/
    ├── Lessons.json                  # База тем и фраз для практики
    └── Assets.xcassets               # Иконки, иллюстрации и цветовая палитра
```
---

## Разработчик

**Никита / Поведайко**
* iOS Developer
* [LinkedIn](https://www.linkedin.com/in/nikita-p-400482396/) | [Telegram](https://t.me/n_nicky) 
