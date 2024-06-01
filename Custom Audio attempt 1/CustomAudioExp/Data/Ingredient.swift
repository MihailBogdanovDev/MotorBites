import Foundation

enum IngredientType: String, Decodable, Hashable {
    case generic = "Generic"
    case asian = "Asian"
    case middleEastern = "Middle Eastern"
    case balkan = "Balkan"
    case hispanic = "Hispanic"
    case italian = "Italian"
    case african = "African"
    case organic = "Organic"
    case herbsAndSpices = "Herbs and Spices"
    case seafood = "Seafood"
    case meat = "Meat"
    case healthFoods = "Health Foods"
    case scottish = "Scottish"
}

struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let types: [IngredientType]
}
