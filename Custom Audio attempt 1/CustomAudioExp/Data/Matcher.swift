/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model that is responsible for matching against the catalog and update the SwiftUI Views.
*/

import ShazamKit
import AVFAudio
import Combine

struct MatchResult: Equatable {
    let mediaItem: SHMatchedMediaItem?
    let recipe: Recipe?
    
    static func == (lhs: MatchResult, rhs: MatchResult) -> Bool {
        return lhs.recipe == rhs.recipe
    }
}

class Matcher: NSObject, ObservableObject, SHSessionDelegate {
    @Published var result = MatchResult(mediaItem: nil, recipe: nil)
    
    private var session: SHSession?
    private let audioEngine = AVAudioEngine()

    func match(catalog: SHCustomCatalog) throws {
        
        session = SHSession(catalog: catalog)
        session?.delegate = self
        
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: audioEngine.inputNode.outputFormat(forBus: 0).sampleRate,
                                        channels: 1)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 2048, format: audioFormat) { [weak session] buffer, audioTime in
            session?.matchStreamingBuffer(buffer, at: audioTime)
            print("Listening... Buffer Time: \(audioTime)")

        }
        
        try AVAudioSession.sharedInstance().setCategory(.record)
        AVAudioSession.sharedInstance().requestRecordPermission() { [weak self] success in
            guard success, let self = self else { return }
            print("Starting audio engine for listening.")

            try? self.audioEngine.start()
        }
    }
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        DispatchQueue.main.async {
            
            // Find the Question from all the questions that we want to show.
            // In this example, use the last Question that's after the current match offset.
            let newRecipe = Recipe.allRecipes.last { recipe in
                (match.mediaItems.first?.predictedCurrentMatchOffset ?? 0) > recipe.offset
            }
            
            // Filter out similar Question objects in case of similar matches and update matchResult.
            if let currentRecipe = self.result.recipe, currentRecipe == newRecipe {
                return
            }
            print("Match found: \(newRecipe?.title ?? "No title")")

            self.result = MatchResult(mediaItem: match.mediaItems.first, recipe: newRecipe)
        }
    }
}
