import SwiftUI

struct Home: View {
    
    var body: some View {
        NavigationView {
            VStack {
                // NavigationLink to the OtherScreen
                NavigationLink(destination: BpmFinder()) {
                    Text("BPM Finder")
                }
                // NavigationLink to the OtherScreen
                NavigationLink(destination: PitchFinder()) {
                    Text("Pitch Finder")
                }
            }
            .padding()
        }
    }
}

#Preview {
    Home()
}
