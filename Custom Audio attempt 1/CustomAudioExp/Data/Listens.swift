import Foundation


struct Listens: Identifiable {
    let id = UUID()
    var episodes: [Episode]
    var recipes: [Recipe]
    
    init( ) {
        self.episodes = []
        self.recipes = []
    }

}


