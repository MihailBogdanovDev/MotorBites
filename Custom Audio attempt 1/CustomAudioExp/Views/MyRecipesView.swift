import SwiftUI
import SDWebImageSwiftUI

struct RecipesListView: View {
    
    @ObservedObject var matcher: Matcher

    init(matcher: Matcher) {
          self._matcher = ObservedObject(initialValue: matcher) // Providing initial value.
      }
      
    
    var body: some View {
         NavigationView {
             ZStack {
                 Color(hex: "2743A6") // Set the background color as a base layer
                     .edgesIgnoringSafeArea(.all) // Make sure it covers the whole navigation area

                 List {
                     ForEach(matcher.listens.recipes) { recipe in
                         NavigationLink(destination: RecipeView(recipe: recipe)) {
                             RecipeRow(recipe: recipe)
                         }
                         .listRowBackground(Color.clear) // Clear the default List row color
                     }
                 }
                 .navigationTitle("My Recipes")
                 .background(Color.clear) // Clear the default background of the List
             }
         }
     }
       
}

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            WebImage(url: recipe.imageURL)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                
                Text("S01E01") // Episode info, replace with actual data if needed
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(Date.now.description) // This is a placeholder date, replace with actual data if needed
                .font(.caption)
                .foregroundColor(.gray)
        }
                
    }
}

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        Text(recipe.title) // Detailed view logic here
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView(matcher: Matcher())
    }
}
