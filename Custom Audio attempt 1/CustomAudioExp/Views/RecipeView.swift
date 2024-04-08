import SwiftUI

struct RecipeView1: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.title)
                .font(.largeTitle) // Makes the title large and prominent
                .fontWeight(.bold)
                .foregroundColor(.primary) // Adapts to dark/light mode
                .padding() // Adds some space around the text
            
            Link("View Recipe", destination: recipe.link)
                .font(.title2) // Slightly smaller font for the link
                .foregroundColor(.blue) // Standard link color
                .padding() // Adds some space around the link
                .background(Color(.systemGray6)) // Light background to highlight the link area
                .cornerRadius(10) // Rounds the corners of the background
                .shadow(radius: 3) // Adds a subtle shadow for depth
        }
        .padding() // Adds padding around the entire VStack content
    }
}

struct RecipeView1_Previews: PreviewProvider {
    static let recipe = Recipe(title: "Lamb Sfiha", offset: 1184, link: (URL(string: "https://www.hairybikers.com/recipes/view/lamb-sfiha") ?? URL(string: "www.google.com"))!, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"])
    static var previews: some View {
        RecipeView1(recipe: recipe)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
