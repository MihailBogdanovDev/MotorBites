import SwiftUI

struct ListenView: View {

    let currentEpisode: Episode?

    
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
                Color.black.edgesIgnoringSafeArea(.all)
                
                // Main button and text
                VStack {
                    Spacer()
                    Button(action: {
                        // Action to perform on button tap
                    }) {
                        Image(systemName: "waveform.path.ecg") // Replace with your own custom image
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .padding(60)
                            .background(Color.black)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .shadow(color: .gray, radius: 10, x: 0, y: 4)
                    }
                    Text("Tap to Shazam")
                        .foregroundColor(.white)
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
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "fork.knife")
                    .foregroundColor(.blue)
                Text("My recipes")
                Spacer()
                Text("50")
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .foregroundColor(.white)
        .background(Color.black)
    }
}

struct RecentShazamsView: View {
    // Placeholder for recent shazam items
    let items = ["S1E1", "S1E2", "S1E3", "S1E4", "S1E5", "S1E6"]
    
    // This calculates the number of rows needed based on item count
    private var rowCount: Int {
        return (items.count + 1) / 2
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // Use a VStack to arrange rows vertically
            VStack {
                // Create rows
                ForEach(0..<rowCount, id: \.self) { rowIndex in
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
    let item: String
    
    var body: some View {
        VStack {
            Rectangle() // Replace with actual album artwork
                .fill(Color.blue)
                .frame(width: 150, height: 150)
                .cornerRadius(10)
            
            Text(item)
                .foregroundColor(.white)
                .padding([.top, .horizontal])
            
            Button("View") {
                // Action to play the shazam item
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
