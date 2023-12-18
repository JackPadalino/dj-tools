import SwiftUI

class PitchManager: ObservableObject {
    @Published var range: String = ""
    @Published var startingBpm: String = ""
    @Published var targetBpm: String = ""
    @Published var pitchFinal: String = "Final Pitch"

    func getPitch() {
        if let rangeInt = Int(range),
           let startingBpmInt = Int(startingBpm),
           let targetBpmInt = Int(targetBpm),
           startingBpmInt != 0 {
            let result = Double(targetBpmInt - startingBpmInt) / (Double(startingBpmInt) * (Double(rangeInt) / 1000))
            pitchFinal = String(format: "%.2f", result)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        } else {
            // Handle cases where conversion fails or startingBpmInt is 0
            pitchFinal = "Error"
        }

    }

    func reset() {
        range = ""
        startingBpm = ""
        targetBpm = ""
        pitchFinal = "Final Pitch"

    }
}

struct PitchFinder: View {
    @StateObject var pitchManager = PitchManager()
    

    
    var body: some View {
        ZStack {
            Color.init(red: 1.0, green: 0.7529411764705882, blue: 0.0).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                TextField("Range", text: $pitchManager.range)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                //                .padding()
                
                TextField("Starting BPM", text: $pitchManager.startingBpm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                //                .padding()
                
                TextField("Target BPM", text: $pitchManager.targetBpm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
//                                .padding()
                
                Button("Submit") {
                    pitchManager.getPitch()
                }
                .buttonStyle(CustomButtonStyle(cornerRadius: 5, backgroundColor: Color.blue))
                .padding()
                
                
                Text("\(pitchManager.pitchFinal)")
                    .opacity(pitchManager.pitchFinal == "Final Pitch" ? 0 : 1)
                    .font(.system(size: 75))
                //                .padding()
                
                Text("Reset")
                    .bold()
                    .opacity(pitchManager.pitchFinal == "Final Pitch" ? 0 : 1)
                    .padding()
                    .foregroundColor(.white)
                    .onTapGesture {
                        pitchManager.reset()
                    }
                
            }
            .padding()
        }

    }
}

#Preview {
    PitchFinder()
}
