/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Extension for custom questions.
*/

import Foundation

extension Recipe {
    
    static let allRecipes = [
        Recipe(title: "Lamb Sfiha", offset: 1184, link: (URL(string: "https://www.hairybikers.com/recipes/view/lamb-sfiha") ?? URL(string: "www.google.com"))!, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"]),
        
        Recipe(title: "Chicken Balmoral", offset: 2350, link: URL(string: "https://scottishscran.com/balmoral-chicken-stuffed-with-haggis-recipe/")!, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"]),
        Recipe(title: "Salmon en croute", offset: 2896, link: URL(string: "https://www.pinterest.co.uk/pin/hairy-bikers-salmon-en-croute--1091982240884879759/")!, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"])
    ]
}
