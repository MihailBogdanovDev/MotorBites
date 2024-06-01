import SwiftUI
import FirebaseStorageUI
import Firebase
import SDWebImageSwiftUI

struct RecipeView: View {
    let recipe: Recipe
    @State private var showCookingGuide = false // State to control navigation
    @State private var showMapView = false
    @State private var selectedIngredient: Ingredient?

    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "2743A6").edgesIgnoringSafeArea(.all)
            
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
                        ForEach(recipe.ingridients, id: \.id) { ingredient in
                            Text(ingredient.name)
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                                .onTapGesture {
                                    self.selectedIngredient = ingredient
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                          self.showMapView = true
                                    };                                    print(selectedIngredient)
                                }
                        }
                    }
                    .padding([.horizontal, .top])
                    
                    Spacer()
                    
                    // Cook Button
                    Button(action: {
                        showCookingGuide = true
                    }) {
                        Text("Cook")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .sheet(isPresented: $showCookingGuide) {
                    // Pass the steps to the CookingGuideView
                    CookingGuideView(steps: recipe.steps)
                }
                .sheet(isPresented: $showMapView) {
                    
                    if let ingredient = selectedIngredient {
                        MapView(locationManager: LocationManager(), ingredient: ingredient)
                    }
                    else{
                        MapView(locationManager: LocationManager(), ingredient: Ingredient(name: "Chicken", types: [IngredientType.generic]))
                    }
                }
            }
            }
        }
    }
    
    
    struct RecipeView_Previews: PreviewProvider {
        static var previews: some View {
            RecipeView(recipe:  Recipe(title: "Lamb Sfiha", offset: 1184, time: "1h30m", budget: 30.23, description: "aaa", ingridients: Ingredient.lambSfiha,imageURL: (URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/syrian_flatbread_pizza_22452_16x9.jpg?alt=media&token=d6b95e12-46a8-478e-ad42-160aa150f98c"
                                                                                                                                                                                                                                                                                                                                                                ) ?? URL(string: "www.google.com"))!, steps: CookingStep.allCookingSteps)
            )}
    }

