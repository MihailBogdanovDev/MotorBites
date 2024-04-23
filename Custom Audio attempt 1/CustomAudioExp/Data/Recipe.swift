
import Foundation

struct Recipe:  Equatable, Comparable, Decodable, Hashable, Identifiable {
    let id = UUID()
    let title: String
    let offset: TimeInterval
    let time: String
    let budget: Double
    let description: String
    let ingridients: [String]
    let imageURL: URL
    
    
    init( title: String, offset: TimeInterval, time: String, budget: Double, description: String, ingridients: [String], imageURL: URL) {
        self.title = title
        self.offset = offset
        self.time = time
        self.budget = budget
        self.description = description
        self.ingridients = ingridients
        self.imageURL = imageURL
    }
    
    static func < (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.offset < rhs.offset
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.title == rhs.title && lhs.offset == rhs.offset
    }
    
}
