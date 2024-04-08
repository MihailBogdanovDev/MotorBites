import SwiftUI

struct RecipeView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            // Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                // Content
                VStack(alignment: .leading) {
                    // Recipe Image Placeholder
                    GeometryReader { geo in
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                    .frame(height: 300)
                    
                    // Recipe Title and Details
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.white)
                            Text(recipe.time)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.white)
                            Text(recipe.budget.description)
                                .foregroundColor(.white)
                        }
                        
                        Text("Ingredients")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        // Ingredients List
                        ForEach(recipe.ingridients, id: \.self) { ingredient in
                            Text(ingredient)
                                .foregroundColor(.gray)
                                .padding(.vertical, 2)
                        }
                    }
                    .padding([.horizontal, .top])
                    
                    Spacer()
                    
                    // Cook Button
                    Button(action: {
                        // Action for cook button
                    }) {
                        Text("Cook")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe:  Recipe(title: "Lamb Sfiha", offset: 1184, link: (URL(string: "https://www.hairybikers.com/recipes/view/lamb-sfiha") ?? URL(string: "www.google.com"))!, time: "1h30m", budget: 30.23, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing","Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"])
    )}
}
