import SwiftUI
import AVKit

struct CookingGuideView: View {
    let steps: [CookingStep]
    @State private var currentStepIndex = 0
    @StateObject private var voiceController = VoiceController()

    var body: some View {
        VStack {
            if let videoURL = steps[currentStepIndex].videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 200)
            }

            Text(steps[currentStepIndex].instruction)
                .padding()

            HStack {
                Button("Back") {
                    if currentStepIndex > 0 {
                        currentStepIndex -= 1
                    }
                }
                .disabled(currentStepIndex == 0)

                Button("Next") {
                    if currentStepIndex < steps.count - 1 {
                        currentStepIndex += 1
                    }
                }
                .disabled(currentStepIndex >= steps.count - 1)
            }
        }
        .navigationBarTitle("Cooking Step \(currentStepIndex + 1) of \(steps.count)", displayMode: .inline)
        .padding()
        .onAppear {
                    try? voiceController.startListening()
                }
                .onDisappear {
                    voiceController.stopListening()
                }
                .onChange(of: voiceController.recognizedText) { newValue in
                    // Check for "Next" or "Back" and update `currentStepIndex` accordingly
                    handleVoiceCommand(newValue.lowercased())
                }
    }
    
    private func goToNextStep() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
        }
    }

    private func goToPreviousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }

    private func handleVoiceCommand(_ command: String) {
        if command.contains("next") {
            goToNextStep()
        } else if command.contains("back") {
            goToPreviousStep()
        }
    }
}
