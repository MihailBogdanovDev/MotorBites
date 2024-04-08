/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model object that describes the question we show for the custom audio.
*/

import Foundation

struct Recipe:  Equatable, Comparable {
    let title: String
    let offset: TimeInterval
    let link: URL
    let time: String
    let budget: Double
    let description: String
    let ingridients: [String]
    
    
    init(title: String, offset: TimeInterval, link: URL, time: String, budget: Double, description: String, ingridients: [String]) {
        self.title = title
        self.offset = offset
        self.link = link
        self.time = time
        self.budget = budget
        self.description = description
        self.ingridients = ingridients
    }
    
    static func < (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.offset < rhs.offset
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.title == rhs.title && lhs.offset == rhs.offset
    }
    
}
