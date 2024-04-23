/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model that is responsible for matching against the catalog and update the SwiftUI Views.
*/

import ShazamKit
import AVFAudio
import Combine
import FirebaseFirestore
import FirebaseCore

struct MatchResult: Equatable {
    let mediaItem: SHMatchedMediaItem?
    let recipe: Recipe?
    
    static func == (lhs: MatchResult, rhs: MatchResult) -> Bool {
        return lhs.recipe == rhs.recipe
    }
}

class Matcher: NSObject, ObservableObject, SHSessionDelegate {
    @Published var result = MatchResult(mediaItem: nil, recipe: nil)
    @Published var allRecipes: [Recipe] = []
    @Published var allEpisodes: [Episode] = []
    @Published var listens = Listens()
    // Add a property to control the listening state
      @Published var isListening = false


    override init() {
            super.init()
        }
    
    func fetchRecipes() {
            
       /* guard FirebaseApp.app() != nil else {
                    print("Firebase not initialized.")
                    return
                }
        
            let db = Firestore.firestore()
            db.collection("recipes").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var recipes: [Recipe] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        // Parse data to create Recipe objects and append them to the recipes array
                        // This is a simplification. You'll need to safely unwrap the optionals and
                        // handle parsing based on your Firestore structure.
                        if let title = data["name"] as? String,
                           let offset = data["offset"] as? TimeInterval,
                           let time = data["time"] as? String,
                           let budget = data["budget"] as? Double,
                           let description = data["description"] as? String,
                           let ingredients = data["ingredients"] as? [String],
                           let imageURLString = data["image"] as? String,
                           let imageURL = URL(string: imageURLString) {
                            let recipe = Recipe(title: title, offset: offset, time: time, budget: budget, description: description, ingridients: ingredients, imageURL: imageURL)
                            recipes.append(recipe)
                        }
                    }
                    DispatchQueue.main.async {
                        self.allRecipes = recipes
                    }
                }
            }*/
        self.allEpisodes = Episode.allEpisodes
        self.allRecipes=Recipe.allRecipes
        }
    
    private var session: SHSession?
    private let audioEngine = AVAudioEngine()
    
    func startListening(catalog: SHCustomCatalog) throws {
          guard !isListening else { return } // Avoid starting a new session if already listening

          isListening = true
          try match(catalog: catalog)
      }
    
    func stopListening() {
          audioEngine.inputNode.removeTap(onBus: 0)
          audioEngine.stop()
          isListening = false
      }


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
            // Check for matched recipes first
            let newRecipe = self.allRecipes.last { recipe in
                (match.mediaItems.first?.predictedCurrentMatchOffset ?? 0) > recipe.offset
            }
            
            if let newRecipe = newRecipe {
                self.listens.recipes.append(newRecipe)
                self.listens.episodes.append(self.allEpisodes.first ?? Episode(title: "did not work", number: 6, recipes: []))
                print("Match found: \(newRecipe.title)")
                self.result = MatchResult(mediaItem: match.mediaItems.first, recipe: newRecipe)
                self.stopListening()
            } else if let episodeNumber = match.mediaItems.first?.episode {
                // If no new recipe is found and there's an episode number, find the episode
                if let newEpisode = Episode.allEpisodes.first(where: { $0.number == episodeNumber }) {
                    self.listens.episodes.append(newEpisode)
                    print("Match found: Episode \(newEpisode.title)")
                    self.result = MatchResult(mediaItem: match.mediaItems.first, recipe: nil)
                    self.stopListening()
                }
            } else {
                print("No match found")
                self.result = MatchResult(mediaItem: nil, recipe: nil)
            }
        }
    }
}

