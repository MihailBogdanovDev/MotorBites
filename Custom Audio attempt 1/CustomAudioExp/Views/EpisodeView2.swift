import SwiftUI
import SDWebImageSwiftUI

struct EpisodeView1: View {
    let currentEpisode: Episode?

    let listenedRecipes: [Recipe] // Replace with your actual data source
    let otherRecipes: [Recipe] // Replace with your actual data source

    var body: some View {
            ZStack {
                // Background
                Color.black.edgesIgnoringSafeArea(.all)
                
                // Scrollable content
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        NavigationLink(destination: ListenView(currentEpisode: nil)) {
                            Text("Back")
                                .foregroundColor(.white)
                                .padding()
                        } 

                        // Episode Image Placeholder
                        WebImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/hbgw_fbtwitter_post_tx.jpg?alt=media&token=516117b2-0b59-488b-bdc6-4b0fc4effe80"))
                               .resizable()
                               .indicator(.activity) // Activity indicator while loading
                               .transition(.fade(duration: 0.5)) // Fade Transition with duration
                               .aspectRatio(contentMode: .fill) // Maintain the aspect ratio and fill the frame
                               .frame(maxWidth: 380) // Use the maximum width available
                               .frame(height: 300) // Set a fixed height
                               .clipped()
                        
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


// Dummy data for previews
let sampleRecipe = Recipe(
    title: "Lamb Sfiha",
    offset: 1234,
    time: "1h30m",
    budget: 20.00,
    description: "Delicious Middle Eastern pie.",
    ingridients: Ingredient.lambSfiha,
    imageURL: URL(string: "gs://motorbites-1a543.appspot.com/syrian_flatbread_pizza_22452_16x9.jpg")!, steps: CookingStep.allCookingSteps
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
