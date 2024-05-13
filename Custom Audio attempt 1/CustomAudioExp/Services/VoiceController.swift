import Speech
import AVFoundation

class VoiceController: ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    @Published var recognizedText = ""

    func startListening() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode // Directly access inputNode, it's not optional.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        recognitionRequest?.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
            guard let strongSelf = self else { return }

            if let result = result {
                strongSelf.recognizedText = result.bestTranscription.formattedString
                // You can handle command detection here based on the recognizedText
            }
            if error != nil || result?.isFinal == true {
                strongSelf.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                strongSelf.recognitionRequest = nil
                strongSelf.recognitionTask = nil
            }
        }

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }

    func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}
