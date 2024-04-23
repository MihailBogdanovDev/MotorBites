import SwiftUI
import FirebaseStorageUI
import Firebase
import SDWebImageSwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack {
            // Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                // Content
                VStack(alignment: .leading, spacing: 0) {
                    NavigationLink(destination: ListenView(currentEpisode: nil)) {
                        Text("Back")
                            .foregroundColor(.white)
                            .padding()
                    }
                    // Display the image using WebImage from SDWebImageSwiftUI
                    WebImage(url: recipe.imageURL)
                           .resizable()
                           .indicator(.activity) // Activity indicator while loading
                           .transition(.fade(duration: 0.5)) // Fade Transition with duration
                           .aspectRatio(contentMode: .fill) // Maintain the aspect ratio and fill the frame
                           .frame(maxWidth: 400) // Use the maximum width available
                           .frame(height: 300) // Set a fixed height
                           .clipped()
                        
                        
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
            RecipeView(recipe:  Recipe(title: "Lamb Sfiha", offset: 1184, time: "1h30m", budget: 30.23, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing","Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"],imageURL: (URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/syrian_flatbread_pizza_22452_16x9.jpg?alt=media&token=d6b95e12-46a8-478e-ad42-160aa150f98c"
) ?? URL(string: "www.google.com"))!)
            )}
    }

