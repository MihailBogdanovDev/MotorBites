import Foundation

struct CookingStep: Identifiable, Hashable, Decodable {
    let id: UUID = UUID()
    let instruction: String
    let videoURL: URL?
}
