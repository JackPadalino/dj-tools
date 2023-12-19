import SwiftUI

struct Home: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(red: 0.0, green: 0.0, blue: 0.0).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    // NavigationLink to the OtherScreen
                    NavigationLink(destination: BpmFinder()) {
                        Text("BPM")
                            .bold()
                            .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 50))
                    }
                    .padding()
                    // NavigationLink to the OtherScreen
                    NavigationLink(destination: PitchFinder()) {
                        Text("Pitch")
                            .bold()
                            .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 50))
                    }
//                    .padding()
                }
//                .padding()
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(cornerRadius)
//            .overlay(
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .stroke(Color.white, lineWidth: 2)
//            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    Home()
}
