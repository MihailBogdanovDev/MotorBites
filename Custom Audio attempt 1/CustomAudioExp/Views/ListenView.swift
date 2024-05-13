import SwiftUI
import SDWebImageSwiftUI
import ShazamKit

struct ListenView: View {

    @EnvironmentObject var matcher: Matcher
    let currentEpisode: Episode?
    
    @State private var isListening = false
     @State private var animationAmount = 0.0
    
    // Initial state is set to be offscreen
   @State var searchText = ""
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0

    var body: some View {
        

        ZStack {
            if let episode = currentEpisode {
                EpisodeView1(
                    currentEpisode: currentEpisode,
                    listenedRecipes: [sampleRecipe],
                    otherRecipes: [sampleRecipe]
                )
                
            }
            else{
                // Background
                Color.white.edgesIgnoringSafeArea(.all)
                
                // Main button and text
                VStack {
                    Spacer()
                    Button(action: {
                       toggleListening()
                        
                    }) {
                        Image( "HairyBikersLogo") // Replace with your own custom image
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .shadow(color: .gray, radius: 10, x: 0, y: 4)
                            .scaleEffect(isListening ? 1.1 : 1.0) // Make the button a bit larger when listening
                            .rotationEffect(.degrees(animationAmount)) // Rotate button when listening
                    }
                    
                    Text("Tap to Shazam")
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    Spacer()
                }.ignoresSafeArea()
                
                //Bottom Sheet...
                
                //Setting up height for drag gesture
                
                GeometryReader{proxy -> AnyView in
                    
                    let height = proxy.frame(in: .global).height
                    
                    return AnyView(
                        
                        ZStack{
                            BlurView(style: .systemUltraThinMaterialDark)
                                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                            
                            VStack{
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 4)
                                    .padding(.top)
                                
                                HeaderView()
                                ContentListView()
                                RecentShazamsView()
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                        }
                            .offset(y:height-100)
                            .offset(y:offset)
                            .gesture(DragGesture().updating($gestureOffset, body: {
                                value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({value in
                                
                                let maxHeight = height-100
                                
                                withAnimation{
                                    //Logic for moving states
                                    //Up down or mid
                                    if -offset>100 && -offset < maxHeight/2{
                                        //Mid
                                        offset = -(maxHeight/3)
                                    }
                                    else if -offset>maxHeight/2{
                                        offset = -maxHeight
                                    }
                                    else{
                                        offset = 0
                                    }
                                }
                                //Storing offset
                                lastOffset=offset
                            }))
                        
                    )
                }.ignoresSafeArea(.all, edges: .bottom)
                
            }
            
        }
       
    }
    
    func toggleListening() {
           if isListening {
               matcher.stopListening()
               stopAnimation()
           } else {
               do {
                   if let catalog = try CatalogProvider.catalog() {
                       try matcher.match(catalog: catalog)
                   }
               } catch {
                   print(error)
               }
               startAnimation()
           }
           isListening.toggle()
       }
       
       func startAnimation() {
           withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
               animationAmount = 360
           }
       }
       
       func stopAnimation() {
           withAnimation {
               animationAmount = 0
           }
       }
    
    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }

}


struct BottomSheetView: View {
   

    var body: some View {
        VStack {
            Spacer()
            PullTab()
            HeaderView()
            ContentListView()
            RecentShazamsView()
        }
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
    func PullTab() -> some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 5)
            .foregroundColor(.gray)
            .padding(5)
    }
}

struct HeaderView: View {
    var body: some View {
        HStack{
            Text("My Listens")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            Spacer()
        }
    }
}

struct ContentListView: View {
    @EnvironmentObject var matcher: Matcher

    var body: some View {
        VStack {
            NavigationLink(destination: RecipesListView(matcher: matcher)) {
                HStack {
                    Image(systemName: "fork.knife")
                        .foregroundColor(.blue)
                    Text("My recipes")
                    Spacer()
                    Text(matcher.listens.recipes.count.description)
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
           
        }
        .foregroundColor(.black)
        .background(Color.white)
    }
}

struct RecentShazamsView: View {
    @EnvironmentObject var matcher: Matcher
    // Placeholder for recent shazam items
    //let items = ["S1E1", "S1E2", "S1E3", "S1E4", "S1E5", "S1E6"]
    
    // This calculates the number of rows needed based on item count
    private func rowCount(items: [Episode]) -> Int {
          return (items.count + 1) / 2
      }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            let items = matcher.listens.episodes
            // Use a VStack to arrange rows vertically
            VStack {
                // Create rows
                ForEach(0..<rowCount(items: items), id: \.self) { rowIndex in
                    HStack(spacing: 10) {
                        // Place two items per row
                        ForEach(0..<2, id: \.self) { columnIndex in
                            // Calculate the actual index in the items array
                            let index = rowIndex * 2 + columnIndex
                            // Check if the actual item exists
                            if index < items.count {
                                ShazamCardView(item: items[index])
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// Card view for a shazam item
struct ShazamCardView: View {
    @EnvironmentObject var matcher: Matcher
    //let item: String
    let item: Episode
    var body: some View {
        VStack {
            WebImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/hbgw_fbtwitter_post_tx.jpg?alt=media&token=516117b2-0b59-488b-bdc6-4b0fc4effe80"))
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            Text(item.title)
                .foregroundColor(.white)
                .padding([.top, .horizontal])
            
                NavigationLink(destination: EpisodeView1(
                    currentEpisode: item,
                    listenedRecipes: matcher.listens.recipes,
                    otherRecipes: Recipe.allRecipes
                ))
            {
                        
                Text("View")
                   
                }
            .foregroundColor(.white)
            .padding(.bottom)
        }
        .background(Color.red)
        .cornerRadius(10)
        .frame(width: 150, height: 250)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ShazamLikeView_Previews: PreviewProvider {
    static var previews: some View {
        ListenView(currentEpisode:nil)
    }
}
