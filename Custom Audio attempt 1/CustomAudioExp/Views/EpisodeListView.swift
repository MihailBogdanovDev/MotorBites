import SwiftUI

struct EpisodeListView: View {
    let currentEpisode: Episode?
    
    var body: some View {
        ZStack {
            BackgroundView()
            EpisodeList()
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Adjusting for dynamic sizing
            if let episode = currentEpisode {
                //CardView(title: episode.title, subtitle: episode.subtitle)
                    //.padding() // Add padding for better placement on iPhone
            }
        }
        .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 10)
    }
}

private struct EpisodeList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) { // Reduced spacing
            Text("Episodes")
                .foregroundColor(.blue)
                .font(.system(size: 30, weight: .black, design: .rounded)) // Adjusted font size
            ScrollView {
                ForEach(Episode.allEpisodes, id: \.id) { episode in
                    EpisodeCell(episode: episode)
                }
            }
        }
        .padding() // Adjusted padding for smaller screens
        .background(Color.white)
        .cornerRadius(24)
    }
}

private struct EpisodeCell: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) { // Adjusted spacing
            Text("EPISODE \(episode.number)")
                .foregroundColor(.yellow)
                .font(.system(size: 14, weight: .bold, design: .rounded)) // Adjusted font size
                .opacity(0.6)
                .padding(.top, 10)
                .padding(.leading, 5)
            Text(episode.title)
                .foregroundColor(.yellow)
                .font(.system(size: 18, weight: .bold, design: .rounded)) // Adjusted font size
                .padding(.bottom, 5)
                .padding(.leading, 5)
            Divider()
        }
    }
}

private struct BackgroundView: View {
    var body: some View {
        ZStack {
        
        }
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView(currentEpisode: nil)
            .previewDevice("iPhone 15") // Specify iPhone 15 for previews
            .previewInterfaceOrientation(.portrait) // Changed to portrait as it's more common for iPhone usage
    }
}
