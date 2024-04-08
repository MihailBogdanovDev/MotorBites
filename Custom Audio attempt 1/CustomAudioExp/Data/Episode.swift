/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model object that represents the different types of classes.
*/

import Foundation


struct Episode: Identifiable {
    let id = UUID()
    let title: String
    let number: Int
    let recipes: [Recipe]
    
    var subtitle: String {
        return "Episode \(number)"
    }
    
    static let allEpisodes = [
        Episode(title: "S01 E01", number: 1, recipes: Recipe.allRecipes),
        Episode(title: "S01 E02", number: 2, recipes: Recipe.allRecipes),
        Episode(title: "S01 E03", number: 3, recipes: Recipe.allRecipes),
        Episode(title: "S01 E04", number: 4, recipes: Recipe.allRecipes)
    ]
}

