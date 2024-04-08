import SwiftUI

struct CardView1: View {
    let title: String
    let subtitle: String
    let showBlur: Bool
    @Binding var visible: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            if showBlur {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                    .ignoresSafeArea()
                    .onTapGesture {
                        visible = false
                    }
            }
            VStack {
                Text(title)
                    .foregroundColor(.blue)
                    .font(.system(size: 40, weight: .black, design: .rounded)) // Reduced font size
                    .padding(.bottom, 10)
                    .padding([.leading, .trailing], 20) // Adjusted padding
                Text(subtitle)
                    .foregroundColor(.green)
                    .font(.system(size: 24, weight: .bold, design: .rounded)) // Reduced font size
                    .padding([.leading, .trailing], 20) // Adjusted padding
                    .padding(.bottom, 50) // Adjusted padding
            }
                .background(Color.white)
                .cornerRadius(24)
                .scaleEffect(isAnimating ? 1 : 0.95) // Adjusted scale effect for subtleness
                .animation(.spring(), value: isAnimating)
                .padding(.horizontal, 10) // Add some padding to ensure it doesn't touch the edges of the screen
        }.onAppear { isAnimating.toggle() }
        .onDisappear { visible = false }
    }
}

/*extension CardView {
    init(title: String, subtitle: String, visible: Binding<Bool> = .constant(false)) {
        self.title = title
        self.subtitle = subtitle
        self.showBlur = true
        _visible = visible
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "The Hairy Bikers Go West",
                 subtitle: "S01 E01",
                 visible: .constant(true))
    }
}
*/
