import Foundation
import AVFoundation

final class SpeechService: NSObject {
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String, languageCode: String = "en-US") {
        let utterance = AVSpeechUtterance(string: text)
        
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
}
