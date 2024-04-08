/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The view model representing the main class content.
*/

import SwiftUI

struct EpisodeView: View {
    let recipe: Recipe?
    
    
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()
            ZStack(alignment: .bottom) {
                ZStack {
                    BoardView()
                    RecipeView1(recipe: recipe!)
                }
                
            }
        }
    }
    
    private struct BoardView: View {
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(Color.brown)
                        .frame(width: geometry.size.width, alignment: .center)
                        .ignoresSafeArea()
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 20)
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .stroke(Color.brown, style: StrokeStyle(lineWidth: 30))
                        .ignoresSafeArea()
                }
            }
        }
    }
    
    private struct BackgroundView: View {
        var body: some View {
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 200, y: 0))
                    path.addLine(to: CGPoint(x: 200, y: geometry.size.height))
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height))
                    path.move(to: CGPoint(x: geometry.size.width - 200, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width - 200, y: geometry.size.height))
                    path.move(to: CGPoint(x: 0, y: geometry.size.height / 3))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 3))
                    path.move(to: CGPoint(x: 0, y: 2 * geometry.size.height / 3))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 2 * geometry.size.height / 3))
                }.stroke(Color.green, lineWidth: 20)
            }
        }
    }
        
    struct EpisodeView_Previews: PreviewProvider {
        static let recipe =  Recipe(title: "Lamb Sfiha", offset: 1184, link: (URL(string: "https://www.hairybikers.com/recipes/view/lamb-sfiha") ?? URL(string: "www.google.com"))!, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"]
        )
        static var previews: some View {
            EpisodeView(recipe: recipe)
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
