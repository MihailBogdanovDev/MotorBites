import SwiftUI

struct EpisodeView1: View {
    let currentEpisode: Episode?

    let listenedRecipes: [Recipe] // Replace with your actual data source
    let otherRecipes: [Recipe] // Replace with your actual data source

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.black.edgesIgnoringSafeArea(.all)
                
                // Scrollable content
                ScrollView {
                    VStack(alignment: .leading) {
                        // Episode Image Placeholder
                        GeometryReader { geo in
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .frame(height: 200)
                        
                        // Episode Title
                        Text(currentEpisode?.title ?? "E1") // Replace with your episode title variable
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.top, .horizontal])
                        
                        // Listened Recipes Section
                        VStack(alignment: .leading) {
                            Text("Listened to recipes")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            
                            if let episode = currentEpisode {
                                ForEach(episode.recipes.indices, id: \.self) { index in
                                    let recipe = episode.recipes[index]
                                    
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        Text(recipe.title)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal)
                                    }
                                }
                            } else {
                                ForEach(listenedRecipes.indices, id: \.self) { index in
                                    let recipe = listenedRecipes[index]
                                    
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        Text(recipe.title)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                            
                        }
                        
                        // Other Recipes Section
                        VStack(alignment: .leading) {
                            Text("Other recipes in this episode")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                            
                            if let episode = currentEpisode {
                                ForEach(episode.recipes.indices, id: \.self) { index in
                                    let recipe = episode.recipes[index]
                                    
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        Text(recipe.title)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal)
                                    }
                                }
                            } else {
                                ForEach(otherRecipes.indices, id: \.self) { index in
                                    let recipe = otherRecipes[index]
                                    
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        Text(recipe.title)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                           
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

// Dummy data for previews
let sampleRecipe = Recipe(
    title: "Lamb Sfiha",
    offset: 1234,
    link: URL(string: "https://example.com")!,
    time: "1h30m",
    budget: 20.00,
    description: "Delicious Middle Eastern pie.",
    ingridients: ["Lamb", "Onion", "Pine Nuts"]
)

struct EpisodeView1_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView1(
            currentEpisode: Episode.allEpisodes.first,
            listenedRecipes: [sampleRecipe],
            otherRecipes: [sampleRecipe]
        )
    }
}
