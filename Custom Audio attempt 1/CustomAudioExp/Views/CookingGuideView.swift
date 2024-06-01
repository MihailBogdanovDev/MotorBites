import SwiftUI
import AVKit

struct CookingGuideView: View {
    let steps: [CookingStep]
    @State private var currentStepIndex = 0
    @StateObject private var voiceController = VoiceController()
    @State private var player: AVPlayer?


    var body: some View {
        VStack {
            if let videoURL = steps[currentStepIndex].videoURL {
                VideoPlayer(player: player)
                    .onAppear {
                                         // Initialize the player with the new video URL
                                         self.player = AVPlayer(url: videoURL)
                                         self.player?.play()  // Start playing automatically
                                     }
                                     .frame(height: 200)
                                     .onChange(of: currentStepIndex) { _ in
                                         // Update the player when the step changes
                                         guard let newURL = steps[currentStepIndex].videoURL else { return }
                                         self.player = AVPlayer(url: newURL)
                                         self.player?.play()
                                     }
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
                    if !newValue.isEmpty {
                          handleVoiceCommand(newValue.lowercased())
                          voiceController.recognizedText = "" // Reset the recognized text after handling
                      }
                }
    }
    
    private func goToNextStep() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
        }
        print("next")
    }

    private func goToPreviousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
        print("back")
    }

    private func handleVoiceCommand(_ command: String) {
        print(command)
        if command.contains("next") {
            goToNextStep()
        } else if command.contains("back") {
            goToPreviousStep()
        }
    }
}
